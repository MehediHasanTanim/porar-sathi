import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';

enum ReplanChangeKind { moved, removed, added }

final class ReplanTaskChange {
  const ReplanTaskChange({
    required this.kind,
    required this.title,
    required this.subjectId,
    required this.chapterId,
    this.from,
    this.to,
    required this.minutes,
  });

  final ReplanChangeKind kind;
  final String title;
  final String subjectId;
  final String? chapterId;
  final DateTime? from;
  final DateTime? to;
  final int minutes;
}

final class ReplanDiff {
  const ReplanDiff({
    required this.moved,
    required this.removed,
    required this.added,
    required this.previousFinish,
    required this.nextFinish,
    required this.previousRisk,
    required this.nextRisk,
    required this.major,
  });

  final List<ReplanTaskChange> moved;
  final List<ReplanTaskChange> removed;
  final List<ReplanTaskChange> added;
  final DateTime? previousFinish;
  final DateTime? nextFinish;
  final PlannerRiskLevel? previousRisk;
  final PlannerRiskLevel nextRisk;
  final bool major;

  bool get hasChanges => moved.isNotEmpty || removed.isNotEmpty || added.isNotEmpty;

  int get changeCount => moved.length + removed.length + added.length;
}

/// Completed, in-progress, locked, and manual tasks stay where they are.
bool taskIsPreserved(StudyTask task, DateTime today) {
  if (task.isLocked || task.status != TaskStatus.planned) {
    return true;
  }
  if (calendarDate(task.plannedDate).isBefore(calendarDate(today))) {
    return true;
  }
  return task.source == TaskSource.manual || task.source == TaskSource.quickStudy;
}

bool taskIsReplaceable(StudyTask task, DateTime today) {
  if (taskIsPreserved(task, today)) {
    return false;
  }
  return task.source == TaskSource.autoPlanner ||
      task.source == TaskSource.revisionEngine ||
      task.source == TaskSource.catchUp;
}

ReplanDiff diffReplan({
  required DateTime today,
  required List<StudyTask> existing,
  required List<StudyTask> proposed,
  DateTime? previousFinish,
  DateTime? nextFinish,
  PlannerRiskLevel? previousRisk,
  required PlannerRiskLevel nextRisk,
}) {
  final before = [
    for (final task in existing)
      if (taskIsReplaceable(task, today)) task,
  ];
  final moved = <ReplanTaskChange>[];
  final removed = <ReplanTaskChange>[];
  final added = <ReplanTaskChange>[];
  final used = <int>{};
  for (final task in before) {
    final match = _match(task, proposed, used);
    if (match == null) {
      removed.add(
        ReplanTaskChange(
          kind: ReplanChangeKind.removed,
          title: task.title,
          subjectId: task.subjectId,
          chapterId: task.chapterId,
          from: calendarDate(task.plannedDate),
          minutes: task.plannedMinutes,
        ),
      );
      continue;
    }
    if (calendarDate(match.plannedDate) != calendarDate(task.plannedDate) ||
        match.plannedMinutes != task.plannedMinutes) {
      moved.add(
        ReplanTaskChange(
          kind: ReplanChangeKind.moved,
          title: match.title,
          subjectId: match.subjectId,
          chapterId: match.chapterId,
          from: calendarDate(task.plannedDate),
          to: calendarDate(match.plannedDate),
          minutes: match.plannedMinutes,
        ),
      );
    }
  }
  for (var index = 0; index < proposed.length; index++) {
    if (used.contains(index)) {
      continue;
    }
    final task = proposed[index];
    added.add(
      ReplanTaskChange(
        kind: ReplanChangeKind.added,
        title: task.title,
        subjectId: task.subjectId,
        chapterId: task.chapterId,
        to: calendarDate(task.plannedDate),
        minutes: task.plannedMinutes,
      ),
    );
  }
  final previousMinutes = before.fold<int>(0, (sum, task) => sum + task.plannedMinutes);
  final nextMinutes = proposed.fold<int>(0, (sum, task) => sum + task.plannedMinutes);
  final finishShift = previousFinish == null || nextFinish == null
      ? 0
      : nextFinish.difference(previousFinish).inDays.abs();
  final riskUp = previousRisk != null && nextRisk.index > previousRisk.index;
  final major = finishShift > 3 || riskUp || nextMinutes - previousMinutes > 60;
  return ReplanDiff(
    moved: moved,
    removed: removed,
    added: added,
    previousFinish: previousFinish,
    nextFinish: nextFinish,
    previousRisk: previousRisk,
    nextRisk: nextRisk,
    major: major,
  );
}

StudyTask? _match(StudyTask task, List<StudyTask> proposed, Set<int> used) {
  for (var index = 0; index < proposed.length; index++) {
    if (used.contains(index)) {
      continue;
    }
    final candidate = proposed[index];
    if (candidate.subjectId == task.subjectId &&
        candidate.chapterId == task.chapterId &&
        candidate.taskType == task.taskType &&
        candidate.source == task.source) {
      used.add(index);
      return candidate;
    }
  }
  return null;
}
