import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_document.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_repository.dart';

final class DriftBackupRepository implements BackupRepository {
  DriftBackupRepository(this._database);

  final AppDatabase _database;

  @override
  Future<BackupPayload> readPayload() async {
    return BackupPayload({
      'studentProfiles': await _rows(
        _database.select(_database.studentProfiles).get(),
      ),
      'studyPlans': await _rows(_database.select(_database.studyPlans).get()),
      'subjects': await _rows(_database.select(_database.subjects).get()),
      'chapters': await _rows(_database.select(_database.chapters).get()),
      'exams': await _rows(_database.select(_database.exams).get()),
      'examSyllabusItems': await _rows(
        _database.select(_database.examSyllabusItems).get(),
      ),
      'weeklyAvailability': await _rows(
        _database.select(_database.weeklyAvailabilities).get(),
      ),
      'calendarExceptions': await _rows(
        _database.select(_database.calendarExceptions).get(),
      ),
      'studyTasks': await _rows(_database.select(_database.studyTasks).get()),
      'studySessions': await _rows(
        _database.select(_database.studySessions).get(),
      ),
      'revisionSchedules': await _rows(
        _database.select(_database.revisionSchedules).get(),
      ),
      'plannerRuns': await _rows(_database.select(_database.plannerRuns).get()),
    });
  }

  @override
  Future<void> replaceAll(BackupPayload payload) async {
    // The scratch database is a separate memory file used only to prove the
    // backup can be stored before the live database is touched.
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final scratch = AppDatabase(NativeDatabase.memory());
    try {
      await _import(scratch, payload);
    } on Object catch (error) {
      throw RestoreException(message: 'Backup import failed.', cause: error);
    } finally {
      await scratch.close();
    }
    try {
      await _database.transaction(() => _import(_database, payload));
    } on Object catch (error) {
      throw RestoreException(message: 'Backup import failed.', cause: error);
    }
  }

  @override
  Future<void> resetProgress() {
    return _database.transaction(() async {
      await _database.delete(_database.studySessions).go();
      await _database.delete(_database.revisionSchedules).go();
      await _database
          .update(_database.chapters)
          .write(
            ChaptersCompanion(
              completedMinutes: const Value(0),
              status: Value(ChapterStatus.notStarted.code),
              completedAt: const Value(null),
            ),
          );
      await (_database.update(_database.studyTasks)..where(
            (row) => row.status.isNotIn([
              TaskStatus.cancelled.code,
              TaskStatus.skipped.code,
            ]),
          ))
          .write(
            StudyTasksCompanion(
              status: Value(TaskStatus.planned.code),
              completionPercent: const Value(0),
              actualMinutes: const Value(null),
              completedAt: const Value(null),
            ),
          );
    });
  }

  @override
  Future<void> deleteAll() {
    return _database.transaction(() => _deleteAll(_database));
  }

  @override
  Future<int> databaseSizeBytes() async {
    final pages = await _pragma('page_count');
    final size = await _pragma('page_size');
    return pages * size;
  }

  Future<void> _import(AppDatabase database, BackupPayload payload) async {
    await _deleteAll(database);
    await _insertAll(database, payload);
    await _assertIntegrity(database);
  }

  Future<void> _deleteAll(AppDatabase database) async {
    await database.delete(database.revisionSchedules).go();
    await database.delete(database.studySessions).go();
    await database.delete(database.studyTasks).go();
    await database.delete(database.examSyllabusItems).go();
    await database.delete(database.plannerRuns).go();
    await database.delete(database.calendarExceptions).go();
    await database.delete(database.weeklyAvailabilities).go();
    await database.delete(database.chapters).go();
    await database.delete(database.subjects).go();
    await database.delete(database.exams).go();
    await database.delete(database.studyPlans).go();
    await database.delete(database.studentProfiles).go();
  }

  Future<void> _insertAll(AppDatabase database, BackupPayload payload) async {
    for (final row in payload.rows('studentProfiles')) {
      await database
          .into(database.studentProfiles)
          .insert(StudentProfileRow.fromJson(row));
    }
    for (final row in payload.rows('studyPlans')) {
      await database
          .into(database.studyPlans)
          .insert(StudyPlanRow.fromJson(row));
    }
    for (final row in payload.rows('subjects')) {
      await database.into(database.subjects).insert(SubjectRow.fromJson(row));
    }
    for (final row in payload.rows('chapters')) {
      await database.into(database.chapters).insert(ChapterRow.fromJson(row));
    }
    for (final row in payload.rows('exams')) {
      await database.into(database.exams).insert(ExamRow.fromJson(row));
    }
    for (final row in payload.rows('examSyllabusItems')) {
      await database
          .into(database.examSyllabusItems)
          .insert(ExamSyllabusItemRow.fromJson(row));
    }
    for (final row in payload.rows('weeklyAvailability')) {
      await database
          .into(database.weeklyAvailabilities)
          .insert(WeeklyAvailabilityRow.fromJson(row));
    }
    for (final row in payload.rows('calendarExceptions')) {
      await database
          .into(database.calendarExceptions)
          .insert(CalendarExceptionRow.fromJson(row));
    }
    for (final row in payload.rows('studyTasks')) {
      await database
          .into(database.studyTasks)
          .insert(StudyTaskRow.fromJson(row));
    }
    for (final row in payload.rows('studySessions')) {
      await database
          .into(database.studySessions)
          .insert(StudySessionRow.fromJson(row));
    }
    for (final row in payload.rows('revisionSchedules')) {
      await database
          .into(database.revisionSchedules)
          .insert(RevisionScheduleRow.fromJson(row));
    }
    for (final row in payload.rows('plannerRuns')) {
      await database
          .into(database.plannerRuns)
          .insert(PlannerRunRow.fromJson(row));
    }
  }

  Future<void> _assertIntegrity(AppDatabase database) async {
    final integrity = await database
        .customSelect('PRAGMA integrity_check')
        .get();
    final status = integrity.single.read<String>('integrity_check');
    if (status != 'ok') {
      throw const RestoreException(message: 'Integrity check failed.');
    }
    final foreignKeys = await database
        .customSelect('PRAGMA foreign_key_check')
        .get();
    if (foreignKeys.isNotEmpty) {
      throw const RestoreException(message: 'Foreign key check failed.');
    }
  }

  Future<int> _pragma(String name) async {
    final rows = await _database.customSelect('PRAGMA $name').get();
    return rows.single.read<int>(name);
  }
}

Future<List<Map<String, dynamic>>> _rows(Future<List<DataClass>> query) async {
  final rows = await query;
  return [for (final row in rows) row.toJson()];
}
