import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_repository.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';

final class DriftExamRepository implements ExamRepository {
  DriftExamRepository(this._database);

  final AppDatabase _database;

  @override
  Future<Exam?> findById(String id) async {
    final row = await (_database.select(_database.exams)
          ..where((exam) => exam.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<List<Exam>> watchByPlan(String studyPlanId) {
    final query = _database.select(_database.exams)
      ..where((exam) => exam.studyPlanId.equals(studyPlanId))
      ..orderBy([(exam) => OrderingTerm.asc(exam.startDate)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Stream<List<ExamSyllabusItem>> watchSyllabus(String examId) {
    final query = _database.select(_database.examSyllabusItems)
      ..where((item) => item.examId.equals(examId));
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<Exam> save(Exam exam) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeExam(exam);
      await ReferenceChecks(_database).studyPlanExists(normalized.studyPlanId);
      await _database
          .into(_database.exams)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await findById(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Exam was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<void> replaceSyllabus(String examId, List<ExamSyllabusItem> items) {
    return runDatabaseTransaction(_database, () async {
      final normalized = [
        for (final item in items) normalizeExamSyllabusItem(item),
      ];
      final exam = await findById(examId);
      if (exam == null) {
        throw const DatabaseException(message: 'Exam was not found.');
      }
      final checks = ReferenceChecks(_database);
      for (final item in normalized) {
        if (item.examId != examId) {
          throw const DatabaseException(
            message: 'Syllabus item does not match the exam.',
          );
        }
        await checks.subjectInPlan(
          subjectId: item.subjectId,
          studyPlanId: exam.studyPlanId,
        );
        if (item.chapterId != null) {
          await checks.chapterInSubject(
            chapterId: item.chapterId!,
            subjectId: item.subjectId,
          );
        }
      }
      await (_database.delete(_database.examSyllabusItems)
            ..where((item) => item.examId.equals(examId)))
          .go();
      await _database.batch((batch) {
        batch.insertAll(
          _database.examSyllabusItems,
          [for (final item in normalized) item.toCompanion()],
        );
      });
    });
  }

  @override
  Future<void> delete(String id) {
    return runDatabaseTransaction(_database, () async {
      await (_database.update(_database.studyPlans)
            ..where((plan) => plan.primaryExamId.equals(id)))
          .write(const StudyPlansCompanion(primaryExamId: Value(null)));
      final removed = await (_database.delete(_database.exams)
            ..where((exam) => exam.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Exam was not found.');
      }
    });
  }
}

extension on ExamRow {
  Exam toDomain() {
    return Exam(
      id: id,
      studyPlanId: studyPlanId,
      name: name,
      examType: ExamType.fromCode(examType),
      startDate: calendarDate(startDate),
      endDate: endDate == null ? null : calendarDate(endDate!),
      timeOfDay: timeOfDay,
      importance: Priority.fromCode(importance),
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on Exam {
  ExamsCompanion toCompanion() {
    return ExamsCompanion.insert(
      id: id,
      studyPlanId: studyPlanId,
      name: name,
      examType: examType.code,
      startDate: startDate,
      endDate: Value(endDate),
      timeOfDay: Value(timeOfDay),
      importance: importance.code,
      notes: Value(notes),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on ExamSyllabusItemRow {
  ExamSyllabusItem toDomain() {
    return ExamSyllabusItem(
      id: id,
      examId: examId,
      subjectId: subjectId,
      chapterId: chapterId,
      topicId: topicId,
      weight: weight,
      isRequired: isRequired,
    );
  }
}

extension on ExamSyllabusItem {
  ExamSyllabusItemsCompanion toCompanion() {
    return ExamSyllabusItemsCompanion.insert(
      id: id,
      examId: examId,
      subjectId: subjectId,
      chapterId: Value(chapterId),
      topicId: Value(topicId),
      weight: weight,
      isRequired: isRequired,
    );
  }
}
