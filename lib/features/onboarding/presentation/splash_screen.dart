import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/widgets/app_states.dart';
import 'package:porar_sathi/core/database/migration_notice.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final colors = context.semanticColors;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/branding/app_icon.png',
                width: 112,
                height: 112,
                semanticLabel: l10n.appName,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.appNameBangla,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: AppPalette.primary,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                l10n.appName,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.splashTagline,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.muted,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ValueListenableBuilder<bool>(
                valueListenable: databaseMigrationNotice,
                builder: (context, migrating, _) {
                  if (migrating) {
                    return const MigrationState();
                  }
                  return settings.when(
                    data: (_) => const _LoadingMark(),
                    loading: () => const _LoadingMark(),
                    error: (_, _) => Column(
                      children: [
                        Text(
                          l10n.errorGeneric,
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        FilledButton(
                          onPressed: () => ref
                              .read(settingsControllerProvider.notifier)
                              .reload(),
                          child: Text(l10n.actionRetry),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              if (!settings.hasError)
                Text(
                  l10n.loadingStudySpace,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.muted,
                  ),
                ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                l10n.offlineStudyPlanner,
                style: theme.textTheme.bodySmall?.copyWith(color: colors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingMark extends StatelessWidget {
  const _LoadingMark();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 28,
      height: 28,
      child: CircularProgressIndicator(strokeWidth: 3),
    );
  }
}
