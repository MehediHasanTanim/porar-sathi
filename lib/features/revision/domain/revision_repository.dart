import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';

abstract interface class RevisionRepository implements Repository {
  Future<RevisionSchedule?> findById(String id);

  Stream<List<RevisionSchedule>> watchDue({
    DateTime? onOrBefore,
    RevisionStatus? status,
  });

  Stream<List<RevisionSchedule>> watchByChapter(String chapterId);

  Future<List<RevisionSchedule>> listDue(String studyPlanId, DateTime onOrBefore);

  Future<RevisionSchedule> save(RevisionSchedule schedule);

  Future<List<RevisionSchedule>> saveAll(List<RevisionSchedule> schedules);

  Future<void> delete(String id);
}
