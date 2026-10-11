import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/onboarding/domain/student_profile.dart';
import 'package:porar_sathi/features/onboarding/domain/student_profile_repository.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';

final class DriftStudentProfileRepository implements StudentProfileRepository {
  DriftStudentProfileRepository(this._database);

  final AppDatabase _database;

  @override
  Future<StudentProfile?> findById(String id) async {
    final row = await (_database.select(_database.studentProfiles)
          ..where((profile) => profile.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<List<StudentProfile>> watchAll() {
    final query = _database.select(_database.studentProfiles)
      ..orderBy([(profile) => OrderingTerm.asc(profile.displayName)]);
    return query.watch().map(
      (rows) => [for (final row in rows) row.toDomain()],
    );
  }

  @override
  Future<StudentProfile> save(StudentProfile profile) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeStudentProfile(profile);
      await _database
          .into(_database.studentProfiles)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await findById(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Student profile was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<void> delete(String id) {
    return runDatabaseTransaction(_database, () async {
      final removed = await (_database.delete(_database.studentProfiles)
            ..where((profile) => profile.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Student profile was not found.');
      }
    });
  }
}

extension on StudentProfileRow {
  StudentProfile toDomain() {
    return StudentProfile(
      id: id,
      displayName: displayName,
      studyLevel: StudyLevel.fromCode(studyLevel),
      institution: institution,
      academicYear: academicYear,
      preferredLanguage: AppLanguage.fromCode(preferredLanguage),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on StudentProfile {
  StudentProfilesCompanion toCompanion() {
    return StudentProfilesCompanion.insert(
      id: id,
      displayName: displayName,
      studyLevel: studyLevel.code,
      institution: Value(institution),
      academicYear: Value(academicYear),
      preferredLanguage: preferredLanguage.code,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
