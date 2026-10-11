import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';

/// Minutes still owed on a task. Never negative.
int remainingTaskMinutes(StudyTask task) {
  final unfinishedPercent = 100 - task.completionPercent;
  final fromPercent = unfinishedPercent <= 0
      ? 0
      : (task.plannedMinutes * unfinishedPercent / 100).round();
  if (task.actualMinutes == null) {
    return fromPercent;
  }
  final fromActual = task.plannedMinutes - task.actualMinutes!;
  final left = fromActual < fromPercent ? fromActual : fromPercent;
  return left < 0 ? 0 : left;
}

final class DayRollover {
  const DayRollover({
    required this.tasks,
    required this.revisions,
    required this.remainingMinutes,
  });

  final List<StudyTask> tasks;
  final List<RevisionSchedule> revisions;
  final int remainingMinutes;

  bool get changed => tasks.isNotEmpty || revisions.isNotEmpty;
}

/// Marks yesterday's unfinished planned work as missed and overdue revisions.
///
/// Running it again on the same data returns no changes.
DayRollover rollOverDay({
  required List<StudyTask> tasks,
  required List<RevisionSchedule> revisions,
  required DateTime today,
  required DateTime now,
}) {
  final day = calendarDate(today);
  final missed = <StudyTask>[];
  var remaining = 0;
  for (final task in tasks) {
    final open =
        task.status == TaskStatus.planned || task.status == TaskStatus.partiallyCompleted;
    if (!open || !calendarDate(task.plannedDate).isBefore(day)) {
      continue;
    }
    final updated = task.copyWith(status: TaskStatus.missed, updatedAt: now);
    missed.add(updated);
    remaining += remainingTaskMinutes(updated);
  }
  final overdue = <RevisionSchedule>[];
  for (final revision in revisions) {
    final open =
        revision.status == RevisionStatus.pending || revision.status == RevisionStatus.scheduled;
    if (!open || !calendarDate(revision.dueDate).isBefore(day)) {
      continue;
    }
    overdue.add(revision.copyWith(status: RevisionStatus.overdue));
  }
  return DayRollover(tasks: missed, revisions: overdue, remainingMinutes: remaining);
}
