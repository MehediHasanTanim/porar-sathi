import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';

abstract interface class StudyTaskRepository implements Repository {
  Future<StudyTask?> findById(String id);

  Stream<List<StudyTask>> watchByPlanOnDate(String studyPlanId, DateTime date);

  Stream<List<StudyTask>> watchByStatusOnDate(TaskStatus status, DateTime date);

  Stream<List<StudyTask>> watchBySubject(
    String subjectId, {
    TaskStatus? status,
  });

  Future<StudyTask> save(StudyTask task);

  Future<List<StudyTask>> saveAll(List<StudyTask> tasks);

  Future<List<StudyTask>> listByPlan(String studyPlanId);

  Future<List<StudyTask>> listBacklog(String studyPlanId, DateTime today);

  /// Replaces unlocked generated tasks and stores the run in one transaction.
  ///
  /// A failure leaves the previous tasks and runs unchanged.
  Future<PlannerRun> replaceGeneratedPlan({
    required PlannerRun run,
    required List<StudyTask> tasks,
  });

  /// Replaces future generated, catch-up, and revision tasks.
  ///
  /// Completed, in-progress, locked, and manual tasks stay in place.
  Future<PlannerRun> applyAdaptivePlan({
    required PlannerRun run,
    required List<StudyTask> tasks,
    required DateTime today,
  });

  Future<void> delete(String id);
}
