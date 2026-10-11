import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_states.dart';
import 'package:porar_sathi/app/widgets/confirm_dialog.dart';
import 'package:porar_sathi/app/widgets/settings_tile.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/features/backup_restore/application/backup_providers.dart';
import 'package:porar_sathi/features/notifications/application/reconcile_reminders.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';
import 'package:porar_sathi/features/sessions/application/study_timer_controller.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

const lastBackupBytesKey = 'last_backup_bytes';

class DataBackupScreen extends ConsumerStatefulWidget {
  const DataBackupScreen({super.key});

  @override
  ConsumerState<DataBackupScreen> createState() => _DataBackupScreenState();
}

class _DataBackupScreenState extends ConsumerState<DataBackupScreen> {
  int? _databaseBytes;
  int? _backupBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSizes());
  }

  Future<void> _loadSizes() async {
    try {
      final databaseBytes = await ref
          .read(backupRepositoryProvider)
          .databaseSizeBytes();
      final stored = (await SharedPreferences.getInstance()).getInt(
        lastBackupBytesKey,
      );
      if (mounted) {
        setState(() {
          _databaseBytes = databaseBytes;
          _backupBytes = stored;
        });
      }
    } on Object {
      // Sizes are informational. The backup actions still work.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dataBackupTitle)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        children: [
          SettingsTile(
            icon: Icons.upload_outlined,
            iconColor: const Color(0xFF2F6FED),
            title: l10n.exportBackup,
            onTap: () => context.push(AppRoutes.exportBackup),
          ),
          SettingsTile(
            icon: Icons.download_outlined,
            iconColor: const Color(0xFF12B981),
            title: l10n.importBackup,
            onTap: () => context.push(AppRoutes.importBackup),
          ),
          _heading(l10n.backupReports),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              l10n.reportsUnavailable,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          _heading(l10n.backupStorage),
          ListTile(
            title: Text(l10n.storageDatabase),
            subtitle: Text(_size(_databaseBytes, locale, l10n)),
          ),
          ListTile(
            title: Text(l10n.storageBackup),
            subtitle: Text(_size(_backupBytes, locale, l10n)),
          ),
          _heading(l10n.backupReset),
          ListTile(
            title: Text(l10n.resetProgress),
            subtitle: Text(l10n.resetProgressBody),
            onTap: _resetProgress,
          ),
          ListTile(
            title: Text(l10n.deletePlan),
            subtitle: Text(l10n.deletePlanBody),
            onTap: _deletePlan,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              0,
            ),
            child: Text(
              l10n.deleteSubjectHint,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ListTile(
            title: Text(l10n.actionDelete),
            subtitle: Text(l10n.navSyllabus),
            onTap: () => context.go(AppRoutes.syllabus),
          ),
          ListTile(
            title: Text(
              l10n.deleteAllData,
              style: TextStyle(color: theme.colorScheme.error),
            ),
            subtitle: Text(l10n.deleteAllDataBody),
            onTap: _deleteAll,
          ),
        ],
      ),
    );
  }

  Widget _heading(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xs,
      ),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  String _size(int? bytes, Locale locale, AppLocalizations l10n) {
    if (bytes == null) {
      return l10n.storageNone;
    }
    if (bytes < 1024) {
      return '${LocaleFormat.formatNumber(bytes, locale)} B';
    }
    final kilobytes = bytes / 1024;
    return '${LocaleFormat.formatNumber(kilobytes.round(), locale)} KB';
  }

  Future<void> _resetProgress() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmAction(
      context,
      title: l10n.resetProgress,
      body: l10n.resetProgressBody,
      confirmLabel: l10n.resetProgress,
      destructive: true,
    );
    if (!confirmed || !mounted) {
      return;
    }
    try {
      await ref.read(backupRepositoryProvider).resetProgress();
      await reconcileReminders(ref);
    } on Object {
      if (mounted) {
        await showDeleteFailed(context, onRetry: _resetProgress);
      }
    }
  }

  Future<void> _deletePlan() async {
    final l10n = AppLocalizations.of(context);
    final settings = await ref.read(settingsControllerProvider.future);
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      return;
    }
    if (!mounted) {
      return;
    }
    final confirmed = await confirmAction(
      context,
      title: l10n.deletePlan,
      body: l10n.deletePlanBody,
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (!confirmed || !mounted) {
      return;
    }
    try {
      await ref.read(studyPlanRepositoryProvider).delete(planId);
      await ref
          .read(settingsControllerProvider.notifier)
          .setCurrentStudyPlanId(null);
      await reconcileReminders(ref);
    } on Object {
      if (mounted) {
        await showDeleteFailed(context, onRetry: _deletePlan);
      }
    }
  }

  Future<void> _deleteAll() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmAction(
      context,
      title: l10n.deleteAllData,
      body: l10n.deleteAllDataBody,
      confirmLabel: l10n.deleteAllData,
      destructive: true,
    );
    if (!confirmed || !mounted) {
      return;
    }
    try {
      await ref.read(backupRepositoryProvider).deleteAll();
      await ref.read(studyTimerControllerProvider.notifier).clear();
      await ref.read(settingsControllerProvider.notifier).restartSetup();
      await reconcileReminders(ref);
      if (mounted) {
        context.go(OnboardingStep.language.route);
      }
    } on Object {
      if (mounted) {
        await showDeleteFailed(context, onRetry: _deleteAll);
      }
    }
  }
}
