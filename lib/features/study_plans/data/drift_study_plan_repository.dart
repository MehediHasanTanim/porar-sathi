import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan_repository.dart';

final class DriftStudyPlanRepository implements StudyPlanRepository {
  DriftStudyPlanRepository(this._database);

  final AppDatabase _database;

  @override
  Future<StudyPlan?> findById(String id) async {
    final row = await (_database.select(_database.studyPlans)
          ..where((plan) => plan.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<List<StudyPlan>> watchAll({bool includeArchived = false}) {
    final query = _database.select(_database.studyPlans)
      ..orderBy([(plan) => OrderingTerm.desc(plan.updatedAt)]);
    if (!includeArchived) {
      query.where(
        (plan) => plan.status.equals(StudyPlanStatus.archived.code).not(),
      );
    }
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<StudyPlan> save(StudyPlan plan) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeStudyPlan(plan);
      await ReferenceChecks(_database).primaryExamBelongsToPlan(
        studyPlanId: normalized.id,
        examId: normalized.primaryExamId,
      );
      await _database
          .into(_database.studyPlans)
          .insertOnConflictUpdate(normalized.toCompanion());
      return _require(normalized.id);
    });
  }

  @override
  Future<void> archive(String id, {required DateTime archivedAt}) {
    return runDatabaseTransaction(_database, () async {
      final existing = await findById(id);
      if (existing == null) {
        throw const DatabaseException(message: 'Study plan was not found.');
      }
      await save(
        existing.copyWith(
          status: StudyPlanStatus.archived,
          archivedAt: archivedAt,
          updatedAt: archivedAt,
        ),
      );
    });
  }

  @override
  Future<void> delete(String id) {
    return runDatabaseTransaction(_database, () async {
      final subjects = await (_database.select(_database.subjects)
            ..where((subject) => subject.studyPlanId.equals(id)))
          .get();
      final subjectIds = [for (final subject in subjects) subject.id];
      if (subjectIds.isNotEmpty) {
        await (_database.delete(_database.studySessions)
              ..where((session) => session.subjectId.isIn(subjectIds)))
            .go();
      }
      await (_database.update(_database.studyPlans)
            ..where((plan) => plan.id.equals(id)))
          .write(const StudyPlansCompanion(primaryExamId: Value(null)));
      final removed = await (_database.delete(_database.studyPlans)
            ..where((plan) => plan.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Study plan was not found.');
      }
    });
  }

  Future<StudyPlan> _require(String id) async {
    final stored = await findById(id);
    if (stored == null) {
      throw const DatabaseException(message: 'Study plan was not saved.');
    }
    return stored;
  }
}

extension on StudyPlanRow {
  StudyPlan toDomain() {
    return StudyPlan(
      id: id,
      name: name,
      description: description,
      planType: PlanType.fromCode(planType),
      status: StudyPlanStatus.fromCode(status),
      startDate: calendarDate(startDate),
      targetEndDate: targetEndDate == null ? null : calendarDate(targetEndDate!),
      primaryExamId: primaryExamId,
      planningMode: PlanningMode.fromCode(planningMode),
      dailyIntensity: DailyIntensity.fromCode(dailyIntensity),
      maxDailyMinutes: maxDailyMinutes,
      maxSessionMinutes: maxSessionMinutes,
      planningBufferPercent: planningBufferPercent,
      revisionBufferDays: revisionBufferDays,
      createdAt: createdAt,
      updatedAt: updatedAt,
      archivedAt: archivedAt,
    );
  }
}

extension on StudyPlan {
  StudyPlansCompanion toCompanion() {
    return StudyPlansCompanion.insert(
      id: id,
      name: name,
      description: Value(description),
      planType: planType.code,
      status: status.code,
      startDate: startDate,
      targetEndDate: Value(targetEndDate),
      primaryExamId: Value(primaryExamId),
      planningMode: planningMode.code,
      dailyIntensity: dailyIntensity.code,
      maxDailyMinutes: maxDailyMinutes,
      maxSessionMinutes: maxSessionMinutes,
      planningBufferPercent: planningBufferPercent,
      revisionBufferDays: revisionBufferDays,
      createdAt: createdAt,
      updatedAt: updatedAt,
      archivedAt: Value(archivedAt),
    );
  }
}
