import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/data/drift_revision_repository.dart';
import 'package:porar_sathi/features/sessions/data/drift_study_session_repository.dart';
import 'package:porar_sathi/features/sessions/domain/study_completion.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/study_plans/data/drift_study_plan_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/data/drift_subject_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/data/drift_chapter_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  test('a failed completion leaves the previous session and task', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final today = DateTime(2026, 10, 11, 9);
    final sessions = DriftStudySessionRepository(database);
    final tasks = DriftStudyTaskRepository(database);
    final chapters = DriftChapterRepository(database);
    await _seed(database, today);
    await tasks.save(_task(today));
    await sessions.save(_session(id: 'kept', today: today));

    final plan = applyStudyCompletion(
      session: _session(id: 'new', today: today, chapterId: 'forces'),
      task: _task(today, status: TaskStatus.completed, completedAt: today),
      chapter: _chapter(today, id: 'forces'),
      subject: _subject(today),
      needsRevision: false,
      replanRemaining: false,
      now: today,
      studyPlanId: 'plan',
      followUpTaskId: 'follow-up',
      revisionId: 'revision',
    );

    await expectLater(sessions.commitCompletion(plan), throwsA(isA<DatabaseException>()));

    final storedTask = await tasks.findById('task');
    expect(storedTask!.status, TaskStatus.planned);
    expect(storedTask.completedAt, isNull);
    final storedChapter = await chapters.findById('motion');
    expect(storedChapter!.completedMinutes, 0);
    final history = await sessions.watchBySubject('physics').first;
    expect(history.map((session) => session.id), ['kept']);
  });

  test('completion updates the task, chapter, and revision together', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final today = DateTime(2026, 10, 11, 9);
    final sessions = DriftStudySessionRepository(database);
    final tasks = DriftStudyTaskRepository(database);
    final chapters = DriftChapterRepository(database);
    final revisions = DriftRevisionRepository(database);
    await _seed(database, today);
    await tasks.save(_task(today));

    final plan = applyStudyCompletion(
      session: _session(id: 'done', today: today, actual: 20, percent: 40),
      task: _task(today),
      chapter: _chapter(today),
      subject: _subject(today),
      needsRevision: true,
      replanRemaining: true,
      now: today,
      studyPlanId: 'plan',
      followUpTaskId: 'follow-up',
      revisionId: 'revision',
    );
    await sessions.commitCompletion(plan);

    final storedTask = await tasks.findById('task');
    expect(storedTask!.status, TaskStatus.partiallyCompleted);
    final followUp = await tasks.findById('follow-up');
    expect(followUp!.source, TaskSource.catchUp);
    expect(followUp.plannedDate, DateTime(2026, 10, 12));
    final chapter = await chapters.findById('motion');
    expect(chapter!.completedMinutes, 20);
    final due = await revisions.listDue('plan', DateTime(2026, 10, 13));
    expect(due.single.chapterId, 'motion');
    final stored = await sessions.findById('done');
    expect(stored!.actualMinutes, 20);
  });
}

Future<void> _seed(AppDatabase database, DateTime today) async {
  await DriftStudyPlanRepository(database).save(
    newStudyPlan(id: 'plan', name: 'HSC Final', startDate: today, createdAt: today),
  );
  await DriftSubjectRepository(database).save(_subject(today));
  final chapters = DriftChapterRepository(database);
  await chapters.save(_chapter(today));
  await chapters.save(_chapter(today, id: 'forces', title: 'Forces'));
}

StudyTask _task(DateTime at, {TaskStatus status = TaskStatus.planned, DateTime? completedAt}) {
  return StudyTask(
    id: 'task',
    studyPlanId: 'plan',
    subjectId: 'physics',
    chapterId: 'motion',
    taskType: TaskType.newStudy,
    title: 'Motion',
    plannedDate: at,
    plannedMinutes: 45,
    priorityScore: 10,
    isLocked: false,
    status: status,
    completionPercent: status == TaskStatus.completed ? 100 : 0,
    source: TaskSource.autoPlanner,
    createdAt: at,
    updatedAt: at,
    completedAt: completedAt,
  );
}

Chapter _chapter(DateTime at, {String id = 'motion', String title = 'Motion'}) {
  return Chapter(
    id: id,
    subjectId: 'physics',
    title: title,
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

StudySession _session({
  required String id,
  required DateTime today,
  String chapterId = 'motion',
  int actual = 10,
  int percent = 100,
}) {
  return StudySession(
    id: id,
    studyTaskId: 'task',
    subjectId: 'physics',
    chapterId: chapterId,
    startedAt: today,
    endedAt: today.add(const Duration(minutes: 20)),
    plannedMinutes: 45,
    actualMinutes: actual,
    completionPercent: percent,
    result: percent >= 100 ? SessionResult.fullyCompleted : SessionResult.partiallyCompleted,
    createdAt: today,
  );
}
