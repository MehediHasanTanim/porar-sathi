import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';

/// Shared input checks used by settings and, later, academic forms.
abstract final class Validators {
  static Result<int> sessionMinutes(int minutes) {
    if (minutes <= 0 || minutes > 240) {
      return const Failure(ValidationException(ValidationIssue.sessionDuration));
    }
    return Success(minutes);
  }

  static Result<int> planningBufferPercent(int percent) {
    if (percent < 0 || percent > 50) {
      return const Failure(ValidationException(ValidationIssue.planningBuffer));
    }
    return Success(percent);
  }

  static Result<int> completionPercent(int percent) {
    if (percent < 0 || percent > 100) {
      return const Failure(
        ValidationException(ValidationIssue.completionPercent),
      );
    }
    return Success(percent);
  }

  static Result<int> availabilityMinutes(int minutes) {
    if (minutes < 0 || minutes > 1440) {
      return const Failure(
        ValidationException(ValidationIssue.availabilityMinutes),
      );
    }
    return Success(minutes);
  }

  static Result<DateTime> futureExamDate({
    required DateTime examDate,
    required DateTime today,
  }) {
    final date = DateTime(examDate.year, examDate.month, examDate.day);
    if (date.isBefore(today)) {
      return const Failure(ValidationException(ValidationIssue.examDate));
    }
    return Success(date);
  }

  static Result<String> requiredText(String value, {int maxLength = 120}) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.length > maxLength) {
      return const Failure(ValidationException(ValidationIssue.requiredText));
    }
    return Success(trimmed);
  }

  static Result<DateTime?> endOnOrAfter({
    required DateTime start,
    DateTime? end,
  }) {
    if (end == null) {
      return const Success(null);
    }
    final startDate = calendarDate(start);
    final endDate = calendarDate(end);
    if (endDate.isBefore(startDate)) {
      return const Failure(ValidationException(ValidationIssue.dateRange));
    }
    return Success(endDate);
  }

  static Result<int> estimatedMinutes(int minutes) {
    if (minutes < 0 || minutes > 100 * 60) {
      return const Failure(ValidationException(ValidationIssue.estimatedMinutes));
    }
    return Success(minutes);
  }

  static Result<int> weekday(int weekday) {
    if (weekday < DateTime.monday || weekday > DateTime.sunday) {
      return const Failure(ValidationException(ValidationIssue.weekday));
    }
    return Success(weekday);
  }

  static Result<int> timeOfDayMinutes(int minutes) {
    if (minutes < 0 || minutes >= 24 * 60) {
      return const Failure(ValidationException(ValidationIssue.timeOfDay));
    }
    return Success(minutes);
  }

  static Result<int> revisionBufferDays(int days) {
    if (days < 0 || days > 90) {
      return const Failure(ValidationException(ValidationIssue.revisionBuffer));
    }
    return Success(days);
  }
}
