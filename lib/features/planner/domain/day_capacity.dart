import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';

/// Minutes the planner can still place on one calendar day.
final class DayCapacity {
  const DayCapacity({
    required this.date,
    required this.baseMinutes,
    required this.availableMinutes,
    required this.bufferMinutes,
    required this.schedulableMinutes,
    required this.isNoStudyDay,
  });

  final DateTime date;
  final int baseMinutes;
  final int availableMinutes;
  final int bufferMinutes;
  final int schedulableMinutes;
  final bool isNoStudyDay;
}

/// Weekly pattern first, then a calendar exception replaces that day.
DayCapacity capacityForDate({
  required DateTime date,
  required List<WeeklyAvailability> week,
  required List<CalendarException> exceptions,
  required int planningBufferPercent,
}) {
  final day = calendarDate(date);
  WeeklyAvailability? pattern;
  for (final item in week) {
    if (item.weekday == day.weekday) {
      pattern = item;
    }
  }
  final base = (pattern != null && pattern.isStudyDay)
      ? pattern.totalAvailableMinutes
      : 0;

  CalendarException? exception;
  for (final item in exceptions) {
    if (calendarDate(item.date) == day) {
      exception = item;
    }
  }

  var available = base;
  var noStudy = base == 0;
  if (exception != null) {
    if (exception.isNoStudyDay) {
      available = 0;
      noStudy = true;
    } else {
      available = exception.availableMinutesOverride ?? base;
      noStudy = available == 0;
    }
  }

  final buffer = noStudy ? 0 : (available * planningBufferPercent / 100).round();
  final schedulable = available - buffer;
  return DayCapacity(
    date: day,
    baseMinutes: base,
    availableMinutes: available,
    bufferMinutes: buffer,
    schedulableMinutes: schedulable < 0 ? 0 : schedulable,
    isNoStudyDay: noStudy,
  );
}

int weeklyAvailableMinutes(List<DayCapacity> days) {
  return days.fold(0, (sum, day) => sum + day.availableMinutes);
}

int averageStudyDayMinutes(List<DayCapacity> days) {
  final studyDays = days.where((day) => day.availableMinutes > 0).toList();
  if (studyDays.isEmpty) {
    return 0;
  }
  final total = studyDays.fold(0, (sum, day) => sum + day.availableMinutes);
  return (total / studyDays.length).round();
}

/// Seven capacities starting Saturday of the week that contains [today].
List<DayCapacity> weekCapacity({
  required DateTime today,
  required List<WeeklyAvailability> week,
  required List<CalendarException> exceptions,
  required int planningBufferPercent,
}) {
  final start = calendarDate(today);
  final daysUntilSaturday = (start.weekday + 1) % 7;
  final saturday = start.subtract(Duration(days: daysUntilSaturday));
  return [
    for (var offset = 0; offset < 7; offset++)
      capacityForDate(
        date: saturday.add(Duration(days: offset)),
        week: week,
        exceptions: exceptions,
        planningBufferPercent: planningBufferPercent,
      ),
  ];
}
