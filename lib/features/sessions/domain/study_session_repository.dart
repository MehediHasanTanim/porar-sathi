import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/sessions/domain/study_completion.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';

abstract interface class StudySessionRepository implements Repository {
  Future<StudySession?> findById(String id);

  Stream<List<StudySession>> watchBySubject(String subjectId);

  Future<List<StudySession>> listBySubjects(List<String> subjectIds);

  /// Stores the session and, when [updatedTask] is set, the task in one
  /// transaction.
  Future<StudySession> save(StudySession session, {StudyTask? updatedTask});

  /// Session, task, chapter, confidence, and revision in one transaction.
  Future<StudyCompletionPlan> commitCompletion(StudyCompletionPlan plan);

  Future<void> delete(String id);
}
