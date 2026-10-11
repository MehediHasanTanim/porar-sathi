import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/fake_clock.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_archive.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_document.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/progress/domain/progress_calculator.dart';
import 'package:porar_sathi/features/study_plans/data/drift_study_plan_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/data/drift_subject_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/data/drift_chapter_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  final today = DateTime(2026, 10, 10);

  test('a typical plan generates in under a second', () {
    final source = _input(
      today: today,
      subjectCount: 4,
      chaptersPerSubject: 6,
      minutes: 45,
      examDays: 40,
    );
    final watch = Stopwatch()..start();
    final result = generatePlan(source, runId: 'typical', createdAt: today);
    watch.stop();
    expect(result.tasks, isNotEmpty);
    expect(watch.elapsedMilliseconds, lessThan(1000));
  });

  test('a large plan and a replan stay within a few seconds', () {
    final source = _input(
      today: today,
      subjectCount: 8,
      chaptersPerSubject: 12,
      minutes: 90,
      examDays: 80,
    );
    final first = Stopwatch()..start();
    final original = generatePlan(source, runId: 'large', createdAt: today);
    first.stop();
    final second = Stopwatch()..start();
    final replanned = generatePlan(
      source,
      runId: 'large-again',
      createdAt: today.add(const Duration(hours: 1)),
      trigger: PlannerTrigger.userRequest,
    );
    second.stop();
    expect(original.tasks, isNotEmpty);
    expect(replanned.tasks, hasLength(original.tasks.length));
    expect(first.elapsedMilliseconds, lessThan(5000));
    expect(second.elapsedMilliseconds, lessThan(5000));
  });

  test('today lookup, weekly summary, and backup stay quick', () async {
    final clock = FakeClock(today);
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final plan = await DriftStudyPlanRepository(database).save(
      newStudyPlan(
        id: 'plan',
        name: 'HSC Final',
        startDate: today,
        createdAt: today,
      ),
    );
    final subject = await DriftSubjectRepository(database).save(
      Subject(
        id: 'physics',
        studyPlanId: plan.id,
        name: 'Physics',
        colorToken: 'physics',
        iconToken: 'physics',
        priority: Priority.normal,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        status: SubjectStatus.active,
        sortOrder: 0,
        createdAt: today,
        updatedAt: today,
      ),
    );
    final chapter = await DriftChapterRepository(database).save(
      Chapter(
        id: 'chapter',
        subjectId: subject.id,
        title: 'Motion',
        estimatedMinutes: 60,
        completedMinutes: 0,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        priority: Priority.normal,
        examImportance: Priority.normal,
        status: ChapterStatus.notStarted,
        sortOrder: 0,
        createdAt: today,
        updatedAt: today,
      ),
    );
    final taskRepository = DriftStudyTaskRepository(database);
    await taskRepository.saveAll([
      for (var index = 0; index < 40; index++)
        StudyTask(
          id: 'task-$index',
          studyPlanId: plan.id,
          subjectId: subject.id,
          chapterId: chapter.id,
          taskType: TaskType.newStudy,
          title: 'Motion $index',
          plannedDate: today.add(Duration(days: index == 0 ? 0 : 1)),
          plannedMinutes: 30,
          priorityScore: 10,
          isLocked: false,
          status: TaskStatus.planned,
          completionPercent: 0,
          source: TaskSource.autoPlanner,
          createdAt: today,
          updatedAt: today,
        ),
    ]);

    final todayWatch = Stopwatch()..start();
    final todays = await taskRepository.watchByPlanOnDate(plan.id, today).first;
    todayWatch.stop();
    expect(todays, hasLength(1));
    expect(todayWatch.elapsedMilliseconds, lessThan(200));

    final weekWatch = Stopwatch()..start();
    final week = summarizeWeek(
      today: today,
      tasks: await taskRepository.listByPlan(plan.id),
      sessions: const [],
      chapters: [chapter],
      revisions: const [],
      remainingBySubject: {'physics': 60},
    );
    weekWatch.stop();
    expect(week.targetMinutes, greaterThan(0));
    expect(weekWatch.elapsedMilliseconds, lessThan(200));

    final backupWatch = Stopwatch()..start();
    final file = await encodeBackup(
      payload: emptyBackupPayload(),
      appVersion: backupAppVersion,
      createdAt: clock.now(),
      locale: 'en',
      devicePlatform: 'test',
    );
    backupWatch.stop();
    expect(file, isNotEmpty);
    expect(backupWatch.elapsedMilliseconds, lessThan(1000));
  });
}

PlanningInput _input({
  required DateTime today,
  required int subjectCount,
  required int chaptersPerSubject,
  required int minutes,
  required int examDays,
}) {
  final subjects = [
    for (var index = 0; index < subjectCount; index++)
      Subject(
        id: 'subject-$index',
        studyPlanId: 'plan',
        name: 'Subject $index',
        colorToken: 'blue',
        iconToken: 'science',
        priority: Priority.normal,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        status: SubjectStatus.active,
        sortOrder: index,
        createdAt: today,
        updatedAt: today,
      ),
  ];
  final chapters = [
    for (final subject in subjects)
      for (var index = 0; index < chaptersPerSubject; index++)
        Chapter(
          id: '${subject.id}-ch-$index',
          subjectId: subject.id,
          title: 'Chapter $index',
          estimatedMinutes: minutes,
          completedMinutes: 0,
          difficulty: Difficulty.moderate,
          confidence: Confidence.medium,
          priority: Priority.normal,
          examImportance: Priority.normal,
          status: ChapterStatus.notStarted,
          sortOrder: index,
          createdAt: today,
          updatedAt: today,
        ),
  ];
  return PlanningInput(
    today: today,
    plan: newStudyPlan(
      id: 'plan',
      name: 'HSC Final',
      startDate: today,
      createdAt: today,
    ).copyWith(primaryExamId: 'exam'),
    subjects: subjects,
    chapters: chapters,
    exams: [
      Exam(
        id: 'exam',
        studyPlanId: 'plan',
        name: 'Board',
        examType: ExamType.board,
        startDate: today.add(Duration(days: examDays)),
        importance: Priority.high,
        createdAt: today,
        updatedAt: today,
      ),
    ],
    syllabus: [
      for (final chapter in chapters)
        ExamSyllabusItem(
          id: 'map-${chapter.id}',
          examId: 'exam',
          subjectId: chapter.subjectId,
          chapterId: chapter.id,
          weight: 1,
          isRequired: true,
        ),
    ],
    week: [
      for (var weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++)
        WeeklyAvailability(
          id: 'day-$weekday',
          studyPlanId: 'plan',
          weekday: weekday,
          totalAvailableMinutes: 180,
          isStudyDay: true,
          createdAt: today,
          updatedAt: today,
        ),
    ],
    exceptions: const [],
    lockedTasks: const [],
    existingTasks: const [],
  );
}
