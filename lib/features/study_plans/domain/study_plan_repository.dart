import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';

abstract interface class StudyPlanRepository implements Repository {
  Future<StudyPlan?> findById(String id);

  Stream<List<StudyPlan>> watchAll({bool includeArchived = false});

  Future<StudyPlan> save(StudyPlan plan);

  Future<void> archive(String id, {required DateTime archivedAt});

  /// Removes the plan and its academic history. This is the explicit delete.
  Future<void> delete(String id);
}
