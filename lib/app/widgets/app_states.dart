import 'package:flutter/material.dart';

import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class SkeletonList extends StatelessWidget {
  const SkeletonList({this.rows = 3, super.key});

  final int rows;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        for (var index = 0; index < rows; index++) ...[
          Container(
            height: 72,
            decoration: BoxDecoration(
              color: colors.outline,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label = message ?? l10n.stateLoading;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class NoSearchResults extends StatelessWidget {
  const NoSearchResults({
    required this.query,
    this.onClear,
    this.onEditSearch,
    super.key,
  });

  final String query;
  final VoidCallback? onClear;
  final VoidCallback? onEditSearch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyState(
      icon: Icons.search_off,
      title: l10n.noSearchResults(query),
      body: l10n.actionTryAnotherSearch,
      primaryLabel: onClear == null ? null : l10n.actionClearFilters,
      onPrimary: onClear,
      secondaryLabel: onEditSearch == null ? null : l10n.actionTryAnotherSearch,
      onSecondary: onEditSearch,
    );
  }
}

class MigrationState extends StatelessWidget {
  const MigrationState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return LoadingState(
      message: '${l10n.migrationTitle}\n${l10n.migrationBody}',
    );
  }
}

class PlannerFailureState extends StatelessWidget {
  const PlannerFailureState({this.onReview, this.onRetry, super.key});

  final VoidCallback? onReview;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyState(
      icon: Icons.event_busy,
      title: l10n.plannerFailedTitle,
      body: l10n.plannerFailedBody,
      primaryLabel: onRetry == null ? null : l10n.actionRetry,
      onPrimary: onRetry,
      secondaryLabel: onReview == null ? null : l10n.actionReviewSetup,
      onSecondary: onReview,
    );
  }
}

class ImpossibleScheduleNotice extends StatelessWidget {
  const ImpossibleScheduleNotice({
    required this.title,
    required this.summary,
    this.suggestions = const [],
    super.key,
  });

  final String title;
  final String summary;
  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(color: colors.danger),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(summary),
        for (final suggestion in suggestions) Text('• $suggestion'),
      ],
    );
  }
}

class NotificationDeniedState extends StatelessWidget {
  const NotificationDeniedState({this.onOpenSettings, super.key});

  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.notificationsDeniedTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.notificationsDeniedBody),
        if (onOpenSettings != null)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onOpenSettings,
              child: Text(l10n.actionOpenSettings),
            ),
          ),
      ],
    );
  }
}

class BackupFailedState extends StatelessWidget {
  const BackupFailedState({this.onRetry, this.onChooseLocation, super.key});

  final VoidCallback? onRetry;
  final VoidCallback? onChooseLocation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _FailureActions(
      title: l10n.backupFailedTitle,
      retryLabel: l10n.actionRetry,
      onRetry: onRetry,
      secondaryLabel: l10n.actionChooseAnotherLocation,
      onSecondary: onChooseLocation,
    );
  }
}

class RestoreFailedState extends StatelessWidget {
  const RestoreFailedState({this.onRetry, this.onChooseAnother, super.key});

  final VoidCallback? onRetry;
  final VoidCallback? onChooseAnother;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _FailureActions(
      title: l10n.restoreFailedTitle,
      body: l10n.restoreFailedBody,
      retryLabel: l10n.actionRetry,
      onRetry: onRetry,
      secondaryLabel: l10n.actionChooseAnotherBackup,
      onSecondary: onChooseAnother,
    );
  }
}

Future<void> showDeleteFailed(
  BuildContext context, {
  required VoidCallback onRetry,
}) async {
  final l10n = AppLocalizations.of(context);
  final retry = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deleteFailedTitle),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.actionRetry),
        ),
      ],
    ),
  );
  if (retry ?? false) {
    onRetry();
  }
}

void showSaveSuccess(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(l10n.settingsSaved)));
}

Future<void> showSaveFailed(
  BuildContext context, {
  required VoidCallback onRetry,
}) async {
  final l10n = AppLocalizations.of(context);
  final retry = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.errorSaveFailed),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.actionRetry),
        ),
      ],
    ),
  );
  if (retry ?? false) {
    onRetry();
  }
}

class _FailureActions extends StatelessWidget {
  const _FailureActions({
    required this.title,
    required this.retryLabel,
    this.body,
    this.onRetry,
    this.secondaryLabel,
    this.onSecondary,
  });

  final String title;
  final String? body;
  final String retryLabel;
  final VoidCallback? onRetry;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        if (body != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(body!),
        ],
        if (onRetry != null) ...[
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(onPressed: onRetry, child: Text(retryLabel)),
        ],
        if (secondaryLabel != null && onSecondary != null)
          TextButton(onPressed: onSecondary, child: Text(secondaryLabel!)),
      ],
    );
  }
}
