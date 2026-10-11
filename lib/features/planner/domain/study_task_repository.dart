import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/repository/repository.dart';
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

  Future<void> delete(String id);
}
