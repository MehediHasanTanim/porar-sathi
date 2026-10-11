import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    required this.step,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    this.subtitle,
    this.secondaryLabel,
    this.onSecondary,
    this.onBack,
    super.key,
  });

  final OnboardingStep step;
  final String title;
  final String? subtitle;
  final Widget body;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final progress = step.progress;
    final previous = step.previous;
    return PopScope(
      canPop: previous == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _back(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (previous != null)
                      IconButton(
                        onPressed: () => _back(context),
                        icon: const Icon(Icons.arrow_back),
                        tooltip: l10n.actionBack,
                      )
                    else
                      const SizedBox(width: AppSpacing.minTapTarget),
                    const Spacer(),
                    if (progress != null)
                      Text(
                        l10n.onboardingProgress(progress.$1, progress.$2),
                        style: theme.textTheme.labelLarge,
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(title, style: theme.textTheme.headlineMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(subtitle!, style: theme.textTheme.bodyMedium),
                ],
                const SizedBox(height: AppSpacing.lg),
                Expanded(child: body),
                PrimaryButton(label: primaryLabel, onPressed: onPrimary),
                if (secondaryLabel != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.minTapTarget,
                    child: TextButton(
                      onPressed: onSecondary,
                      child: Text(secondaryLabel!),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _back(BuildContext context) {
    if (onBack != null) {
      onBack!();
      return;
    }
    final previous = step.previous;
    if (previous != null) {
      context.go(previous.route);
    }
  }
}
