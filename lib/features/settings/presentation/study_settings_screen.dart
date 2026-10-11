import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/localization/error_text.dart';
import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class StudySettingsScreen extends ConsumerWidget {
  const StudySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider).asData?.value;
    if (settings == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.studySettingsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final controller = ref.read(settingsControllerProvider.notifier);
    final colors = context.semanticColors;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.studySettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.firstDayOfWeek, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              ChoiceChip(
                label: Text(l10n.saturday),
                selected: settings.firstDayOfWeek == FirstDayOfWeek.saturday,
                onSelected: (_) =>
                    controller.setFirstDayOfWeek(FirstDayOfWeek.saturday),
              ),
              ChoiceChip(
                label: Text(l10n.sunday),
                selected: settings.firstDayOfWeek == FirstDayOfWeek.sunday,
                onSelected: (_) =>
                    controller.setFirstDayOfWeek(FirstDayOfWeek.sunday),
              ),
              ChoiceChip(
                label: Text(l10n.monday),
                selected: settings.firstDayOfWeek == FirstDayOfWeek.monday,
                onSelected: (_) =>
                    controller.setFirstDayOfWeek(FirstDayOfWeek.monday),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.defaultSession, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              for (final minutes in const [30, 45, 60, 90])
                ChoiceChip(
                  label: Text(LocaleFormat.formatDuration(minutes, l10n)),
                  selected: settings.defaultSessionDuration == minutes,
                  onSelected: (_) => _saveSession(context, controller, minutes),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.planningBuffer, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.planningBufferHelp,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.muted),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              for (final percent in const [10, 15, 20])
                ChoiceChip(
                  label: Text(l10n.bufferPercent(percent)),
                  selected: settings.planningBuffer == percent,
                  onSelected: (_) => _saveBuffer(context, controller, percent),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.autoReplan),
            subtitle: Text(l10n.autoReplanHelp),
            value: settings.autoReplanEnabled,
            onChanged: (value) => controller.setAutoReplanEnabled(enabled: value),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSession(
    BuildContext context,
    SettingsController controller,
    int minutes,
  ) async {
    await _save(context, () => controller.setDefaultSessionDuration(minutes));
  }

  Future<void> _saveBuffer(
    BuildContext context,
    SettingsController controller,
    int percent,
  ) async {
    await _save(context, () => controller.setPlanningBuffer(percent));
  }

  Future<void> _save(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
      await action();
    } on AppException catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorText(error, l10n))),
      );
    }
  }
}
