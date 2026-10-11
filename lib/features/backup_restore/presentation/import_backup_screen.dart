import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_states.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/features/backup_restore/application/backup_providers.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_archive.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_document.dart';
import 'package:porar_sathi/features/notifications/application/reconcile_reminders.dart';
import 'package:porar_sathi/features/sessions/application/study_timer_controller.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

enum _ImportStep { choose, check, summary, confirm, failed, done }

class ImportBackupScreen extends ConsumerStatefulWidget {
  const ImportBackupScreen({super.key});

  @override
  ConsumerState<ImportBackupScreen> createState() => _ImportBackupScreenState();
}

class _ImportBackupScreenState extends ConsumerState<ImportBackupScreen> {
  _ImportStep _step = _ImportStep.choose;
  BackupAccepted? _accepted;
  BackupProblem? _problem;
  Uint8List? _bytes;
  String? _name;
  var _needsPassword = false;
  final _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.importBackup)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: switch (_step) {
          _ImportStep.choose => _choose(l10n),
          _ImportStep.check => _checking(l10n),
          _ImportStep.summary => _summary(l10n),
          _ImportStep.confirm => _confirm(l10n),
          _ImportStep.failed => _failed(),
          _ImportStep.done => _done(l10n),
        },
      ),
    );
  }

  List<Widget> _choose(AppLocalizations l10n) {
    return [
      Text(l10n.importBackupBody),
      if (_problem != null) ...[
        const SizedBox(height: AppSpacing.lg),
        ..._problemCopy(l10n),
      ],
      if (_needsPassword) ...[
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: _password,
          obscureText: true,
          decoration: InputDecoration(labelText: l10n.backupPassword),
        ),
      ],
      const SizedBox(height: AppSpacing.lg),
      PrimaryButton(
        label: _needsPassword
            ? l10n.actionTryPassword
            : l10n.actionChooseBackup,
        onPressed: _needsPassword ? _validate : _pick,
      ),
      if (_needsPassword)
        TextButton(
          onPressed: () => setState(() {
            _needsPassword = false;
            _problem = null;
            _bytes = null;
          }),
          child: Text(l10n.actionChooseAnotherBackup),
        ),
    ];
  }

  List<Widget> _checking(AppLocalizations l10n) {
    return [
      const LinearProgressIndicator(),
      const SizedBox(height: AppSpacing.lg),
      Text(l10n.backupReading),
      Text(l10n.backupCheckingVersion),
      Text(l10n.backupCheckingIntegrity),
      Text(l10n.backupValidatingData),
    ];
  }

  List<Widget> _summary(AppLocalizations l10n) {
    final accepted = _accepted;
    if (accepted == null) {
      return _choose(l10n);
    }
    final locale = Localizations.localeOf(context);
    return [
      Text(l10n.backupReading),
      Text(l10n.backupCheckingVersion),
      Text(l10n.backupCheckingIntegrity),
      Text(l10n.backupValidatingData),
      const SizedBox(height: AppSpacing.lg),
      Text(l10n.backupSummaryPlans(accepted.summary.plans)),
      Text(l10n.backupSummarySubjects(accepted.summary.subjects)),
      Text(l10n.backupSummarySessions(accepted.summary.sessions)),
      const SizedBox(height: AppSpacing.sm),
      Text(
        '${l10n.backupDate}: ${LocaleFormat.formatDate(accepted.summary.createdAt, locale)}',
      ),
      const SizedBox(height: AppSpacing.lg),
      PrimaryButton(
        label: l10n.actionContinue,
        onPressed: () => setState(() => _step = _ImportStep.confirm),
      ),
    ];
  }

  List<Widget> _confirm(AppLocalizations l10n) {
    final accepted = _accepted;
    if (accepted == null) {
      return _choose(l10n);
    }
    final locale = Localizations.localeOf(context);
    return [
      Text(
        l10n.restoreConfirmTitle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(l10n.restoreConfirmBody),
      const SizedBox(height: AppSpacing.sm),
      Text(
        '${l10n.backupDate}: ${LocaleFormat.formatDate(accepted.summary.createdAt, locale)}',
      ),
      Text(l10n.backupSummaryPlans(accepted.summary.plans)),
      Text(l10n.backupSummarySessions(accepted.summary.sessions)),
      const SizedBox(height: AppSpacing.lg),
      SizedBox(
        width: double.infinity,
        height: AppSpacing.buttonHeight,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: _restore,
          child: Text(l10n.actionRestoreBackup),
        ),
      ),
      TextButton(
        onPressed: () => setState(() => _step = _ImportStep.summary),
        child: Text(l10n.actionCancel),
      ),
    ];
  }

  List<Widget> _failed() {
    return [
      RestoreFailedState(
        onRetry: _restore,
        onChooseAnother: () => setState(() {
          _step = _ImportStep.choose;
          _accepted = null;
          _problem = null;
          _bytes = null;
          _needsPassword = false;
        }),
      ),
    ];
  }

  List<Widget> _done(AppLocalizations l10n) {
    final accepted = _accepted;
    return [
      Text(
        l10n.restoreCompleteTitle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      if (accepted != null) ...[
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.backupSummaryPlans(accepted.summary.plans)),
        Text(l10n.backupSummarySessions(accepted.summary.sessions)),
      ],
      const SizedBox(height: AppSpacing.lg),
      PrimaryButton(
        label: l10n.actionGoToday,
        onPressed: () => context.go(AppRoutes.today),
      ),
    ];
  }

  List<Widget> _problemCopy(AppLocalizations l10n) {
    final problem = _problem;
    final reasons = switch (problem) {
      BackupProblem.wrongPassword => [l10n.corruptPassword],
      BackupProblem.olderSchema ||
      BackupProblem.newerSchema => [l10n.corruptVersion],
      BackupProblem.fileType ||
      BackupProblem.partial ||
      BackupProblem.checksum ||
      BackupProblem.missingSection ||
      BackupProblem.relationship ||
      BackupProblem.corrupt ||
      null => [l10n.corruptDamaged, l10n.corruptPassword, l10n.corruptVersion],
    };
    return [
      Text(
        l10n.corruptBackupTitle,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: AppSpacing.xs),
      for (final reason in reasons) Text(reason),
    ];
  }

  Future<void> _pick() async {
    final picked = await ref.read(backupManagerProvider).pick();
    if (picked == null || !mounted) {
      return;
    }
    _bytes = picked.bytes;
    _name = picked.name;
    _needsPassword = backupNeedsPassword(picked.bytes);
    if (_needsPassword) {
      setState(() => _problem = BackupProblem.wrongPassword);
      return;
    }
    await _validate();
  }

  Future<void> _validate() async {
    final bytes = _bytes;
    final name = _name;
    if (bytes == null || name == null) {
      return;
    }
    setState(() => _step = _ImportStep.check);
    final inspection = await inspectBackup(
      bytes: bytes,
      fileName: name,
      password: _needsPassword ? _password.text : null,
    );
    if (!mounted) {
      return;
    }
    switch (inspection) {
      case BackupAccepted():
        setState(() {
          _accepted = inspection;
          _problem = null;
          _step = _ImportStep.summary;
        });
      case BackupRejected(:final problem):
        setState(() {
          _problem = problem;
          _needsPassword =
              problem == BackupProblem.wrongPassword &&
              backupNeedsPassword(bytes);
          _step = _ImportStep.choose;
        });
    }
  }

  Future<void> _restore() async {
    final accepted = _accepted;
    if (accepted == null) {
      return;
    }
    setState(() => _step = _ImportStep.check);
    try {
      await ref.read(backupRepositoryProvider).replaceAll(accepted.payload);
      final settings = await ref.read(settingsControllerProvider.future);
      final plans = accepted.payload.rows('studyPlans');
      final current = settings.currentStudyPlanId;
      final stillThere = plans.any((row) => row['id'] == current);
      if (!stillThere) {
        final next = plans.isEmpty ? null : plans.first['id'] as String?;
        await ref
            .read(settingsControllerProvider.notifier)
            .setCurrentStudyPlanId(next);
      }
      await ref.read(studyTimerControllerProvider.notifier).clear();
      await reconcileReminders(ref);
      if (mounted) {
        setState(() => _step = _ImportStep.done);
      }
    } on Object {
      if (mounted) {
        setState(() => _step = _ImportStep.failed);
      }
    }
  }
}
