import 'package:porar_sathi/core/time/clock.dart';

/// Scheduling lives here, not in widgets.
///
/// Phase 4 implements capacity, scoring, and allocation behind this type.
/// Screens only display the plan a use case returns. The date always comes
/// from [Clock].
abstract interface class StudyPlanner {
  String get algorithmVersion;

  DateTime today();
}

/// Placeholder used until the planning engine exists.
final class PendingStudyPlanner implements StudyPlanner {
  const PendingStudyPlanner(this._clock);

  final Clock _clock;

  @override
  String get algorithmVersion => 'planner_v1';

  @override
  DateTime today() => _clock.today();
}
