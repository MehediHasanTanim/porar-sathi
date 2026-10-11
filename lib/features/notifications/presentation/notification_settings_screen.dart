import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/features/notifications/application/notification_providers.dart';
import 'package:porar_sathi/features/notifications/application/reconcile_reminders.dart';
import 'package:porar_sathi/features/notifications/domain/notification_preferences.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen>
    with WidgetsBindingObserver {
  bool? _permitted;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshPermission());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshPermission(reconcile: true);
    }
  }

  Future<void> _refreshPermission({bool reconcile = false}) async {
    try {
      final allowed = await ref
          .read(notificationSchedulerProvider)
          .isPermitted();
      if (mounted) {
        setState(() => _permitted = allowed);
      }
      if (reconcile) {
        await reconcileReminders(ref);
      }
    } on Object {
      if (mounted) {
        setState(() => _permitted = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preferences = ref
        .watch(notificationPreferencesProvider)
        .asData
        ?.value;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.notificationSettingsTitle)),
      body: preferences == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (_permitted == false) ...[
                  Text(
                    l10n.notificationsDeniedTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.notificationsDeniedBody),
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () async {
                        try {
                          await ref
                              .read(notificationSchedulerProvider)
                              .openSystemSettings();
                        } on Object {
                          // The explanation above stays on screen.
                        }
                      },
                      child: Text(l10n.actionOpenSettings),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.remindersEnabled),
                  value: preferences.remindersEnabled,
                  onChanged: (enabled) =>
                      _setEnabled(preferences, enabled: enabled),
                ),
                _toggle(
                  title: l10n.dailyPlanReminder,
                  value: preferences.dailyPlan,
                  onChanged: (value) =>
                      _save(preferences.copyWith(dailyPlan: value)),
                  time: preferences.dailyMinutes,
                  onTime: (minutes) =>
                      _save(preferences.copyWith(dailyMinutes: minutes)),
                ),
                _toggle(
                  title: l10n.studySessionReminder,
                  value: preferences.studySession,
                  onChanged: (value) =>
                      _save(preferences.copyWith(studySession: value)),
                ),
                _toggle(
                  title: l10n.revisionReminder,
                  value: preferences.revision,
                  onChanged: (value) =>
                      _save(preferences.copyWith(revision: value)),
                  time: preferences.revisionMinutes,
                  onTime: (minutes) =>
                      _save(preferences.copyWith(revisionMinutes: minutes)),
                ),
                _toggle(
                  title: l10n.examCountdownReminder,
                  value: preferences.examCountdown,
                  onChanged: (value) =>
                      _save(preferences.copyWith(examCountdown: value)),
                ),
                if (preferences.examCountdown) ...[
                  Text(
                    l10n.examThresholdsLabel,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    children: [
                      for (final day
                          in NotificationPreferences.examCountdownDays)
                        FilterChip(
                          label: Text(l10n.revisionDays(day)),
                          selected: preferences.examThresholds.contains(day),
                          onSelected: (selected) {
                            final next = {...preferences.examThresholds};
                            if (selected) {
                              next.add(day);
                            } else {
                              next.remove(day);
                            }
                            _save(preferences.copyWith(examThresholds: next));
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                _toggle(
                  title: l10n.missedTaskReminder,
                  value: preferences.missedTask,
                  onChanged: (value) =>
                      _save(preferences.copyWith(missedTask: value)),
                  time: preferences.missedMinutes,
                  onTime: (minutes) =>
                      _save(preferences.copyWith(missedMinutes: minutes)),
                ),
                _toggle(
                  title: l10n.eveningReviewReminder,
                  value: preferences.eveningReview,
                  onChanged: (value) =>
                      _save(preferences.copyWith(eveningReview: value)),
                  time: preferences.eveningMinutes,
                  onTime: (minutes) =>
                      _save(preferences.copyWith(eveningMinutes: minutes)),
                ),
              ],
            ),
    );
  }

  Widget _toggle({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    int? time,
    ValueChanged<int>? onTime,
  }) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          value: value,
          onChanged: onChanged,
        ),
        if (value && time != null && onTime != null)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.reminderTime),
            subtitle: Text(_formatTime(context, time)),
            onTap: () => _pickTime(time, onTime),
          ),
      ],
    );
  }

  Future<void> _setEnabled(
    NotificationPreferences preferences, {
    required bool enabled,
  }) async {
    if (!enabled) {
      await _save(preferences.copyWith(remindersEnabled: false));
      return;
    }
    try {
      final granted = await ref
          .read(notificationSchedulerProvider)
          .requestPermission();
      if (!mounted) {
        return;
      }
      setState(() => _permitted = granted);
      if (!granted) {
        return;
      }
    } on Object {
      if (mounted) {
        setState(() => _permitted = false);
      }
      return;
    }
    await _save(preferences.copyWith(remindersEnabled: true));
  }

  Future<void> _save(NotificationPreferences preferences) async {
    await ref.read(notificationPreferencesProvider.notifier).save(preferences);
    await reconcileReminders(ref);
  }

  Future<void> _pickTime(int minutes, ValueChanged<int> onTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
    );
    if (picked == null) {
      return;
    }
    onTime((picked.hour * 60) + picked.minute);
  }

  String _formatTime(BuildContext context, int minutes) {
    return MaterialLocalizations.of(context)
        .formatTimeOfDay(TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60));
  }
}
