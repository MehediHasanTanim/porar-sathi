import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/logging/app_logger.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/notifications/application/notification_providers.dart';
import 'package:porar_sathi/features/notifications/application/reminder_copy.dart';
import 'package:porar_sathi/features/notifications/domain/plan_reminders.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

/// Rebuilds every future reminder from the current plan. Safe to call after
/// a replan, a finished task, an exam edit, a revision change, or a settings
/// save. Failures are logged so studying still works without reminders.
Future<void> reconcileReminders(WidgetRef ref) async {
  final scheduler = ref.read(notificationSchedulerProvider);
  try {
    final settings = await ref.read(settingsControllerProvider.future);
    final preferences = await ref.read(notificationPreferencesProvider.future);
    final l10n = await AppLocalizations.delegate.load(settings.language.locale);
    final permitted =
        preferences.remindersEnabled && await scheduler.isPermitted();
    final planId = settings.currentStudyPlanId;
    if (planId == null || !permitted) {
      await scheduler.replaceScheduled(const []);
      return;
    }
    final tasks = await ref
        .read(studyTaskRepositoryProvider)
        .listByPlan(planId);
    final revisions = await ref
        .read(revisionRepositoryProvider)
        .listByPlan(planId);
    final exams = await ref
        .read(examRepositoryProvider)
        .watchByPlan(planId)
        .first;
    final planned = planReminders(
      now: ref.read(clockProvider).now(),
      preferences: preferences,
      permitted: true,
      tasks: tasks,
      revisions: revisions,
      exams: exams,
      messages: reminderMessages(l10n, settings.language.locale),
    );
    await scheduler.replaceScheduled(planned);
  } on Object catch (error, stackTrace) {
    AppLogger.error(
      'Could not reconcile reminders',
      error: error,
      stackTrace: stackTrace,
    );
    try {
      await scheduler.replaceScheduled(const []);
    } on Object {
      // The plugin is unavailable. The study plan still works.
    }
  }
}
