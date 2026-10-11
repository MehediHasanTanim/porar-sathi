import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/fake_clock.dart';
import 'package:porar_sathi/features/exams/data/drift_exam_repository.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';
import 'package:porar_sathi/features/onboarding/data/drift_student_profile_repository.dart';
import 'package:porar_sathi/features/onboarding/domain/student_profile.dart';
import 'package:porar_sathi/features/planner/data/drift_availability_repository.dart';
import 'package:porar_sathi/features/planner/data/drift_planner_run_repository.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/revision/data/drift_revision_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/data/drift_study_session_repository.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:porar_sathi/features/study_plans/data/drift_study_plan_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/data/drift_subject_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/data/drift_chapter_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  late AppDatabase database;
  late FakeClock clock;
  late DriftStudyPlanRepository plans;
  late DriftSubjectRepository subjects;
  late DriftChapterRepository chapters;
  late DriftExamRepository exams;
  late DriftAvailabilityRepository availability;
  late DriftStudyTaskRepository tasks;
  late DriftStudySessionRepository sessions;
  late DriftRevisionRepository revisions;
  late DriftPlannerRunRepository runs;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    clock = FakeClock(DateTime(2026, 10, 11, 8));
    plans = DriftStudyPlanRepository(database);
    subjects = DriftSubjectRepository(database);
    chapters = DriftChapterRepository(database);
    exams = DriftExamRepository(database);
    availability = DriftAvailabilityRepository(database);
    tasks = DriftStudyTaskRepository(database);
    sessions = DriftStudySessionRepository(database);
    revisions = DriftRevisionRepository(database);
    runs = DriftPlannerRunRepository(database);
  });

  tearDown(() => database.close());

  test('saves a study plan and hides it after archive', () async {
    final saved = await plans.save(_plan(clock));
    expect(saved.startDate, clock.today());
    expect(saved.name, 'HSC Final');

    final visible = plans.watchAll();
    await expectLater(
      visible,
      emits(isA<List<StudyPlan>>().having((rows) => rows.single.name, 'name', 'HSC Final')),
    );

    await plans.archive(saved.id, archivedAt: clock.now());
    await expectLater(plans.watchAll(), emits(isEmpty));
    final archived = await plans.watchAll(includeArchived: true).first;
    expect(archived.single.status, StudyPlanStatus.archived);
  });

  test('rejects an unnamed study plan before writing', () async {
    await expectLater(
      plans.save(_plan(clock).copyWith(name: '  ')),
      throwsA(isA<ValidationException>()),
    );
    expect(await plans.watchAll(includeArchived: true).first, isEmpty);
  });

  test('stores the academic graph and rolls back a failed batch', () async {
    await DriftStudentProfileRepository(database).save(
      StudentProfile(
        id: 'student-1',
        displayName: ' Tanim ',
        studyLevel: StudyLevel.hsc,
        preferredLanguage: AppLanguage.bangla,
        createdAt: clock.now(),
        updatedAt: clock.now(),
      ),
    );
    final plan = await plans.save(_plan(clock));
    final subject = await subjects.save(_subject(clock, plan.id));
    final chapter = await chapters.save(_chapter(clock, subject.id));
    final exam = await exams.save(_exam(clock, plan.id));
    await plans.save(plan.copyWith(primaryExamId: exam.id, updatedAt: clock.now()));

    await exams.replaceSyllabus(exam.id, [
      ExamSyllabusItem(
        id: 'syllabus-1',
        examId: exam.id,
        subjectId: subject.id,
        chapterId: chapter.id,
        weight: 2,
        isRequired: true,
      ),
    ]);
    final syllabus = await exams.watchSyllabus(exam.id).first;
    expect(syllabus.single.chapterId, chapter.id);

    await availability.replaceWeek(plan.id, [
      _day(clock, plan.id, DateTime.saturday),
      _day(clock, plan.id, DateTime.sunday),
    ]);
    await availability.saveException(
      CalendarException(
        id: 'exception-1',
        studyPlanId: plan.id,
        date: clock.today(),
        exceptionType: CalendarExceptionType.holiday,
        isNoStudyDay: true,
        createdAt: clock.now(),
      ),
    );
    expect((await availability.watchWeek(plan.id).first), hasLength(2));
    final exception = (await availability.watchExceptions(plan.id).first).single;
    expect(exception.availableMinutesOverride, 0);

    final task = await tasks.save(_task(clock, plan.id, subject.id, chapter.id, exam.id));
    expect((await tasks.watchByPlanOnDate(plan.id, clock.today()).first).single.id, task.id);
    expect(
      (await tasks.watchByStatusOnDate(TaskStatus.planned, clock.today()).first).single.id,
      task.id,
    );

    final started = clock.now();
    await sessions.save(
      StudySession(
        id: 'session-1',
        studyTaskId: task.id,
        subjectId: subject.id,
        chapterId: chapter.id,
        startedAt: started,
        endedAt: started.add(const Duration(minutes: 40)),
        plannedMinutes: 45,
        actualMinutes: 40,
        completionPercent: 80,
        result: SessionResult.mostlyCompleted,
        createdAt: started,
      ),
      updatedTask: task.copyWith(
        status: TaskStatus.partiallyCompleted,
        completionPercent: 80,
        actualMinutes: 40,
        completedAt: started,
        updatedAt: started,
      ),
    );
    final updated = await tasks.findById(task.id);
    expect(updated?.status, TaskStatus.partiallyCompleted);
    expect((await sessions.watchBySubject(subject.id).first).single.actualMinutes, 40);

    await revisions.save(
      RevisionSchedule(
        id: 'revision-1',
        studyPlanId: plan.id,
        chapterId: chapter.id,
        sourceStudySessionId: 'session-1',
        revisionNumber: 1,
        dueDate: clock.today().add(const Duration(days: 3)),
        estimatedMinutes: 30,
        status: RevisionStatus.pending,
        createdAt: clock.now(),
      ),
    );
    final due = await revisions
        .watchDue(
          onOrBefore: clock.today().add(const Duration(days: 3)),
          status: RevisionStatus.pending,
        )
        .first;
    expect(due.single.chapterId, chapter.id);

    await runs.save(
      PlannerRun(
        id: 'run-1',
        studyPlanId: plan.id,
        trigger: PlannerTrigger.initialPlan,
        startedAt: clock.now(),
        completedAt: clock.now(),
        inputTaskCount: 1,
        outputTaskCount: 1,
        riskLevel: PlannerRiskLevel.low,
        expectedFinishDate: clock.today().add(const Duration(days: 20)),
        algorithmVersion: 'planner_v1',
      ),
    );
    expect((await runs.watchByPlan(plan.id).first).single.algorithmVersion, 'planner_v1');

    await expectLater(
      subjects.delete(subject.id),
      throwsA(isA<DatabaseException>()),
    );
    expect(await subjects.findById(subject.id), isNotNull);

    await expectLater(
      chapters.saveAll([
        _chapter(clock, subject.id).copyWith(id: 'chapter-2', title: 'Algebra'),
        _chapter(clock, subject.id).copyWith(id: 'chapter-3', title: ' '),
      ]),
      throwsA(isA<ValidationException>()),
    );
    expect(await chapters.findById('chapter-2'), isNull);

    await plans.delete(plan.id);
    expect(await plans.findById(plan.id), isNull);
    expect(await sessions.findById('session-1'), isNull);
    expect(await subjects.findById(subject.id), isNull);
  });

  test('presentation does not open Drift', () {
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where(
          (file) =>
              file.path.endsWith('.dart') && file.path.contains('${Platform.pathSeparator}presentation${Platform.pathSeparator}'),
        );
    expect(files, isNotEmpty);
    for (final file in files) {
      final source = file.readAsStringSync();
      expect(source.contains('app_database.dart'), isFalse, reason: file.path);
      expect(source.contains('package:drift/'), isFalse, reason: file.path);
    }
  });
}

StudyPlan _plan(FakeClock clock) {
  return newStudyPlan(
    id: 'plan-1',
    name: ' HSC Final ',
    startDate: clock.today(),
    createdAt: clock.now(),
  );
}

Subject _subject(FakeClock clock, String planId) {
  return Subject(
    id: 'subject-1',
    studyPlanId: planId,
    name: 'Physics',
    colorToken: 'physics',
    iconToken: 'physics',
    priority: Priority.high,
    difficulty: Difficulty.difficult,
    confidence: Confidence.low,
    status: SubjectStatus.active,
    sortOrder: 0,
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}

Chapter _chapter(FakeClock clock, String subjectId) {
  return Chapter(
    id: 'chapter-1',
    subjectId: subjectId,
    title: 'Mechanics',
    chapterNumber: 1,
    estimatedMinutes: 180,
    completedMinutes: 0,
    difficulty: Difficulty.moderate,
    confidence: Confidence.medium,
    priority: Priority.normal,
    examImportance: Priority.high,
    status: ChapterStatus.notStarted,
    sortOrder: 0,
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}

Exam _exam(FakeClock clock, String planId) {
  return Exam(
    id: 'exam-1',
    studyPlanId: planId,
    name: 'HSC Final',
    examType: ExamType.board,
    startDate: clock.today().add(const Duration(days: 40)),
    importance: Priority.critical,
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}

WeeklyAvailability _day(FakeClock clock, String planId, int weekday) {
  return WeeklyAvailability(
    id: 'day-$weekday',
    studyPlanId: planId,
    weekday: weekday,
    totalAvailableMinutes: weekday == DateTime.friday ? 0 : 180,
    isStudyDay: weekday != DateTime.friday,
    preferredStartTime: 20 * 60,
    preferredEndTime: 23 * 60,
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}

StudyTask _task(
  FakeClock clock,
  String planId,
  String subjectId,
  String chapterId,
  String examId,
) {
  return StudyTask(
    id: 'task-1',
    studyPlanId: planId,
    subjectId: subjectId,
    chapterId: chapterId,
    examId: examId,
    taskType: TaskType.newStudy,
    title: 'Mechanics',
    plannedDate: clock.today(),
    plannedStartTime: 20 * 60,
    plannedMinutes: 45,
    priorityScore: 70,
    isLocked: false,
    status: TaskStatus.planned,
    completionPercent: 0,
    source: TaskSource.manual,
    createdAt: clock.now(),
    updatedAt: clock.now(),
  );
}
