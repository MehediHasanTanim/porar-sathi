import 'package:porar_sathi/features/planner/domain/day_rollover.dart';
import 'package:porar_sathi/features/planner/domain/study_task_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_repository.dart';

/// Marks missed work once per day. A second call the same day changes nothing.
Future<DayRollover> commitDayRollover({
  required StudyTaskRepository tasks,
  required RevisionRepository revisions,
  required String planId,
  required DateTime today,
  required DateTime now,
}) async {
  final currentTasks = await tasks.listByPlan(planId);
  final currentRevisions = await revisions.listByPlan(planId);
  final rollover = rollOverDay(
    tasks: currentTasks,
    revisions: currentRevisions,
    today: today,
    now: now,
  );
  if (rollover.tasks.isNotEmpty) {
    await tasks.saveAll(rollover.tasks);
  }
  if (rollover.revisions.isNotEmpty) {
    await revisions.saveAll(rollover.revisions);
  }
  return rollover;
}
