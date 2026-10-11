import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/sessions/domain/study_completion.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/sessions/domain/today_dashboard.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  final now = DateTime(2026, 10, 11, 10);

  test('partial completion keeps the original task and plans the remainder', () {
    final plan = applyStudyCompletion(
      session: _session(result: SessionResult.partiallyCompleted, percent: 40, actual: 20),
      task: _task(),
      chapter: _chapter(estimated: 60, completed: 0),
      subject: _subject(),
      needsRevision: true,
      replanRemaining: true,
      now: now,
      studyPlanId: 'plan',
      followUpTaskId: 'follow-up',
      revisionId: 'revision',
    );

    expect(plan.task!.id, 'task');
    expect(plan.task!.status, TaskStatus.partiallyCompleted);
    expect(plan.task!.completedAt, now);
    expect(plan.chapter!.completedMinutes, 20);
    expect(plan.chapter!.status, ChapterStatus.inProgress);
    expect(plan.remainingMinutes, 40);
    expect(plan.followUpTask!.id, 'follow-up');
    expect(plan.followUpTask!.source, TaskSource.catchUp);
    expect(plan.followUpTask!.plannedMinutes, 40);
    expect(plan.followUpTask!.plannedDate, DateTime(2026, 10, 12));
    expect(plan.followUpTask!.isLocked, isFalse);
    expect(plan.revision!.dueDate, DateTime(2026, 10, 13));
    expect(plan.revision!.estimatedMinutes, 20);
    expect(plan.revision!.revisionNumber, 1);
    expect(plan.subject!.confidence, Confidence.high);
  });

  test('a missed session does not change the chapter', () {
    final plan = applyStudyCompletion(
      session: _session(result: SessionResult.couldNotStudy, percent: 0, actual: 0),
      task: _task(),
      chapter: _chapter(estimated: 30, completed: 10),
      subject: _subject(),
      needsRevision: true,
      replanRemaining: true,
      now: now,
      studyPlanId: 'plan',
      followUpTaskId: 'follow-up',
      revisionId: 'revision',
    );

    expect(plan.task!.status, TaskStatus.missed);
    expect(plan.task!.completedAt, isNull);
    expect(plan.chapter, isNull);
    expect(plan.followUpTask, isNull);
    expect(plan.revision, isNull);
    expect(plan.subject, isNull);
  });

  test('finishing the estimate marks the chapter complete', () {
    final plan = applyStudyCompletion(
      session: _session(result: SessionResult.fullyCompleted, percent: 100, actual: 30),
      task: _task(),
      chapter: _chapter(estimated: 30, completed: 10),
      subject: _subject(),
      needsRevision: false,
      replanRemaining: true,
      now: now,
      studyPlanId: 'plan',
      followUpTaskId: 'follow-up',
      revisionId: 'revision',
    );

    expect(plan.task!.status, TaskStatus.completed);
    expect(plan.chapter!.status, ChapterStatus.completed);
    expect(plan.chapter!.completedMinutes, 30);
    expect(plan.remainingMinutes, 0);
    expect(plan.followUpTask, isNull);
  });

  test('completed minutes never go past the estimate', () {
    final plan = applyStudyCompletion(
      session: _session(result: SessionResult.fullyCompleted, percent: 100, actual: 90),
      task: _task(),
      chapter: _chapter(estimated: 30, completed: 10),
      subject: null,
      needsRevision: false,
      replanRemaining: false,
      now: now,
      studyPlanId: 'plan',
      followUpTaskId: 'follow-up',
      revisionId: 'revision',
    );

    expect(plan.chapter!.completedMinutes, 30);
    expect(plan.remainingMinutes, 0);
  });

  test('syllabus percent skips skipped chapters', () {
    final percent = syllabusCompletionPercent([
      _chapter(estimated: 100, completed: 50),
      _chapter(estimated: 40, completed: 0, status: ChapterStatus.skipped, id: 'skip'),
    ]);
    expect(percent, 50);
    expect(backlogMinutes([_task(planned: 45, actual: 15)]), 30);
  });
}

StudySession _session({
  required SessionResult result,
  required int percent,
  required int actual,
}) {
  return StudySession(
    id: 'session',
    studyTaskId: 'task',
    subjectId: 'physics',
    chapterId: 'motion',
    startedAt: DateTime(2026, 10, 11, 9),
    endedAt: DateTime(2026, 10, 11, 10),
    plannedMinutes: 45,
    actualMinutes: actual,
    completionPercent: percent,
    result: result,
    confidenceAfter: result == SessionResult.couldNotStudy ? null : Confidence.high,
    createdAt: DateTime(2026, 10, 11, 10),
  );
}

StudyTask _task({int planned = 45, int? actual}) {
  final at = DateTime(2026, 10, 11);
  return StudyTask(
    id: 'task',
    studyPlanId: 'plan',
    subjectId: 'physics',
    chapterId: 'motion',
    taskType: TaskType.newStudy,
    title: 'Motion',
    plannedDate: at,
    plannedMinutes: planned,
    actualMinutes: actual,
    priorityScore: 10,
    isLocked: false,
    status: TaskStatus.planned,
    completionPercent: 0,
    source: TaskSource.autoPlanner,
    createdAt: at,
    updatedAt: at,
  );
}

Chapter _chapter({
  required int estimated,
  required int completed,
  ChapterStatus status = ChapterStatus.notStarted,
  String id = 'motion',
}) {
  final at = DateTime(2026, 10, 11);
  return Chapter(
    id: id,
    subjectId: 'physics',
    title: 'Motion',
    estimatedMinutes: estimated,
    completedMinutes: completed,
    difficulty: Difficulty.moderate,
    confidence: Confidence.low,
    priority: Priority.normal,
    examImportance: Priority.normal,
    status: status,
    sortOrder: 0,
    createdAt: at,
    updatedAt: at,
  );
}

Subject _subject() {
  final at = DateTime(2026, 10, 11);
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
