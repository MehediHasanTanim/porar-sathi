import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';

/// One date the allocator can fill. [used] changes while tasks are placed.
final class PlanningDay {
  PlanningDay({
    required this.capacity,
    required this.usableMinutes,
    required this.preferredStart,
  });

  final DayCapacity capacity;
  final int usableMinutes;
  final int? preferredStart;
  int used = 0;
  final Map<String, int> subjectMinutes = {};
  String? lastSubjectId;
  int consecutiveSame = 0;

  int get remaining {
    final left = usableMinutes - used;
    return left < 0 ? 0 : left;
  }
}

int capacityFactor(DailyIntensity intensity, PlanningMode mode) {
  final fromIntensity = switch (intensity) {
    DailyIntensity.light => 75,
    DailyIntensity.normal || DailyIntensity.focused || DailyIntensity.intensive => 100,
  };
  if (mode == PlanningMode.light && fromIntensity > 80) {
    return 80;
  }
  return fromIntensity;
}

/// Dates from today through the day before the latest exam.
///
/// With no exam, the range runs through the plan target, or 90 days.
List<PlanningDay> buildPlanningDays(PlanningInput input) {
  final start = input.plan.startDate.isAfter(input.today)
      ? calendarDate(input.plan.startDate)
      : input.today;
  final end = _horizonEnd(input, start);
  final locked = <DateTime, int>{};
  for (final task in input.lockedTasks) {
    if (task.status == TaskStatus.cancelled || task.status == TaskStatus.skipped) {
      continue;
    }
    final date = calendarDate(task.plannedDate);
    locked[date] = (locked[date] ?? 0) + task.plannedMinutes;
  }
  final factor = capacityFactor(input.plan.dailyIntensity, input.plan.planningMode);
  final days = <PlanningDay>[];
  var cursor = start;
  var guard = 0;
  while (cursor.isBefore(end) && guard < 366) {
    final capacity = capacityForDate(
      date: cursor,
      week: input.week,
      exceptions: input.exceptions,
      planningBufferPercent: input.plan.planningBufferPercent,
      lockedMinutes: locked[cursor] ?? 0,
    );
    final usable = (capacity.usableMinutes * factor / 100).floor();
    days.add(
      PlanningDay(
        capacity: capacity,
        usableMinutes: usable < 0 ? 0 : usable,
        preferredStart: _preferredStart(input.week, cursor.weekday),
      ),
    );
    cursor = cursor.add(const Duration(days: 1));
    guard += 1;
  }
  return days;
}

DateTime _horizonEnd(PlanningInput input, DateTime start) {
  DateTime? latestExam;
  for (final exam in input.exams) {
    if (exam.startDate.isBefore(input.today)) {
      continue;
    }
    if (latestExam == null || exam.startDate.isAfter(latestExam)) {
      latestExam = calendarDate(exam.startDate);
    }
  }
  if (latestExam != null) {
    return latestExam;
  }
  final target = input.plan.targetEndDate;
  if (target != null && !calendarDate(target).isBefore(start)) {
    return calendarDate(target).add(const Duration(days: 1));
  }
  return start.add(const Duration(days: 90));
}

int? _preferredStart(List<WeeklyAvailability> week, int weekday) {
  for (final day in week) {
    if (day.weekday == weekday) {
      return day.preferredStartTime;
    }
  }
  return null;
}
