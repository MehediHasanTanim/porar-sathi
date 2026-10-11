import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';

abstract interface class AvailabilityRepository implements Repository {
  Stream<List<WeeklyAvailability>> watchWeek(String studyPlanId);

  Future<WeeklyAvailability> saveDay(WeeklyAvailability day);

  Future<void> replaceWeek(String studyPlanId, List<WeeklyAvailability> days);

  Future<void> deleteDay(String id);

  Stream<List<CalendarException>> watchExceptions(String studyPlanId);

  Future<CalendarException> saveException(CalendarException exception);

  Future<void> deleteException(String id);
}
