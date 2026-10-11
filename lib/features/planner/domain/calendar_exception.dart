import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'calendar_exception.freezed.dart';

@freezed
abstract class CalendarException with _$CalendarException {
  const factory CalendarException({
    required String id,
    required String studyPlanId,
    required DateTime date,
    required CalendarExceptionType exceptionType,
    int? availableMinutesOverride,
    String? reason,
    required bool isNoStudyDay,
    required DateTime createdAt,
  }) = _CalendarException;
}

CalendarException normalizeCalendarException(CalendarException exception) {
  final override = exception.availableMinutesOverride == null
      ? null
      : requireValid(
          Validators.availabilityMinutes(exception.availableMinutesOverride!),
        );
  if (exception.isNoStudyDay && override != null && override != 0) {
    throw const ValidationException(ValidationIssue.availabilityMinutes);
  }
  return exception.copyWith(
    date: calendarDate(exception.date),
    availableMinutesOverride: exception.isNoStudyDay ? 0 : override,
    reason: _optional(exception.reason),
  );
}

String? _optional(String? value) {
  if (value == null) {
    return null;
  }
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  if (trimmed.length > 160) {
    throw const ValidationException(ValidationIssue.requiredText);
  }
  return trimmed;
}
