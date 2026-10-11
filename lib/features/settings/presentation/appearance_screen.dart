import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/selection_card.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class AppearanceScreen extends ConsumerWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider).asData?.value;
    final theme = settings?.theme ?? AppThemePreference.system;
    final reducedMotion = settings?.reducedMotion ?? false;
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appearanceTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          SelectionCard(
            icon: Icons.light_mode_outlined,
            title: l10n.themeLight,
            subtitle: '',
            selected: theme == AppThemePreference.light,
            onTap: () => controller.setTheme(AppThemePreference.light),
          ),
          const SizedBox(height: AppSpacing.sm),
          SelectionCard(
            icon: Icons.dark_mode_outlined,
            title: l10n.themeDark,
            subtitle: '',
            selected: theme == AppThemePreference.dark,
            onTap: () => controller.setTheme(AppThemePreference.dark),
          ),
          const SizedBox(height: AppSpacing.sm),
          SelectionCard(
            icon: Icons.phone_iphone,
            title: l10n.themeSystem,
            subtitle: '',
            selected: theme == AppThemePreference.system,
            onTap: () => controller.setTheme(AppThemePreference.system),
          ),
          const SizedBox(height: AppSpacing.lg),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.reducedMotion),
            subtitle: Text(l10n.reducedMotionHelp),
            value: reducedMotion,
            onChanged: (value) =>
                controller.setReducedMotion(enabled: value),
          ),
        ],
      ),
    );
  }
}
