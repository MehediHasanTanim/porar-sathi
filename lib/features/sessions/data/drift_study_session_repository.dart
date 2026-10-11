import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
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
