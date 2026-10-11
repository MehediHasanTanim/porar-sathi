import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';

abstract interface class StudySessionRepository implements Repository {
  Future<StudySession?> findById(String id);

  Stream<List<StudySession>> watchBySubject(String subjectId);

  /// Stores the session and, when [updatedTask] is set, the task in one
  /// transaction.
  Future<StudySession> save(StudySession session, {StudyTask? updatedTask});

  Future<void> delete(String id);
}
