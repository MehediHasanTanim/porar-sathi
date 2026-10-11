import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/app/widgets/selection_card.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({this.showContinue = true, super.key});

  /// Onboarding asks the student to continue. The settings screen applies
  /// the choice as soon as a card is tapped.
  final bool showContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider).asData?.value;
    final language = settings?.language ?? AppLanguage.english;
    final theme = Theme.of(context);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: showContinue
          ? null
          : AppBar(
              title: Text(l10n.languageTitle),
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showContinue) ...[
                const SizedBox(height: AppSpacing.xl),
                Text(l10n.chooseLanguage, style: theme.textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.chooseLanguageSubtitle, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xl),
              ],
              SelectionCard(
                icon: Icons.translate,
                title: l10n.banglaTitle,
                subtitle: l10n.banglaSubtitle,
                selected: language == AppLanguage.bangla,
                onTap: () => controller.setLanguage(AppLanguage.bangla),
              ),
              const SizedBox(height: AppSpacing.sm),
              SelectionCard(
                icon: Icons.language,
                title: l10n.englishTitle,
                subtitle: l10n.englishSubtitle,
                selected: language == AppLanguage.english,
                onTap: () => controller.setLanguage(AppLanguage.english),
              ),
              const Spacer(),
              if (showContinue)
                PrimaryButton(
                  label: l10n.actionContinue,
                  onPressed: settings == null
                      ? null
                      : () async {
                          await controller.setOnboardingStep(
                            OnboardingStep.welcome.code,
                          );
                          if (context.mounted) {
                            context.go(OnboardingStep.welcome.route);
                          }
                        },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
