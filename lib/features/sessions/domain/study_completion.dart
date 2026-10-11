import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_engine.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

/// Writes produced by one finished study session.
final class StudyCompletionPlan {
  const StudyCompletionPlan({
    required this.session,
    this.task,
    this.followUpTask,
    this.chapter,
    this.subject,
    this.revisions = const [],
  });

  final StudySession session;
  final StudyTask? task;
  final StudyTask? followUpTask;
  final Chapter? chapter;
  final Subject? subject;
  final List<RevisionSchedule> revisions;

  RevisionSchedule? get revision => revisions.isEmpty ? null : revisions.first;

  int get remainingMinutes {
    final current = chapter;
    if (current == null) {
      return 0;
    }
    final left = current.estimatedMinutes - current.completedMinutes;
    return left < 0 ? 0 : left;
  }
}

/// Updates the task and chapter without deleting the original task.
StudyCompletionPlan applyStudyCompletion({
  required StudySession session,
  StudyTask? task,
  Chapter? chapter,
  Subject? subject,
  required bool needsRevision,
  required bool replanRemaining,
  required DateTime now,
  required String studyPlanId,
  required String followUpTaskId,
  required String revisionId,
  List<String> moreRevisionIds = const [],
  List<RevisionSchedule> existingRevisions = const [],
  DateTime? examDate,
  RevisionPolicy revisionPolicy = RevisionPolicy.standard,
}) {
  final missed = session.result == SessionResult.couldNotStudy;
  final finished = !missed &&
      (session.result == SessionResult.fullyCompleted ||
          session.result == SessionResult.mostlyCompleted ||
          session.completionPercent >= 100);
  final updatedTask = task == null
      ? null
      : task.copyWith(
          status: missed
              ? TaskStatus.missed
              : finished
              ? TaskStatus.completed
              : TaskStatus.partiallyCompleted,
          completionPercent: missed ? 0 : session.completionPercent,
          actualMinutes: session.actualMinutes,
          completedAt: missed ? null : now,
          updatedAt: now,
        );

  Chapter? updatedChapter;
  if (chapter != null && !missed) {
    final added = chapter.completedMinutes + session.actualMinutes;
    final completedMinutes = added < 0
        ? 0
        : (added > chapter.estimatedMinutes ? chapter.estimatedMinutes : added);
    final chapterDone = finished && completedMinutes >= chapter.estimatedMinutes;
    updatedChapter = chapter.copyWith(
      completedMinutes: completedMinutes,
      status: chapterDone ? ChapterStatus.completed : ChapterStatus.inProgress,
      confidence: session.confidenceAfter ?? chapter.confidence,
      completedAt: chapterDone ? now : null,
      updatedAt: now,
    );
  }

  final updatedSubject = subject == null || session.confidenceAfter == null
      ? null
      : subject.copyWith(confidence: session.confidenceAfter!, updatedAt: now);

  final remaining = updatedChapter == null
      ? 0
      : updatedChapter.estimatedMinutes - updatedChapter.completedMinutes;
  final safeRemaining = remaining < 0 ? 0 : remaining;
  StudyTask? followUp;
  if (replanRemaining &&
      updatedTask != null &&
      updatedTask.status == TaskStatus.partiallyCompleted &&
      safeRemaining > 0) {
    final minutes = safeRemaining > 240 ? 240 : safeRemaining;
    followUp = updatedTask.copyWith(
      id: followUpTaskId,
      plannedDate: calendarDate(now).add(const Duration(days: 1)),
      plannedMinutes: minutes,
      actualMinutes: null,
      status: TaskStatus.planned,
      completionPercent: 0,
      source: TaskSource.catchUp,
      isLocked: false,
      generationBatchId: null,
      completedAt: null,
      createdAt: now,
      updatedAt: now,
    );
  }

  final revisions = needsRevision && updatedChapter != null && !missed
      ? buildRevisionSchedule(
          studyPlanId: studyPlanId,
          chapterId: updatedChapter.id,
          studiedOn: now,
          studyMinutes: session.plannedMinutes,
          confidence: session.confidenceAfter ?? updatedChapter.confidence,
          examImportance: updatedChapter.examImportance,
          examDate: examDate,
          existing: existingRevisions,
          createdAt: now,
          ids: [revisionId, ...moreRevisionIds],
          sourceStudySessionId: session.id,
          policy: revisionPolicy,
        )
      : const <RevisionSchedule>[];

  return StudyCompletionPlan(
    session: session,
    task: updatedTask,
    followUpTask: followUp,
    chapter: updatedChapter,
    subject: updatedSubject,
    revisions: revisions,
  );
}
