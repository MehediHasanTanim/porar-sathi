import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test('opens a fresh database on the current schema', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    expect(database.schemaVersion, AppDatabase.latestSchemaVersion);
    final version = await database.customSelect('PRAGMA user_version').getSingle();
    expect(version.read<int>('user_version'), AppDatabase.latestSchemaVersion);
    final foreignKeys = await database
        .customSelect('PRAGMA foreign_keys')
        .getSingle();
    expect(foreignKeys.read<int>('foreign_keys'), 1);
  });

  test('migrates an empty version 1 database without wiping it', () async {
    final raw = sqlite3.openInMemory();
    raw.execute('PRAGMA user_version = 1');
    raw.execute(
      'CREATE TABLE migration_marker (id INTEGER NOT NULL PRIMARY KEY)',
    );
    raw.execute('INSERT INTO migration_marker (id) VALUES (1)');

    final database = AppDatabase(NativeDatabase.opened(raw));
    addTearDown(database.close);

    final version = await database.customSelect('PRAGMA user_version').getSingle();
    expect(version.read<int>('user_version'), 2);
    final marker = await database
        .customSelect('SELECT id FROM migration_marker')
        .getSingle();
    expect(marker.read<int>('id'), 1);
    final tasks = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'study_tasks'",
        )
        .get();
    expect(tasks, isNotEmpty);
  });

  test('a new test database does not keep rows from another one', () async {
    final first = AppDatabase(NativeDatabase.memory());
    await first
        .into(first.studentProfiles)
        .insert(
          StudentProfilesCompanion.insert(
            id: 'student-1',
            displayName: 'Tanim',
            studyLevel: 'HSC',
            preferredLanguage: 'en',
            createdAt: DateTime(2026, 10, 11),
            updatedAt: DateTime(2026, 10, 11),
          ),
        );
    await first.close();

    final second = AppDatabase(NativeDatabase.memory());
    addTearDown(second.close);
    final rows = await second.select(second.studentProfiles).get();
    expect(rows, isEmpty);
  });

  test('planner queries use the required indexes', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final plans = await _explain(
      database,
      "SELECT * FROM study_tasks WHERE study_plan_id = 'p' AND planned_date = 0",
    );
    final status = await _explain(
      database,
      "SELECT * FROM study_tasks WHERE status = 'PLANNED' AND planned_date = 0",
    );
    final subjectStatus = await _explain(
      database,
      "SELECT * FROM study_tasks WHERE subject_id = 's' AND status = 'PLANNED'",
    );
    final sessions = await _explain(
      database,
      'SELECT * FROM study_sessions WHERE subject_id = \'s\' ORDER BY started_at',
    );
    final revisions = await _explain(
      database,
      "SELECT * FROM revision_schedules WHERE due_date = 0 AND status = 'PENDING'",
    );
    final exceptions = await _explain(
      database,
      'SELECT * FROM calendar_exceptions WHERE study_plan_id = \'p\' AND date = 0',
    );
    final chapters = await _explain(
      database,
      "SELECT * FROM chapters WHERE subject_id = 's'",
    );
    final subjects = await _explain(
      database,
      "SELECT * FROM subjects WHERE study_plan_id = 'p'",
    );
    final exams = await _explain(
      database,
      'SELECT * FROM exams WHERE study_plan_id = \'p\' ORDER BY start_date',
    );

    expect(plans, contains('idx_study_tasks_study_plan_id_planned_date'));
    expect(status, contains('idx_study_tasks_status_planned_date'));
    expect(subjectStatus, contains('idx_study_tasks_subject_id_status'));
    expect(sessions, contains('idx_study_sessions_subject_id_started_at'));
    expect(revisions, contains('idx_revision_schedules_due_date_status'));
    expect(exceptions, contains('idx_calendar_exceptions_study_plan_id_date'));
    expect(chapters, contains('idx_chapters_subject_id_status'));
    expect(subjects, contains('idx_subjects_study_plan_id'));
    expect(exams, contains('idx_exams_study_plan_id_start_date'));
  });

  test('foreign keys reject a subject without a study plan', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await expectLater(
      database.into(database.subjects).insert(
        SubjectsCompanion.insert(
          id: 'subject-1',
          studyPlanId: 'missing-plan',
          name: 'Physics',
          colorToken: 'physics',
          iconToken: 'physics',
          priority: 'NORMAL',
          difficulty: 'MODERATE',
          confidence: 'MEDIUM',
          status: 'ACTIVE',
          sortOrder: 0,
          createdAt: DateTime(2026, 10, 11),
          updatedAt: DateTime(2026, 10, 11),
        ),
      ),
      throwsA(isA<SqliteException>()),
    );
  });
}

Future<String> _explain(AppDatabase database, String sql) async {
  final rows = await database.customSelect('EXPLAIN QUERY PLAN $sql').get();
  return rows.map((row) => row.read<String>('detail')).join('\n');
}
