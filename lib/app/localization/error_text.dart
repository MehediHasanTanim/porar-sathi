import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

String errorText(AppException error, AppLocalizations l10n) {
  return switch (error) {
    ValidationException(:final issue) => switch (issue) {
      ValidationIssue.sessionDuration => l10n.errorSessionDuration,
      ValidationIssue.planningBuffer => l10n.errorPlanningBuffer,
      ValidationIssue.completionPercent => l10n.errorCompletionPercent,
      ValidationIssue.availabilityMinutes => l10n.errorAvailability,
      ValidationIssue.examDate => l10n.errorExamDate,
      ValidationIssue.requiredText ||
      ValidationIssue.dateRange ||
      ValidationIssue.estimatedMinutes ||
      ValidationIssue.weekday ||
      ValidationIssue.timeOfDay ||
      ValidationIssue.revisionBuffer ||
      ValidationIssue.statusTimestamp => l10n.errorGeneric,
    },
    DatabaseException() => l10n.errorGeneric,
    PlanningException() => l10n.errorGeneric,
    ImpossibleScheduleException() => l10n.errorGeneric,
    BackupException() => l10n.errorGeneric,
    RestoreException() => l10n.errorGeneric,
    NotificationException() => l10n.errorGeneric,
    PermissionException() => l10n.errorGeneric,
    UnexpectedException() => l10n.errorGeneric,
  };
}
