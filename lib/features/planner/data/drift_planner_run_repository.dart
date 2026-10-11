import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/planner_run_repository.dart';

final class DriftPlannerRunRepository implements PlannerRunRepository {
  DriftPlannerRunRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<PlannerRun>> watchByPlan(String studyPlanId) {
    final query = _database.select(_database.plannerRuns)
      ..where((run) => run.studyPlanId.equals(studyPlanId))
      ..orderBy([(run) => OrderingTerm.desc(run.startedAt)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<PlannerRun> save(PlannerRun run) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizePlannerRun(run);
      await ReferenceChecks(_database).studyPlanExists(normalized.studyPlanId);
      await _database
          .into(_database.plannerRuns)
          .insertOnConflictUpdate(normalized.toCompanion());
      final row = await (_database.select(_database.plannerRuns)
            ..where((item) => item.id.equals(normalized.id)))
          .getSingleOrNull();
      if (row == null) {
        throw const DatabaseException(message: 'Planner run was not saved.');
      }
      return row.toDomain();
    });
  }

  @override
  Future<void> delete(String id) {
    return runDatabaseTransaction(_database, () async {
      final removed = await (_database.delete(_database.plannerRuns)
            ..where((run) => run.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Planner run was not found.');
      }
    });
  }
}

extension on PlannerRunRow {
  PlannerRun toDomain() {
    return PlannerRun(
      id: id,
      studyPlanId: studyPlanId,
      trigger: PlannerTrigger.fromCode(trigger),
      startedAt: startedAt,
      completedAt: completedAt,
      inputTaskCount: inputTaskCount,
      outputTaskCount: outputTaskCount,
      riskLevel: PlannerRiskLevel.fromCode(riskLevel),
      expectedFinishDate: expectedFinishDate == null
          ? null
          : calendarDate(expectedFinishDate!),
      algorithmVersion: algorithmVersion,
    );
  }
}

extension on PlannerRun {
  PlannerRunsCompanion toCompanion() {
    return PlannerRunsCompanion.insert(
      id: id,
      studyPlanId: studyPlanId,
      trigger: trigger.code,
      startedAt: startedAt,
      completedAt: Value(completedAt),
      inputTaskCount: inputTaskCount,
      outputTaskCount: outputTaskCount,
      riskLevel: riskLevel.code,
      expectedFinishDate: Value(expectedFinishDate),
      algorithmVersion: algorithmVersion,
    );
  }
}
