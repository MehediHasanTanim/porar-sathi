import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/study_task_repository.dart';

final class DriftStudyTaskRepository implements StudyTaskRepository {
  DriftStudyTaskRepository(this._database);

  final AppDatabase _database;

  @override
  Future<StudyTask?> findById(String id) async {
    final row = await (_database.select(_database.studyTasks)
          ..where((task) => task.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Stream<List<StudyTask>> watchByPlanOnDate(
    String studyPlanId,
    DateTime date,
  ) {
    final day = calendarDate(date);
    final query = _database.select(_database.studyTasks)
      ..where(
        (task) =>
            task.studyPlanId.equals(studyPlanId) & task.plannedDate.equals(day),
      )
      ..orderBy([(task) => OrderingTerm.asc(task.plannedStartTime)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Stream<List<StudyTask>> watchByStatusOnDate(TaskStatus status, DateTime date) {
    final day = calendarDate(date);
    final query = _database.select(_database.studyTasks)
      ..where(
        (task) => task.status.equals(status.code) & task.plannedDate.equals(day),
      )
      ..orderBy([(task) => OrderingTerm.asc(task.plannedStartTime)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Stream<List<StudyTask>> watchBySubject(
    String subjectId, {
    TaskStatus? status,
  }) {
    final query = _database.select(_database.studyTasks)
      ..where((task) {
        final matchesSubject = task.subjectId.equals(subjectId);
        if (status == null) {
          return matchesSubject;
        }
        return matchesSubject & task.status.equals(status.code);
      })
      ..orderBy([(task) => OrderingTerm.asc(task.plannedDate)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<StudyTask> save(StudyTask task) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeStudyTask(task);
      await _checkReferences(normalized);
      await _database
          .into(_database.studyTasks)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await findById(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Study task was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<List<StudyTask>> saveAll(List<StudyTask> tasks) {
    return runDatabaseTransaction(_database, () async {
      final saved = <StudyTask>[];
      for (final task in tasks) {
        saved.add(await save(task));
      }
      return saved;
    });
  }

  @override
  Future<List<StudyTask>> listBacklog(String studyPlanId, DateTime today) async {
    final day = calendarDate(today);
    final query = _database.select(_database.studyTasks)
      ..where(
        (task) =>
            task.studyPlanId.equals(studyPlanId) &
            (task.status.equals(TaskStatus.missed.code) |
                (task.plannedDate.isSmallerThanValue(day) &
                    task.status.isIn([
                      TaskStatus.planned.code,
                      TaskStatus.partiallyCompleted.code,
                      TaskStatus.inProgress.code,
                    ]))),
      )
      ..orderBy([(task) => OrderingTerm.asc(task.plannedDate)]);
    final rows = await query.get();
    return [for (final row in rows) row.toDomain()];
  }

  @override
  Future<List<StudyTask>> listByPlan(String studyPlanId) async {
    final query = _database.select(_database.studyTasks)
      ..where((task) => task.studyPlanId.equals(studyPlanId))
      ..orderBy([(task) => OrderingTerm.asc(task.plannedDate)]);
    final rows = await query.get();
    return [for (final row in rows) row.toDomain()];
  }

  @override
  Future<PlannerRun> replaceGeneratedPlan({
    required PlannerRun run,
    required List<StudyTask> tasks,
  }) {
    return runDatabaseTransaction(_database, () async {
      final normalizedRun = normalizePlannerRun(run);
      final normalizedTasks = [for (final task in tasks) normalizeStudyTask(task)];
      for (final task in normalizedTasks) {
        if (task.studyPlanId != normalizedRun.studyPlanId ||
            task.generationBatchId != normalizedRun.id ||
            task.isLocked ||
            task.source != TaskSource.autoPlanner) {
          throw const ValidationException(
            ValidationIssue.requiredText,
            message: 'Generated task does not match this planner run.',
          );
        }
      }
      final checks = ReferenceChecks(_database);
      await checks.studyPlanExists(normalizedRun.studyPlanId);
      await (_database.delete(_database.studyTasks)..where(
            (task) =>
                task.studyPlanId.equals(normalizedRun.studyPlanId) &
                task.isLocked.equals(false) &
                task.source.equals(TaskSource.autoPlanner.code) &
                task.status.equals(TaskStatus.planned.code),
          ))
          .go();
      for (final task in normalizedTasks) {
        await _checkReferences(task);
        await _database.into(_database.studyTasks).insert(task.toCompanion());
      }
      await _database.into(_database.plannerRuns).insert(
        PlannerRunsCompanion.insert(
          id: normalizedRun.id,
          studyPlanId: normalizedRun.studyPlanId,
          trigger: normalizedRun.trigger.code,
          startedAt: normalizedRun.startedAt,
          completedAt: Value(normalizedRun.completedAt),
          inputTaskCount: normalizedRun.inputTaskCount,
          outputTaskCount: normalizedRun.outputTaskCount,
          riskLevel: normalizedRun.riskLevel.code,
          expectedFinishDate: Value(normalizedRun.expectedFinishDate),
          algorithmVersion: normalizedRun.algorithmVersion,
        ),
      );
      return normalizedRun;
    });
  }

  @override
  Future<PlannerRun> applyAdaptivePlan({
    required PlannerRun run,
    required List<StudyTask> tasks,
    required DateTime today,
  }) {
    return runDatabaseTransaction(_database, () async {
      final normalizedRun = normalizePlannerRun(run);
      final normalizedTasks = [for (final task in tasks) normalizeStudyTask(task)];
      final day = calendarDate(today);
      for (final task in normalizedTasks) {
        final allowed =
            task.source == TaskSource.autoPlanner ||
            task.source == TaskSource.revisionEngine ||
            task.source == TaskSource.catchUp;
        if (task.studyPlanId != normalizedRun.studyPlanId ||
            task.generationBatchId != normalizedRun.id ||
            task.isLocked ||
            !allowed ||
            task.status != TaskStatus.planned ||
            calendarDate(task.plannedDate).isBefore(day)) {
          throw const ValidationException(
            ValidationIssue.requiredText,
            message: 'Adaptive task does not match this planner run.',
          );
        }
      }
      final checks = ReferenceChecks(_database);
      await checks.studyPlanExists(normalizedRun.studyPlanId);
      await (_database.delete(_database.studyTasks)..where(
            (task) =>
                task.studyPlanId.equals(normalizedRun.studyPlanId) &
                task.isLocked.equals(false) &
                task.status.equals(TaskStatus.planned.code) &
                task.plannedDate.isBiggerOrEqualValue(day) &
                task.source.isIn([
                  TaskSource.autoPlanner.code,
                  TaskSource.revisionEngine.code,
                  TaskSource.catchUp.code,
                ]),
          ))
          .go();
      for (final task in normalizedTasks) {
        await _checkReferences(task);
        await _database.into(_database.studyTasks).insert(task.toCompanion());
      }
      await _database.into(_database.plannerRuns).insert(
        PlannerRunsCompanion.insert(
          id: normalizedRun.id,
          studyPlanId: normalizedRun.studyPlanId,
          trigger: normalizedRun.trigger.code,
          startedAt: normalizedRun.startedAt,
          completedAt: Value(normalizedRun.completedAt),
          inputTaskCount: normalizedRun.inputTaskCount,
          outputTaskCount: normalizedRun.outputTaskCount,
          riskLevel: normalizedRun.riskLevel.code,
          expectedFinishDate: Value(normalizedRun.expectedFinishDate),
          algorithmVersion: normalizedRun.algorithmVersion,
        ),
      );
      return normalizedRun;
    });
  }

  @override
  Future<void> delete(String id) {
    return runDatabaseTransaction(_database, () async {
      final removed = await (_database.delete(_database.studyTasks)
            ..where((task) => task.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Study task was not found.');
      }
    });
  }

  Future<void> _checkReferences(StudyTask task) async {
    final checks = ReferenceChecks(_database);
    await checks.subjectInPlan(
      subjectId: task.subjectId,
      studyPlanId: task.studyPlanId,
    );
    if (task.chapterId != null) {
      await checks.chapterInSubject(
        chapterId: task.chapterId!,
        subjectId: task.subjectId,
      );
    }
    if (task.examId != null) {
      await checks.examInPlan(examId: task.examId!, studyPlanId: task.studyPlanId);
    }
  }
}

extension on StudyTaskRow {
  StudyTask toDomain() {
    return StudyTask(
      id: id,
      studyPlanId: studyPlanId,
      subjectId: subjectId,
      chapterId: chapterId,
      topicId: topicId,
      examId: examId,
      taskType: TaskType.fromCode(taskType),
      title: title,
      plannedDate: calendarDate(plannedDate),
      plannedStartTime: plannedStartTime,
      plannedMinutes: plannedMinutes,
      actualMinutes: actualMinutes,
      priorityScore: priorityScore,
      isLocked: isLocked,
      status: TaskStatus.fromCode(status),
      completionPercent: completionPercent,
      source: TaskSource.fromCode(source),
      generationBatchId: generationBatchId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      completedAt: completedAt,
    );
  }
}

extension on StudyTask {
  StudyTasksCompanion toCompanion() {
    return StudyTasksCompanion.insert(
      id: id,
      studyPlanId: studyPlanId,
      subjectId: subjectId,
      chapterId: Value(chapterId),
      topicId: Value(topicId),
      examId: Value(examId),
      taskType: taskType.code,
      title: title,
      plannedDate: plannedDate,
      plannedStartTime: Value(plannedStartTime),
      plannedMinutes: plannedMinutes,
      actualMinutes: Value(actualMinutes),
      priorityScore: priorityScore,
      isLocked: isLocked,
      status: status.code,
      completionPercent: completionPercent,
      source: source.code,
      generationBatchId: Value(generationBatchId),
      createdAt: createdAt,
      updatedAt: updatedAt,
      completedAt: Value(completedAt),
    );
  }
}
