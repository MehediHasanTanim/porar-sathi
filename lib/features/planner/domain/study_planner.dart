import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/clock.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';

/// Scheduling lives here, not in widgets.
///
/// Screens only display the plan a use case returns. The date always comes
/// from [Clock].
abstract interface class StudyPlanner {
  String get algorithmVersion;

  DateTime today();

  PlanResult generate(
    PlanningInput input, {
    required String runId,
    required DateTime createdAt,
    PlannerTrigger trigger,
  });
}

final class DeterministicStudyPlanner implements StudyPlanner {
  const DeterministicStudyPlanner(this._clock);

  final Clock _clock;

  @override
  String get algorithmVersion => plannerAlgorithmVersion;

  @override
  DateTime today() => _clock.today();

  @override
  PlanResult generate(
    PlanningInput input, {
    required String runId,
    required DateTime createdAt,
    PlannerTrigger trigger = PlannerTrigger.initialPlan,
  }) {
    return generatePlan(
      input,
      runId: runId,
      createdAt: createdAt,
      trigger: trigger,
    );
  }
}
