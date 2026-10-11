import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/subjects/domain/subject_repository.dart';

final class DriftSubjectRepository implements SubjectRepository {
  DriftSubjectRepository(this._database);

  final AppDatabase _database;

  @override
  Future<Subject?> findById(String id) async {
    final row = await (_database.select(_database.subjects)
          ..where((subject) => subject.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<List<Subject>> watchByPlan(
    String studyPlanId, {
    bool includeArchived = false,
  }) {
    final query = _database.select(_database.subjects)
      ..where((subject) {
        final matchesPlan = subject.studyPlanId.equals(studyPlanId);
        if (includeArchived) {
          return matchesPlan;
        }
        return matchesPlan &
            subject.status.equals(SubjectStatus.archived.code).not();
      })
      ..orderBy([(subject) => OrderingTerm.asc(subject.sortOrder)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<Subject> save(Subject subject) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeSubject(subject);
      await ReferenceChecks(_database).studyPlanExists(normalized.studyPlanId);
      await _database
          .into(_database.subjects)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await findById(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Subject was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<void> archive(String id, {required DateTime archivedAt}) {
    return runDatabaseTransaction(_database, () async {
      final existing = await findById(id);
      if (existing == null) {
        throw const DatabaseException(message: 'Subject was not found.');
      }
      await save(
        existing.copyWith(
          status: SubjectStatus.archived,
          updatedAt: archivedAt,
        ),
      );
    });
  }

  @override
  Future<void> delete(String id, {bool includeHistory = false}) {
    return runDatabaseTransaction(_database, () async {
      final sessions = await (_database.select(_database.studySessions)
            ..where((session) => session.subjectId.equals(id)))
          .get();
      if (sessions.isNotEmpty && !includeHistory) {
        throw const DatabaseException(
          message: 'Study history exists. Delete it explicitly to continue.',
        );
      }
      if (sessions.isNotEmpty) {
        await (_database.delete(_database.studySessions)
              ..where((session) => session.subjectId.equals(id)))
            .go();
      }
      final removed = await (_database.delete(_database.subjects)
            ..where((subject) => subject.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Subject was not found.');
      }
    });
  }
}

extension on SubjectRow {
  Subject toDomain() {
    return Subject(
      id: id,
      studyPlanId: studyPlanId,
      name: name,
      code: code,
      paperName: paperName,
      colorToken: colorToken,
      iconToken: iconToken,
      priority: Priority.fromCode(priority),
      difficulty: Difficulty.fromCode(difficulty),
      confidence: Confidence.fromCode(confidence),
      status: SubjectStatus.fromCode(status),
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on Subject {
  SubjectsCompanion toCompanion() {
    return SubjectsCompanion.insert(
      id: id,
      studyPlanId: studyPlanId,
      name: name,
      code: Value(code),
      paperName: Value(paperName),
      colorToken: colorToken,
      iconToken: iconToken,
      priority: priority.code,
      difficulty: difficulty.code,
      confidence: confidence.code,
      status: status.code,
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
