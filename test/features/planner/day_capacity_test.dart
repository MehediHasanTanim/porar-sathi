import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';

void main() {
  final week = [
    for (final weekday in [DateTime.saturday, DateTime.sunday, DateTime.monday])
      WeeklyAvailability(
        id: 'day-$weekday',
        studyPlanId: 'plan',
        weekday: weekday,
        totalAvailableMinutes: weekday == DateTime.sunday ? 0 : 180,
        isStudyDay: weekday != DateTime.sunday,
        createdAt: DateTime(2026, 10, 11),
        updatedAt: DateTime(2026, 10, 11),
      ),
  ];

  DayCapacity capacity(DateTime date, List<CalendarException> exceptions) {
    return capacityForDate(
      date: date,
      week: week,
      exceptions: exceptions,
      planningBufferPercent: 10,
    );
  }

  test('a normal study day keeps a planning buffer', () {
    final day = capacity(DateTime(2026, 10, 10), const []);
    expect(day.baseMinutes, 180);
    expect(day.availableMinutes, 180);
    expect(day.bufferMinutes, 18);
    expect(day.schedulableMinutes, 162);
  });

  test('a no-study exception removes that days capacity', () {
    final day = capacity(DateTime(2026, 10, 10), [
      CalendarException(
        id: 'off',
        studyPlanId: 'plan',
        date: DateTime(2026, 10, 10),
        exceptionType: CalendarExceptionType.holiday,
        isNoStudyDay: true,
        availableMinutesOverride: 0,
        createdAt: DateTime(2026, 10, 11),
      ),
    ]);
    expect(day.schedulableMinutes, 0);
    expect(day.isNoStudyDay, isTrue);
  });

  test('reduced availability replaces the weekly minutes', () {
    final day = capacity(DateTime(2026, 10, 10), [
      CalendarException(
        id: 'short',
        studyPlanId: 'plan',
        date: DateTime(2026, 10, 10),
        exceptionType: CalendarExceptionType.coaching,
        isNoStudyDay: false,
        availableMinutesOverride: 60,
        createdAt: DateTime(2026, 10, 11),
      ),
    ]);
    expect(day.baseMinutes, 180);
    expect(day.availableMinutes, 60);
    expect(day.schedulableMinutes, 54);
  });

  test('an extra study day opens a day that was off', () {
    final day = capacity(DateTime(2026, 10, 11), [
      CalendarException(
        id: 'extra',
        studyPlanId: 'plan',
        date: DateTime(2026, 10, 11),
        exceptionType: CalendarExceptionType.custom,
        isNoStudyDay: false,
        availableMinutesOverride: 90,
        createdAt: DateTime(2026, 10, 11),
      ),
    ]);
    expect(day.baseMinutes, 0);
    expect(day.availableMinutes, 90);
    expect(day.schedulableMinutes, 81);
  });
}
