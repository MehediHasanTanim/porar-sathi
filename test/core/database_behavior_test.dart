import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/fake_clock.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/sessions/data/drift_study_session_repository.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
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
  late DriftStudyTaskRepository tasks;
  late DriftStudySessionRepository sessions;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    clock = FakeClock(DateTime(2026, 10, 11, 8));
    plans = DriftStudyPlanRepository(database);
    subjects = DriftSubjectRepository(database);
    chapters = DriftChapterRepository(database);
    tasks = DriftStudyTaskRepository(database);
    sessions = DriftStudySessionRepository(database);
  });

  tearDown(() => database.close());

  test('create, update, and read a chapter', () async {
    final plan = await plans.save(_plan(clock));
    final subject = await subjects.save(_subject(clock, plan.id));
    final saved = await chapters.save(_chapter(clock, subject.id));
    final renamed = await chapters.save(
      saved.copyWith(title: 'Algebra', updatedAt: clock.now()),
    );
    expect(renamed.title, 'Algebra');
    expect((await chapters.findById(saved.id))?.title, 'Algebra');
    expect(await chapters.listByPlan(plan.id), hasLength(1));
  });

  test('a failed transaction does not keep the inserted row', () async {
    await expectLater(
      database.transaction(() async {
        await database
            .into(database.studentProfiles)
            .insert(
              StudentProfilesCompanion.insert(
                id: 'student-1',
                displayName: 'Tanim',
                studyLevel: 'HSC',
                preferredLanguage: 'en',
                createdAt: clock.now(),
                updatedAt: clock.now(),
              ),
            );
        throw StateError('stop');
      }),
      throwsA(isA<StateError>()),
    );
    expect(await database.select(database.studentProfiles).get(), isEmpty);
  });

  test('a chapter cannot be saved for a missing subject', () async {
    await expectLater(
      chapters.save(_chapter(clock, 'missing-subject')),
      throwsA(isA<DatabaseException>()),
    );
    expect(await database.select(database.chapters).get(), isEmpty);
  });

  test('deleting a plan cascades subjects, chapters, and tasks', () async {
    final plan = await plans.save(_plan(clock));
    final subject = await subjects.save(_subject(clock, plan.id));
    final chapter = await chapters.save(_chapter(clock, subject.id));
    await tasks.save(_task(clock, plan.id, subject.id, chapter.id));

    await plans.delete(plan.id);

    expect(await database.select(database.subjects).get(), isEmpty);
    expect(await database.select(database.chapters).get(), isEmpty);
    expect(await database.select(database.studyTasks).get(), isEmpty);
    expect(await plans.findById(plan.id), isNull);
  });

  test(
    'a subject with study history cannot be deleted until history goes',
    () async {
      final plan = await plans.save(_plan(clock));
      final subject = await subjects.save(_subject(clock, plan.id));
      final chapter = await chapters.save(_chapter(clock, subject.id));
      await sessions.save(
        StudySession(
          id: 'session-1',
          subjectId: subject.id,
          chapterId: chapter.id,
          startedAt: clock.now(),
          endedAt: clock.now(),
          plannedMinutes: 40,
          actualMinutes: 40,
          completionPercent: 100,
          result: SessionResult.fullyCompleted,
          createdAt: clock.now(),
        ),
      );

      await expectLater(
        subjects.delete(subject.id),
        throwsA(isA<DatabaseException>()),
      );
      await expectLater(
        database.customUpdate("DELETE FROM subjects WHERE id = 'subject-1'"),
        throwsA(isA<SqliteException>()),
      );
      expect(await subjects.findById(subject.id), isNotNull);
      expect(await chapters.findById(chapter.id), isNotNull);
    },
  );

  test('deleting a subject removes its chapters', () async {
    final plan = await plans.save(_plan(clock));
    final subject = await subjects.save(_subject(clock, plan.id));
    await chapters.save(_chapter(clock, subject.id));

    await subjects.delete(subject.id);

    expect(await database.select(database.chapters).get(), isEmpty);
  });

  test('archiving a plan hides it from the active list', () async {
    final plan = await plans.save(_plan(clock));
    await plans.archive(plan.id, archivedAt: clock.now());
    expect(await plans.watchAll().first, isEmpty);
    final stored = await plans.watchAll(includeArchived: true).first;
    expect(stored.single.status, StudyPlanStatus.archived);
  });

  test('a date query returns only tasks planned that day', () async {
    final plan = await plans.save(_plan(clock));
    final subject = await subjects.save(_subject(clock, plan.id));
    final chapter = await chapters.save(_chapter(clock, subject.id));
    await tasks.save(_task(clock, plan.id, subject.id, chapter.id));
    await tasks.save(
      _task(clock, plan.id, subject.id, chapter.id).copyWith(
        id: 'task-2',
        plannedDate: clock.today().add(const Duration(days: 1)),
      ),
    );

    final today = await tasks.watchByPlanOnDate(plan.id, clock.today()).first;
    expect(today.map((task) => task.id), ['task-1']);
  });
}

StudyPlan _plan(FakeClock clock) {
  return newStudyPlan(
    id: 'plan-1',
    name: 'HSC Final',
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

StudyTask _task(
  FakeClock clock,
  String planId,
  String subjectId,
  String chapterId,
) {
  return StudyTask(
    id: 'task-1',
    studyPlanId: planId,
    subjectId: subjectId,
    chapterId: chapterId,
    taskType: TaskType.newStudy,
    title: 'Mechanics',
    plannedDate: clock.today(),
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
