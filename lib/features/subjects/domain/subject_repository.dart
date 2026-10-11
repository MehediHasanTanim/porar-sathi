import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';

abstract interface class SubjectRepository implements Repository {
  Future<Subject?> findById(String id);

  Stream<List<Subject>> watchByPlan(
    String studyPlanId, {
    bool includeArchived = false,
  });

  Future<Subject> save(Subject subject);

  Future<void> archive(String id, {required DateTime archivedAt});

  /// Study sessions block deletion until [includeHistory] is true.
  Future<void> delete(String id, {bool includeHistory = false});
}
