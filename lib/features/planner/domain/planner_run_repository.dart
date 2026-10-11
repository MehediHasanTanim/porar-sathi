import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';

abstract interface class PlannerRunRepository implements Repository {
  Stream<List<PlannerRun>> watchByPlan(String studyPlanId);

  Future<PlannerRun> save(PlannerRun run);

  Future<void> delete(String id);
}
