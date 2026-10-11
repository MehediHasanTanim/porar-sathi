import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/planner/application/commit_day_rollover.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/adaptive_plan.dart';
import 'package:porar_sathi/features/planner/domain/catch_up_plan.dart';
import 'package:porar_sathi/features/planner/domain/day_rollover.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/replan_diff.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/data/drift_revision_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_engine.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/study_plans/data/drift_study_plan_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/data/drift_subject_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/data/drift_chapter_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  final studied = DateTime(2026, 10, 11);

  test('revision dates stay before the exam and skip duplicates', () {
    expect(
      revisionDurationMinutes(
        studyMinutes: 45,
        revisionNumber: 1,
        confidence: Confidence.veryLow,
        examImportance: Priority.normal,
      ),
      17,
    );
    expect(
      revisionDurationMinutes(
        studyMinutes: 45,
        revisionNumber: 1,
        confidence: Confidence.low,
        examImportance: Priority.normal,
      ),
      14,
    );
    expect(
      revisionDurationMinutes(
        studyMinutes: 45,
        revisionNumber: 1,
        confidence: Confidence.high,
        examImportance: Priority.critical,
      ),
      11,
    );

    final schedule = buildRevisionSchedule(
      studyPlanId: 'plan',
      chapterId: 'motion',
      studiedOn: studied,
      studyMinutes: 45,
      confidence: Confidence.medium,
      examImportance: Priority.normal,
      examDate: DateTime(2026, 10, 14),
      existing: const [],
      createdAt: studied,
      ids: const ['r1', 'r2', 'r3'],
    );
    expect(schedule.map((item) => item.revisionNumber), [1, 3]);
    expect(schedule.first.dueDate, DateTime(2026, 10, 13));
    expect(schedule.last.dueDate, DateTime(2026, 10, 13));

    final again = buildRevisionSchedule(
      studyPlanId: 'plan',
      chapterId: 'motion',
      studiedOn: studied,
      studyMinutes: 45,
      confidence: Confidence.medium,
      examImportance: Priority.normal,
      examDate: DateTime(2026, 11, 1),
      existing: schedule,
      createdAt: studied,
      ids: const ['r4', 'r5', 'r6'],
    );
    expect(again.map((item) => item.revisionNumber), [2]);
    expect(again.single.dueDate, DateTime(2026, 10, 18));
  });

  test('rollover marks unfinished past tasks once', () {
    final today = DateTime(2026, 10, 12);
    final yesterday = DateTime(2026, 10, 11);
    final tasks = [
      _task(id: 'open', date: yesterday, status: TaskStatus.planned, percent: 40, minutes: 60),
      _task(id: 'active', date: yesterday, status: TaskStatus.inProgress),
      _task(id: 'today', date: today, status: TaskStatus.planned),
      _task(id: 'done', date: yesterday, status: TaskStatus.completed, completedAt: yesterday),
    ];
    final first = rollOverDay(
      tasks: tasks,
      revisions: [
        _revision(id: 'late', due: yesterday),
        _revision(id: 'soon', due: today),
      ],
      today: today,
      now: today,
    );
    expect(first.tasks.map((task) => task.id), ['open']);
    expect(first.tasks.single.status, TaskStatus.missed);
    expect(first.remainingMinutes, 36);
    expect(first.revisions.single.id, 'late');
    expect(first.revisions.single.status, RevisionStatus.overdue);

    final second = rollOverDay(
      tasks: [
        first.tasks.single,
        tasks[1],
        tasks[2],
        tasks[3],
      ],
      revisions: [first.revisions.single, _revision(id: 'soon', due: today)],
      today: today,
      now: today.add(const Duration(hours: 1)),
    );
    expect(second.changed, isFalse);
  });

  test('catch-up fills spare days before the exam', () {
    final plan = buildCatchUpPlan(
      backlogMinutes: 200,
      spare: [
        DaySpare(date: DateTime(2026, 10, 17), spareMinutes: 40),
        DaySpare(date: DateTime(2026, 10, 18), spareMinutes: 40),
        DaySpare(date: DateTime(2026, 10, 20), spareMinutes: 30),
        DaySpare(date: DateTime(2026, 10, 23), spareMinutes: 90),
        DaySpare(date: DateTime(2026, 11, 2), spareMinutes: 80),
      ],
      examDate: DateTime(2026, 11, 1),
    );
    expect(plan.days.map((day) => day.minutes), [40, 40, 30, 90]);
    expect(plan.recoveryDays, 4);
    expect(plan.unplacedMinutes, 0);
    expect(plan.risk, PlannerRiskLevel.none);
  });

  test('replan keeps protected tasks and previews a major date shift', () {
    final today = DateTime(2026, 10, 11);
    final existing = [
      _task(id: 'done', date: today, status: TaskStatus.completed, completedAt: today),
      _task(id: 'locked', date: DateTime(2026, 10, 12), locked: true),
      _task(id: 'manual', date: DateTime(2026, 10, 13), source: TaskSource.manual),
      _task(id: 'auto', date: DateTime(2026, 10, 12)),
    ];
    final proposed = [
      _task(id: 'auto-new', date: DateTime(2026, 10, 20), batch: 'run'),
    ];
    final diff = diffReplan(
      today: today,
      existing: existing,
      proposed: proposed,
      previousFinish: DateTime(2026, 10, 18),
      nextFinish: DateTime(2026, 10, 24),
      previousRisk: PlannerRiskLevel.low,
      nextRisk: PlannerRiskLevel.high,
    );
    expect(diff.moved.single.title, 'Motion');
    expect(diff.removed, isEmpty);
    expect(diff.added, isEmpty);
    expect(diff.major, isTrue);
    expect(taskIsPreserved(existing[1], today), isTrue);
    expect(taskIsPreserved(existing[2], today), isTrue);
    expect(taskIsReplaceable(existing[0], today), isFalse);
  });

  test('adaptive plan schedules missed remainder and a pending revision', () {
    final today = DateTime(2026, 10, 11);
    final missed = _task(
      id: 'missed',
      date: DateTime(2026, 10, 10),
      status: TaskStatus.missed,
      minutes: 30,
    );
    final plan = buildAdaptivePlan(
      studyPlanId: 'plan',
      runId: 'run',
      today: today,
      createdAt: today,
      trigger: PlannerTrigger.missedTask,
      existing: [missed],
      generated: const [],
      spare: [
        DaySpare(date: DateTime(2026, 10, 12), spareMinutes: 30),
        DaySpare(date: DateTime(2026, 10, 13), spareMinutes: 40),
      ],
      revisions: [_revision(id: 'rev', due: DateTime(2026, 10, 13))],
      subjectByChapter: const {'motion': 'physics'},
      backlog: [missed],
      ids: const ['catch', 'revision-task'],
      forecast: _forecast(today),
      examDate: DateTime(2026, 11, 1),
    );
    expect(plan.tasks.map((task) => task.source), [TaskSource.catchUp, TaskSource.revisionEngine]);
    expect(plan.tasks.first.plannedMinutes, 30);
    expect(plan.catchUp.unplacedMinutes, 0);
    expect(plan.diff.added, hasLength(2));
  });

  test('rollover is stored once and a bad replan keeps the old task', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final today = DateTime(2026, 10, 12, 8);
    final tasks = DriftStudyTaskRepository(database);
    final revisions = DriftRevisionRepository(database);
    await DriftStudyPlanRepository(database).save(
      newStudyPlan(id: 'plan', name: 'HSC Final', startDate: today, createdAt: today),
    );
    await DriftSubjectRepository(database).save(_subject(today));
    await DriftChapterRepository(database).save(_chapter(today));
    await tasks.save(
      _task(id: 'yesterday', date: DateTime(2026, 10, 11), createdAt: today),
    );

    final first = await commitDayRollover(
      tasks: tasks,
      revisions: revisions,
      planId: 'plan',
      today: today,
      now: today,
    );
    expect(first.tasks.single.status, TaskStatus.missed);
    final second = await commitDayRollover(
      tasks: tasks,
      revisions: revisions,
      planId: 'plan',
      today: today,
      now: today.add(const Duration(hours: 2)),
    );
    expect(second.changed, isFalse);
    final stored = await tasks.findById('yesterday');
    expect(stored!.updatedAt, today);

    await expectLater(
      tasks.applyAdaptivePlan(
        run: PlannerRun(
          id: 'bad',
          studyPlanId: 'plan',
          trigger: PlannerTrigger.userRequest,
          startedAt: today,
          completedAt: today,
          inputTaskCount: 1,
          outputTaskCount: 1,
          riskLevel: PlannerRiskLevel.none,
          algorithmVersion: 'planner_v1',
        ),
        tasks: [
          _task(
            id: 'bad-task',
            date: DateTime(2026, 10, 13),
            subjectId: 'missing',
            batch: 'bad',
            createdAt: today,
          ),
        ],
        today: today,
      ),
      throwsA(isA<DatabaseException>()),
    );
    expect((await tasks.findById('yesterday'))!.status, TaskStatus.missed);
    expect(await tasks.findById('bad-task'), isNull);
  });
}

StudyTask _task({
  required String id,
  required DateTime date,
  TaskStatus status = TaskStatus.planned,
  TaskSource source = TaskSource.autoPlanner,
  bool locked = false,
  int minutes = 45,
  int percent = 0,
  String subjectId = 'physics',
  String? batch,
  DateTime? completedAt,
  DateTime? createdAt,
}) {
  final at = createdAt ?? date;
  return StudyTask(
    id: id,
    studyPlanId: 'plan',
    subjectId: subjectId,
    chapterId: 'motion',
    taskType: TaskType.newStudy,
    title: 'Motion',
    plannedDate: date,
    plannedMinutes: minutes,
    priorityScore: 10,
    isLocked: locked,
    status: status,
    completionPercent: percent,
    source: source,
    generationBatchId: batch,
    createdAt: at,
    updatedAt: at,
    completedAt: completedAt,
  );
}

RevisionSchedule _revision({required String id, required DateTime due}) {
  return RevisionSchedule(
    id: id,
    studyPlanId: 'plan',
    chapterId: 'motion',
    revisionNumber: id == 'rev' ? 1 : 1,
    dueDate: due,
    estimatedMinutes: 20,
    status: RevisionStatus.pending,
    createdAt: due,
  );
}

PlanForecast _forecast(DateTime today) {
  return PlanForecast(
    expectedFinishDate: today,
    examDate: DateTime(2026, 11, 1),
    daysBeforeExam: 21,
    revisionBufferDays: 7,
    pace: StudyPace.onTrack,
    risk: PlannerRiskLevel.none,
    requiredMinutes: 50,
    availableMinutes: 70,
    shortfallMinutes: 0,
    unscheduledMinutes: 0,
    averageDailyMinutes: 25,
    suggestions: const [],
  );
}

Subject _subject(DateTime at) {
  return Subject(
    id: 'physics',
    studyPlanId: 'plan',
    name: 'Physics',
    colorToken: 'blue',
    iconToken: 'science',
    priority: Priority.normal,
    difficulty: Difficulty.moderate,
    confidence: Confidence.medium,
    status: SubjectStatus.active,
    sortOrder: 0,
    createdAt: at,
    updatedAt: at,
  );
}

Chapter _chapter(DateTime at) {
  return Chapter(
    id: 'motion',
    subjectId: 'physics',
    title: 'Motion',
    estimatedMinutes: 60,
    completedMinutes: 0,
    difficulty: Difficulty.moderate,
    confidence: Confidence.low,
    priority: Priority.normal,
    examImportance: Priority.normal,
    status: ChapterStatus.notStarted,
    sortOrder: 0,
    createdAt: at,
    updatedAt: at,
  );
}
