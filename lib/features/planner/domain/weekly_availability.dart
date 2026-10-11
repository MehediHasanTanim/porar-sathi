import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'weekly_availability.freezed.dart';

@freezed
abstract class WeeklyAvailability with _$WeeklyAvailability {
  const factory WeeklyAvailability({
    required String id,
    required String studyPlanId,
    required int weekday,
    required int totalAvailableMinutes,
    required bool isStudyDay,
    int? preferredStartTime,
    int? preferredEndTime,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WeeklyAvailability;
}

WeeklyAvailability normalizeWeeklyAvailability(WeeklyAvailability day) {
  final weekday = requireValid(Validators.weekday(day.weekday));
  final minutes = requireValid(
    Validators.availabilityMinutes(day.totalAvailableMinutes),
  );
  final start = day.preferredStartTime == null
      ? null
      : requireValid(Validators.timeOfDayMinutes(day.preferredStartTime!));
  final end = day.preferredEndTime == null
      ? null
      : requireValid(Validators.timeOfDayMinutes(day.preferredEndTime!));
  if (start != null && end != null && end <= start) {
    throw const ValidationException(ValidationIssue.timeOfDay);
  }
  return day.copyWith(
    weekday: weekday,
    totalAvailableMinutes: minutes,
    preferredStartTime: start,
    preferredEndTime: end,
  );
}
