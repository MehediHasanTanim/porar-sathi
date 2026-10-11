import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/fake_clock.dart';
import 'package:porar_sathi/features/backup_restore/data/drift_backup_repository.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_archive.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_document.dart';
import 'package:porar_sathi/features/sessions/data/drift_study_session_repository.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/study_plans/data/drift_study_plan_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/data/drift_subject_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/data/drift_chapter_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final createdAt = DateTime.utc(2026, 10, 11, 12);

  test('export then restore replaces the other database', () async {
    final source = AppDatabase(NativeDatabase.memory());
    final clock = FakeClock(DateTime(2026, 10, 11, 8));
    addTearDown(source.close);
    await DriftStudyPlanRepository(source).save(
      newStudyPlan(
        id: 'plan-1',
        name: 'HSC Final',
        startDate: clock.today(),
        createdAt: clock.now(),
      ),
    );
    await DriftSubjectRepository(source).save(
      Subject(
        id: 'subject-1',
        studyPlanId: 'plan-1',
        name: 'Physics',
        colorToken: 'physics',
        iconToken: 'physics',
        priority: Priority.high,
        difficulty: Difficulty.difficult,
        confidence: Confidence.low,
        status: SubjectStatus.active,
        sortOrder: 0,
        createdAt: clock.now(),
        updatedAt: clock.now(),
      ),
    );
    await DriftChapterRepository(source).save(
      Chapter(
        id: 'chapter-1',
        subjectId: 'subject-1',
        title: 'Mechanics',
        estimatedMinutes: 180,
        completedMinutes: 40,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        priority: Priority.normal,
        examImportance: Priority.high,
        status: ChapterStatus.completed,
        sortOrder: 0,
        createdAt: clock.now(),
        updatedAt: clock.now(),
        completedAt: clock.now(),
      ),
    );
    await DriftStudySessionRepository(source).save(
      StudySession(
        id: 'session-1',
        subjectId: 'subject-1',
        chapterId: 'chapter-1',
        startedAt: clock.now(),
        endedAt: clock.now(),
        plannedMinutes: 40,
        actualMinutes: 40,
        completionPercent: 100,
        result: SessionResult.fullyCompleted,
        createdAt: clock.now(),
      ),
    );

    final exported = await DriftBackupRepository(source).readPayload();
    final file = await encodeBackup(
      payload: exported,
      appVersion: backupAppVersion,
      createdAt: createdAt,
      locale: 'bn',
      devicePlatform: 'test',
    );
    final inspection = await inspectBackup(
      bytes: file,
      fileName: 'study.pockettutor',
    );
    expect(inspection, isA<BackupAccepted>());
    final accepted = inspection as BackupAccepted;
    expect(accepted.summary.plans, 1);
    expect(accepted.summary.subjects, 1);
    expect(accepted.summary.sessions, 1);
    final archive = ZipDecoder().decodeBytes(file);
    expect(
      utf8.decode(archive.findFile('README.txt')!.readBytes()!),
      contains('study data'),
    );

    final target = AppDatabase(NativeDatabase.memory());
    addTearDown(target.close);
    await DriftStudyPlanRepository(target).save(
      newStudyPlan(
        id: 'other',
        name: 'Old plan',
        startDate: clock.today(),
        createdAt: clock.now(),
      ),
    );
    await DriftBackupRepository(target).replaceAll(accepted.payload);
    final restored = await DriftBackupRepository(target).readPayload();
    expect(restored.rows('studyPlans').single['name'], 'HSC Final');
    expect(restored.rows('studySessions'), hasLength(1));
    expect(restored.rows('chapters').single['completedMinutes'], 40);

    await DriftBackupRepository(target).resetProgress();
    final reset = await DriftBackupRepository(target).readPayload();
    expect(reset.rows('studyPlans'), hasLength(1));
    expect(reset.rows('studySessions'), isEmpty);
    expect(reset.rows('chapters').single['completedMinutes'], 0);
    expect(reset.rows('chapters').single['status'], 'NOT_STARTED');
  });

  test('a bad restore leaves the current database unchanged', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final clock = FakeClock(DateTime(2026, 10, 11, 8));
    await DriftStudyPlanRepository(database).save(
      newStudyPlan(
        id: 'keep',
        name: 'Keep me',
        startDate: clock.today(),
        createdAt: clock.now(),
      ),
    );
    final broken = emptyBackupPayload();
    broken.rows('subjects').add({
      'id': 'orphan',
      'studyPlanId': 'missing',
      'name': 'Physics',
      'colorToken': 'physics',
      'iconToken': 'physics',
      'priority': 'HIGH',
      'difficulty': 'HARD',
      'confidence': 'LOW',
      'status': 'ACTIVE',
      'sortOrder': 0,
      'createdAt': 0,
      'updatedAt': 0,
    });
    expect(validatePayload(broken), BackupProblem.relationship);
    await expectLater(
      DriftBackupRepository(database).replaceAll(broken),
      throwsA(isA<RestoreException>()),
    );
    final stillThere = await DriftBackupRepository(database).readPayload();
    expect(stillThere.rows('studyPlans').single['name'], 'Keep me');
  });

  test('encrypted backup rejects the wrong password', () async {
    final file = await encodeBackup(
      payload: emptyBackupPayload(),
      appVersion: backupAppVersion,
      createdAt: createdAt,
      locale: 'en',
      devicePlatform: 'test',
      password: 'correct-password',
      iterations: 1000,
    );
    expect(backupNeedsPassword(file), isTrue);
    final opened = await inspectBackup(
      bytes: file,
      fileName: 'study.pockettutor',
      password: 'correct-password',
    );
    expect(opened, isA<BackupAccepted>());
    final wrong = await inspectBackup(
      bytes: file,
      fileName: 'study.pockettutor',
      password: 'wrong-password',
    );
    expect((wrong as BackupRejected).problem, BackupProblem.wrongPassword);
  });

  test('validation rejects damaged, partial, and unsupported files', () async {
    final file = await encodeBackup(
      payload: emptyBackupPayload(),
      appVersion: backupAppVersion,
      createdAt: createdAt,
      locale: 'en',
      devicePlatform: 'test',
    );
    expect(
      (await inspectBackup(
        bytes: file,
        fileName: 'notes.txt',
      ) as BackupRejected).problem,
      BackupProblem.fileType,
    );
    expect(
      (await inspectBackup(
        bytes: Uint8List.fromList(file.take(24).toList()),
        fileName: 'study.pockettutor',
      ) as BackupRejected).problem,
      BackupProblem.partial,
    );

    expect(
      (await inspectBackup(
        bytes: await encodeBackup(
          payload: emptyBackupPayload(),
          appVersion: '0.1.0',
          createdAt: createdAt,
          locale: 'en',
          devicePlatform: 'test',
          schemaVersion: 1,
        ),
        fileName: 'study.pockettutor',
      ) as BackupRejected).problem,
      BackupProblem.olderSchema,
    );
    expect(
      (await inspectBackup(
        bytes: await encodeBackup(
          payload: emptyBackupPayload(),
          appVersion: '9.0.0',
          createdAt: createdAt,
          locale: 'en',
          devicePlatform: 'test',
          schemaVersion: 99,
        ),
        fileName: 'study.pockettutor',
      ) as BackupRejected).problem,
      BackupProblem.newerSchema,
    );

    final archive = ZipDecoder().decodeBytes(file);
    final manifest = jsonDecode(
      utf8.decode(archive.findFile('manifest.json')!.readBytes()!),
    ) as Map<String, dynamic>;
    manifest['checksum'] = '00';
    final rewritten = Archive()
      ..addFile(ArchiveFile.string('manifest.json', jsonEncode(manifest)))
      ..addFile(
        ArchiveFile.bytes(
          'data.json',
          archive.findFile('data.json')!.readBytes()!,
        ),
      );
    final checksum = await inspectBackup(
      bytes: ZipEncoder().encodeBytes(rewritten),
      fileName: 'study.pockettutor',
    );
    expect((checksum as BackupRejected).problem, BackupProblem.checksum);
  });

  test('delete all removes study rows', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final clock = FakeClock(DateTime(2026, 10, 11, 8));
    await DriftStudyPlanRepository(database).save(
      newStudyPlan(
        id: 'plan-1',
        name: 'HSC Final',
        startDate: clock.today(),
        createdAt: clock.now(),
      ),
    );
    await DriftBackupRepository(database).deleteAll();
    final payload = await DriftBackupRepository(database).readPayload();
    expect(payload.rows('studyPlans'), isEmpty);
  });
}
