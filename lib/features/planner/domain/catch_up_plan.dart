import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';

final class DaySpare {
  const DaySpare({required this.date, required this.spareMinutes});

  final DateTime date;
  final int spareMinutes;
}

final class CatchUpDay {
  const CatchUpDay({required this.date, required this.minutes});

  final DateTime date;
  final int minutes;
}

final class CatchUpPlan {
  const CatchUpPlan({
    required this.days,
    required this.recoveryDays,
    required this.risk,
    required this.placedMinutes,
    required this.unplacedMinutes,
    required this.recoveredBy,
  });

  final List<CatchUpDay> days;
  final int recoveryDays;
  final PlannerRiskLevel risk;
  final int placedMinutes;
  final int unplacedMinutes;
  final DateTime? recoveredBy;
}

/// Spare minutes left after tasks that already occupy each day.
List<DaySpare> spareCapacity({
  required DateTime today,
  required List<WeeklyAvailability> week,
  required List<CalendarException> exceptions,
  required int planningBufferPercent,
  required List<StudyTask> occupying,
  int days = 14,
}) {
  final start = calendarDate(today);
  final used = <DateTime, int>{};
  for (final task in occupying) {
    if (task.status == TaskStatus.cancelled || task.status == TaskStatus.skipped) {
      continue;
    }
    if (task.status == TaskStatus.completed || task.status == TaskStatus.missed) {
      continue;
    }
    final date = calendarDate(task.plannedDate);
    used[date] = (used[date] ?? 0) + task.plannedMinutes;
  }
  final spare = <DaySpare>[];
  for (var offset = 0; offset < days; offset++) {
    final date = start.add(Duration(days: offset));
    final capacity = capacityForDate(
      date: date,
      week: week,
      exceptions: exceptions,
      planningBufferPercent: planningBufferPercent,
    );
    final left = capacity.usableMinutes - (used[date] ?? 0);
    spare.add(DaySpare(date: date, spareMinutes: left < 0 ? 0 : left));
  }
  return spare;
}

/// Fills future spare capacity, and stops at the exam date.
CatchUpPlan buildCatchUpPlan({
  required int backlogMinutes,
  required List<DaySpare> spare,
  DateTime? examDate,
}) {
  final exam = examDate == null ? null : calendarDate(examDate);
  var left = backlogMinutes < 0 ? 0 : backlogMinutes;
  final days = <CatchUpDay>[];
  final ordered = [...spare]..sort((a, b) => a.date.compareTo(b.date));
  for (final day in ordered) {
    if (left <= 0) {
      break;
    }
    final date = calendarDate(day.date);
    if (exam != null && !date.isBefore(exam)) {
      continue;
    }
    if (day.spareMinutes <= 0) {
      continue;
    }
    final take = left < day.spareMinutes ? left : day.spareMinutes;
    days.add(CatchUpDay(date: date, minutes: take));
    left -= take;
  }
  final placed = backlogMinutes < 0 ? 0 : backlogMinutes - left;
  return CatchUpPlan(
    days: days,
    recoveryDays: days.length,
    risk: _risk(unplaced: left, recoveredBy: days.isEmpty ? null : days.last.date, exam: exam),
    placedMinutes: placed < 0 ? 0 : placed,
    unplacedMinutes: left,
    recoveredBy: days.isEmpty ? null : days.last.date,
  );
}

PlannerRiskLevel _risk({
  required int unplaced,
  required DateTime? recoveredBy,
  required DateTime? exam,
}) {
  if (unplaced > 0) {
    return exam == null ? PlannerRiskLevel.high : PlannerRiskLevel.impossible;
  }
  if (recoveredBy != null && exam != null && exam.difference(recoveredBy).inDays <= 3) {
    return PlannerRiskLevel.low;
  }
  return PlannerRiskLevel.none;
}
