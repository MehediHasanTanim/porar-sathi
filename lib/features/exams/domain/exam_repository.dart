import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';

abstract interface class ExamRepository implements Repository {
  Future<Exam?> findById(String id);

  Stream<List<Exam>> watchByPlan(String studyPlanId);

  Stream<List<ExamSyllabusItem>> watchSyllabus(String examId);

  Future<Exam> save(Exam exam);

  Future<void> replaceSyllabus(String examId, List<ExamSyllabusItem> items);

  Future<void> delete(String id);
}
