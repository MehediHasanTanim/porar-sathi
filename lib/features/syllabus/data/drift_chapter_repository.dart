import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter_repository.dart';

final class DriftChapterRepository implements ChapterRepository {
  DriftChapterRepository(this._database);

  final AppDatabase _database;

  @override
  Future<Chapter?> findById(String id) async {
    final row = await (_database.select(_database.chapters)
          ..where((chapter) => chapter.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<List<Chapter>> listByPlan(String studyPlanId) async {
    final rows = await (_database.select(_database.chapters).join([
          innerJoin(
            _database.subjects,
            _database.subjects.id.equalsExp(_database.chapters.subjectId),
          ),
        ])..where(_database.subjects.studyPlanId.equals(studyPlanId)))
        .get();
    return [for (final row in rows) row.readTable(_database.chapters).toDomain()];
  }

  @override
  Stream<List<Chapter>> watchBySubject(String subjectId) {
    final query = _database.select(_database.chapters)
      ..where((chapter) => chapter.subjectId.equals(subjectId))
      ..orderBy([(chapter) => OrderingTerm.asc(chapter.sortOrder)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<Chapter> save(Chapter chapter) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeChapter(chapter);
      await ReferenceChecks(
        _database,
      ).planIdForSubject(normalized.subjectId);
      await _database
          .into(_database.chapters)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await findById(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Chapter was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<List<Chapter>> saveAll(List<Chapter> chapters) {
    return runDatabaseTransaction(_database, () async {
      final saved = <Chapter>[];
      for (final chapter in chapters) {
        saved.add(await save(chapter));
      }
      return saved;
    });
  }

  @override
  Future<void> delete(String id, {bool includeHistory = false}) {
    return runDatabaseTransaction(_database, () async {
      final sessions = await (_database.select(_database.studySessions)
            ..where((session) => session.chapterId.equals(id)))
          .get();
      if (sessions.isNotEmpty && !includeHistory) {
        throw const DatabaseException(
          message: 'Study history exists. Delete it explicitly to continue.',
        );
      }
      if (sessions.isNotEmpty) {
        await (_database.delete(_database.studySessions)
              ..where((session) => session.chapterId.equals(id)))
            .go();
      }
      final removed = await (_database.delete(_database.chapters)
            ..where((chapter) => chapter.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Chapter was not found.');
      }
    });
  }
}

extension on ChapterRow {
  Chapter toDomain() {
    return Chapter(
      id: id,
      subjectId: subjectId,
      title: title,
      chapterNumber: chapterNumber,
      estimatedMinutes: estimatedMinutes,
      completedMinutes: completedMinutes,
      difficulty: Difficulty.fromCode(difficulty),
      confidence: Confidence.fromCode(confidence),
      priority: Priority.fromCode(priority),
      examImportance: Priority.fromCode(examImportance),
      status: ChapterStatus.fromCode(status),
      notes: notes,
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
      completedAt: completedAt,
    );
  }
}

extension on Chapter {
  ChaptersCompanion toCompanion() {
    return ChaptersCompanion.insert(
      id: id,
      subjectId: subjectId,
      title: title,
      chapterNumber: Value(chapterNumber),
      estimatedMinutes: estimatedMinutes,
      completedMinutes: completedMinutes,
      difficulty: difficulty.code,
      confidence: confidence.code,
      priority: priority.code,
      examImportance: examImportance.code,
      status: status.code,
      notes: Value(notes),
      sortOrder: sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
      completedAt: Value(completedAt),
    );
  }
}
