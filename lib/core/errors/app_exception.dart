/// Typed failures. Screens map these to localized copy and never show
/// raw database or plugin errors.
sealed class AppException implements Exception {
  const AppException({this.message, this.cause});

  final String? message;
  final Object? cause;

  @override
  String toString() => '$runtimeType(${message ?? cause ?? ''})';
}

enum ValidationIssue {
  sessionDuration,
  planningBuffer,
  completionPercent,
  availabilityMinutes,
  examDate,
  requiredText,
  dateRange,
  estimatedMinutes,
  weekday,
  timeOfDay,
  revisionBuffer,
  statusTimestamp,
}

final class ValidationException extends AppException {
  const ValidationException(this.issue, {super.message, super.cause});

  final ValidationIssue issue;
}

final class DatabaseException extends AppException {
  const DatabaseException({super.message, super.cause});
}

final class PlanningException extends AppException {
  const PlanningException({super.message, super.cause});
}

final class ImpossibleScheduleException extends AppException {
  const ImpossibleScheduleException({super.message, super.cause});
}

final class BackupException extends AppException {
  const BackupException({super.message, super.cause});
}

final class RestoreException extends AppException {
  const RestoreException({super.message, super.cause});
}

final class NotificationException extends AppException {
  const NotificationException({super.message, super.cause});
}

final class PermissionException extends AppException {
  const PermissionException({super.message, super.cause});
}

final class UnexpectedException extends AppException {
  const UnexpectedException({super.message, super.cause});
}
