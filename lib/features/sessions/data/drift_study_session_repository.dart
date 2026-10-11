import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/domain/study_completion.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/features/sessions/domain/study_session_repository.dart';

final class DriftStudySessionRepository implements StudySessionRepository {
  DriftStudySessionRepository(this._database);

  final AppDatabase _database;

  @override
  Future<StudySession?> findById(String id) async {
    final row = await (_database.select(_database.studySessions)
          ..where((session) => session.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<List<StudySession>> watchBySubject(String subjectId) {
    final query = _database.select(_database.studySessions)
      ..where((session) => session.subjectId.equals(subjectId))
      ..orderBy([(session) => OrderingTerm.desc(session.startedAt)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<StudySession> save(StudySession session, {StudyTask? updatedTask}) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeStudySession(session);
      final checks = ReferenceChecks(_database);
      await checks.planIdForSubject(normalized.subjectId);
      if (normalized.chapterId != null) {
        await checks.chapterInSubject(
          chapterId: normalized.chapterId!,
          subjectId: normalized.subjectId,
        );
      }
      if (updatedTask != null) {
        if (updatedTask.id != normalized.studyTaskId) {
          throw const DatabaseException(
            message: 'Study session does not match its task.',
          );
        }
        await DriftStudyTaskRepository(_database).save(updatedTask);
      }
      if (normalized.studyTaskId != null) {
        await checks.taskMatchesSession(
          taskId: normalized.studyTaskId!,
          subjectId: normalized.subjectId,
          chapterId: normalized.chapterId,
        );
      }
      await _database
          .into(_database.studySessions)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await findById(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Study session was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<StudyCompletionPlan> commitCompletion(StudyCompletionPlan plan) {
    return runDatabaseTransaction(_database, () async {
      final session = normalizeStudySession(plan.session);
      final task = plan.task == null ? null : normalizeStudyTask(plan.task!);
      final followUp = plan.followUpTask == null
          ? null
          : normalizeStudyTask(plan.followUpTask!);
      final chapter = plan.chapter == null ? null : normalizeChapter(plan.chapter!);
      final subject = plan.subject == null ? null : normalizeSubject(plan.subject!);
      final revision = plan.revision == null
          ? null
          : normalizeRevisionSchedule(plan.revision!);
      final checks = ReferenceChecks(_database);
      await checks.planIdForSubject(session.subjectId);
      if (session.chapterId != null) {
        await checks.chapterInSubject(
          chapterId: session.chapterId!,
          subjectId: session.subjectId,
        );
      }
      if (task != null) {
        if (task.id != session.studyTaskId) {
          throw const DatabaseException(
            message: 'Study session does not match its task.',
          );
        }
        await _checkReferences(task);
        await _database
            .into(_database.studyTasks)
            .insertOnConflictUpdate(_taskCompanion(task));
      }
      if (followUp != null) {
        await _checkReferences(followUp);
        await _database
            .into(_database.studyTasks)
            .insertOnConflictUpdate(_taskCompanion(followUp));
      }
      if (session.studyTaskId != null) {
        await checks.taskMatchesSession(
          taskId: session.studyTaskId!,
          subjectId: session.subjectId,
          chapterId: session.chapterId,
        );
      }
      await _database
          .into(_database.studySessions)
          .insertOnConflictUpdate(session.toCompanion());
      if (chapter != null) {
        await _database
            .into(_database.chapters)
            .insertOnConflictUpdate(_chapterCompanion(chapter));
      }
      if (subject != null) {
        await _database
            .into(_database.subjects)
            .insertOnConflictUpdate(_subjectCompanion(subject));
      }
      if (revision != null) {
        await checks.studyPlanExists(revision.studyPlanId);
        await _database
            .into(_database.revisionSchedules)
            .insertOnConflictUpdate(_revisionCompanion(revision));
      }
      return StudyCompletionPlan(
        session: session,
        task: task,
        followUpTask: followUp,
        chapter: chapter,
        subject: subject,
        revision: revision,
      );
    });
  }

  Future<void> _checkReferences(StudyTask task) async {
    final checks = ReferenceChecks(_database);
    await checks.subjectInPlan(subjectId: task.subjectId, studyPlanId: task.studyPlanId);
    if (task.chapterId != null) {
      await checks.chapterInSubject(chapterId: task.chapterId!, subjectId: task.subjectId);
    }
  }

  @override
  Future<void> delete(String id) {
    return runDatabaseTransaction(_database, () async {
      final removed = await (_database.delete(_database.studySessions)
            ..where((session) => session.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Study session was not found.');
      }
    });
  }
}

StudyTasksCompanion _taskCompanion(StudyTask task) {
  return StudyTasksCompanion.insert(
    id: task.id,
    studyPlanId: task.studyPlanId,
    subjectId: task.subjectId,
    chapterId: Value(task.chapterId),
    topicId: Value(task.topicId),
    examId: Value(task.examId),
    taskType: task.taskType.code,
    title: task.title,
    plannedDate: task.plannedDate,
    plannedStartTime: Value(task.plannedStartTime),
    plannedMinutes: task.plannedMinutes,
    actualMinutes: Value(task.actualMinutes),
    priorityScore: task.priorityScore,
    isLocked: task.isLocked,
    status: task.status.code,
    completionPercent: task.completionPercent,
    source: task.source.code,
    generationBatchId: Value(task.generationBatchId),
    createdAt: task.createdAt,
    updatedAt: task.updatedAt,
    completedAt: Value(task.completedAt),
  );
}

ChaptersCompanion _chapterCompanion(Chapter chapter) {
  return ChaptersCompanion.insert(
    id: chapter.id,
    subjectId: chapter.subjectId,
    title: chapter.title,
    chapterNumber: Value(chapter.chapterNumber),
    estimatedMinutes: chapter.estimatedMinutes,
    completedMinutes: chapter.completedMinutes,
    difficulty: chapter.difficulty.code,
    confidence: chapter.confidence.code,
    priority: chapter.priority.code,
    examImportance: chapter.examImportance.code,
    status: chapter.status.code,
    notes: Value(chapter.notes),
    sortOrder: chapter.sortOrder,
    createdAt: chapter.createdAt,
    updatedAt: chapter.updatedAt,
    completedAt: Value(chapter.completedAt),
  );
}

SubjectsCompanion _subjectCompanion(Subject subject) {
  return SubjectsCompanion.insert(
    id: subject.id,
    studyPlanId: subject.studyPlanId,
    name: subject.name,
    code: Value(subject.code),
    paperName: Value(subject.paperName),
    colorToken: subject.colorToken,
    iconToken: subject.iconToken,
    priority: subject.priority.code,
    difficulty: subject.difficulty.code,
    confidence: subject.confidence.code,
    status: subject.status.code,
    sortOrder: subject.sortOrder,
    createdAt: subject.createdAt,
    updatedAt: subject.updatedAt,
  );
}

RevisionSchedulesCompanion _revisionCompanion(RevisionSchedule schedule) {
  return RevisionSchedulesCompanion.insert(
    id: schedule.id,
    studyPlanId: schedule.studyPlanId,
    chapterId: schedule.chapterId,
    topicId: Value(schedule.topicId),
    sourceStudySessionId: Value(schedule.sourceStudySessionId),
    revisionNumber: schedule.revisionNumber,
    dueDate: schedule.dueDate,
    estimatedMinutes: schedule.estimatedMinutes,
    status: schedule.status.code,
    completedAt: Value(schedule.completedAt),
    createdAt: schedule.createdAt,
  );
}

extension on StudySessionRow {
  StudySession toDomain() {
    return StudySession(
      id: id,
      studyTaskId: studyTaskId,
      subjectId: subjectId,
      chapterId: chapterId,
      topicId: topicId,
      startedAt: startedAt,
      endedAt: endedAt,
      plannedMinutes: plannedMinutes,
      actualMinutes: actualMinutes,
      completionPercent: completionPercent,
      result: SessionResult.fromCode(result),
      confidenceBefore: confidenceBefore == null
          ? null
          : Confidence.fromCode(confidenceBefore!),
      confidenceAfter: confidenceAfter == null
          ? null
          : Confidence.fromCode(confidenceAfter!),
      note: note,
      createdAt: createdAt,
    );
  }
}

extension on StudySession {
  StudySessionsCompanion toCompanion() {
    return StudySessionsCompanion.insert(
      id: id,
      studyTaskId: Value(studyTaskId),
      subjectId: subjectId,
      chapterId: Value(chapterId),
      topicId: Value(topicId),
      startedAt: startedAt,
      endedAt: Value(endedAt),
      plannedMinutes: plannedMinutes,
      actualMinutes: actualMinutes,
      completionPercent: completionPercent,
      result: result.code,
      confidenceBefore: Value(confidenceBefore?.code),
      confidenceAfter: Value(confidenceAfter?.code),
      note: Value(note),
      createdAt: createdAt,
    );
  }
}
