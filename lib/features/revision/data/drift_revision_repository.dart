import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/revision/domain/revision_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';

final class DriftRevisionRepository implements RevisionRepository {
  DriftRevisionRepository(this._database);

  final AppDatabase _database;

  @override
  Future<RevisionSchedule?> findById(String id) async {
    final row = await (_database.select(_database.revisionSchedules)
          ..where((schedule) => schedule.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<List<RevisionSchedule>> watchDue({
    DateTime? onOrBefore,
    RevisionStatus? status,
  }) {
    final query = _database.select(_database.revisionSchedules)
      ..where((schedule) {
        Expression<bool> match = const Constant(true);
        if (onOrBefore != null) {
          match = schedule.dueDate.isSmallerOrEqualValue(calendarDate(onOrBefore));
        }
        if (status != null) {
          final statusMatch = schedule.status.equals(status.code);
          match = onOrBefore == null ? statusMatch : match & statusMatch;
        }
        return match;
      })
      ..orderBy([(schedule) => OrderingTerm.asc(schedule.dueDate)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Stream<List<RevisionSchedule>> watchByChapter(String chapterId) {
    final query = _database.select(_database.revisionSchedules)
      ..where((schedule) => schedule.chapterId.equals(chapterId))
      ..orderBy([(schedule) => OrderingTerm.asc(schedule.revisionNumber)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<RevisionSchedule> save(RevisionSchedule schedule) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeRevisionSchedule(schedule);
      final checks = ReferenceChecks(_database);
      final subjectId = await checks.subjectIdForChapter(normalized.chapterId);
      final planId = await checks.planIdForSubject(subjectId);
      if (planId != normalized.studyPlanId) {
        throw const DatabaseException(
          message: 'Revision schedule is not part of this study plan.',
        );
      }
      if (normalized.sourceStudySessionId != null) {
        await checks.sessionExists(normalized.sourceStudySessionId!);
      }
      await _database
          .into(_database.revisionSchedules)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await findById(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Revision schedule was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<List<RevisionSchedule>> saveAll(List<RevisionSchedule> schedules) {
    return runDatabaseTransaction(_database, () async {
      final saved = <RevisionSchedule>[];
      for (final schedule in schedules) {
        saved.add(await save(schedule));
      }
      return saved;
    });
  }

  @override
  Future<void> delete(String id) {
    return runDatabaseTransaction(_database, () async {
      final removed = await (_database.delete(_database.revisionSchedules)
            ..where((schedule) => schedule.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Revision schedule was not found.');
      }
    });
  }
}

extension on RevisionScheduleRow {
  RevisionSchedule toDomain() {
    return RevisionSchedule(
      id: id,
      studyPlanId: studyPlanId,
      chapterId: chapterId,
      topicId: topicId,
      sourceStudySessionId: sourceStudySessionId,
      revisionNumber: revisionNumber,
      dueDate: calendarDate(dueDate),
      estimatedMinutes: estimatedMinutes,
      status: RevisionStatus.fromCode(status),
      completedAt: completedAt,
      createdAt: createdAt,
    );
  }
}

extension on RevisionSchedule {
  RevisionSchedulesCompanion toCompanion() {
    return RevisionSchedulesCompanion.insert(
      id: id,
      studyPlanId: studyPlanId,
      chapterId: chapterId,
      topicId: Value(topicId),
      sourceStudySessionId: Value(sourceStudySessionId),
      revisionNumber: revisionNumber,
      dueDate: dueDate,
      estimatedMinutes: estimatedMinutes,
      status: status.code,
      completedAt: Value(completedAt),
      createdAt: createdAt,
    );
  }
}
