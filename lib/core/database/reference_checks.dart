import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';

/// Foreign-key checks that Drift cannot express, including the plan/exam cycle.
final class ReferenceChecks {
  ReferenceChecks(this._database);

  final AppDatabase _database;

  Future<void> studyPlanExists(String studyPlanId) async {
    final row = await (_database.select(_database.studyPlans)
          ..where((plan) => plan.id.equals(studyPlanId)))
        .getSingleOrNull();
    if (row == null) {
      throw const DatabaseException(message: 'Study plan was not found.');
    }
  }

  Future<void> primaryExamBelongsToPlan({
    required String studyPlanId,
    required String? examId,
  }) async {
    if (examId == null) {
      return;
    }
    await examInPlan(examId: examId, studyPlanId: studyPlanId);
  }

  Future<void> subjectInPlan({
    required String subjectId,
    required String studyPlanId,
  }) async {
    final row = await (_database.select(_database.subjects)
          ..where((subject) => subject.id.equals(subjectId)))
        .getSingleOrNull();
    if (row == null || row.studyPlanId != studyPlanId) {
      throw const DatabaseException(
        message: 'Subject is not part of this study plan.',
      );
    }
  }

  Future<void> chapterInSubject({
    required String chapterId,
    required String subjectId,
  }) async {
    final row = await (_database.select(_database.chapters)
          ..where((chapter) => chapter.id.equals(chapterId)))
        .getSingleOrNull();
    if (row == null || row.subjectId != subjectId) {
      throw const DatabaseException(
        message: 'Chapter is not part of this subject.',
      );
    }
  }

  Future<String> subjectIdForChapter(String chapterId) async {
    final row = await (_database.select(_database.chapters)
          ..where((chapter) => chapter.id.equals(chapterId)))
        .getSingleOrNull();
    if (row == null) {
      throw const DatabaseException(message: 'Chapter was not found.');
    }
    return row.subjectId;
  }

  Future<String> planIdForSubject(String subjectId) async {
    final row = await (_database.select(_database.subjects)
          ..where((subject) => subject.id.equals(subjectId)))
        .getSingleOrNull();
    if (row == null) {
      throw const DatabaseException(message: 'Subject was not found.');
    }
    return row.studyPlanId;
  }

  Future<void> examInPlan({
    required String examId,
    required String studyPlanId,
  }) async {
    final row = await (_database.select(_database.exams)
          ..where((exam) => exam.id.equals(examId)))
        .getSingleOrNull();
    if (row == null || row.studyPlanId != studyPlanId) {
      throw const DatabaseException(
        message: 'Exam is not part of this study plan.',
      );
    }
  }

  Future<void> taskMatchesSession({
    required String taskId,
    required String subjectId,
    required String? chapterId,
  }) async {
    final row = await (_database.select(_database.studyTasks)
          ..where((task) => task.id.equals(taskId)))
        .getSingleOrNull();
    if (row == null || row.subjectId != subjectId) {
      throw const DatabaseException(
        message: 'Study session does not match its task.',
      );
    }
    if (chapterId != null && row.chapterId != chapterId) {
      throw const DatabaseException(
        message: 'Study session does not match its task.',
      );
    }
  }

  Future<void> sessionExists(String sessionId) async {
    final row = await (_database.select(_database.studySessions)
          ..where((session) => session.id.equals(sessionId)))
        .getSingleOrNull();
    if (row == null) {
      throw const DatabaseException(message: 'Study session was not found.');
    }
  }
}
