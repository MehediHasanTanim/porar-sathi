import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/tables.dart';

part 'app_database.g.dart';

/// Local SQLite database.
///
/// Widgets must not import this type or any generated Drift row. Repositories
/// are the only callers.
@DriftDatabase(
  tables: [
    StudentProfiles,
    StudyPlans,
    Subjects,
    Chapters,
    Exams,
    ExamSyllabusItems,
    WeeklyAvailabilities,
    CalendarExceptions,
    StudyTasks,
    StudySessions,
    RevisionSchedules,
    PlannerRuns,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Version 1 was the empty Phase 1 database. Version 2 is the core schema.
  static const latestSchemaVersion = 2;

  @override
  int get schemaVersion => latestSchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      await migrateAppDatabase(migrator, from, to);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}

/// Sequential, non-destructive upgrades. Version 1 had no tables.
Future<void> migrateAppDatabase(Migrator migrator, int from, int to) async {
  if (from < 2 && to >= 2) {
    await migrator.createAll();
  }
}
