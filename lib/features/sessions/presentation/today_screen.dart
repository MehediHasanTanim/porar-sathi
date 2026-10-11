import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final now = ref.watch(clockProvider).now();
    final theme = Theme.of(context);
    final colors = context.semanticColors;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleFormat.greeting(now, l10n),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    LocaleFormat.formatDate(now, locale),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.muted,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: EmptyState(
                icon: Icons.menu_book_outlined,
                title: l10n.todayEmptyTitle,
                body: l10n.todayEmptyBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
