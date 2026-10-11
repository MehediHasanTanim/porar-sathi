import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/backup_restore/application/backup_providers.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_archive.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_document.dart';
import 'package:porar_sathi/features/backup_restore/presentation/data_backup_screen.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class ExportBackupScreen extends ConsumerStatefulWidget {
  const ExportBackupScreen({super.key});

  @override
  ConsumerState<ExportBackupScreen> createState() => _ExportBackupScreenState();
}

class _ExportBackupScreenState extends ConsumerState<ExportBackupScreen> {
  var _protected = false;
  var _busy = false;
  var _failed = false;
  int? _estimate;
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _estimateSize());
  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.exportBackup)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.backupContainsStudyData),
          const SizedBox(height: AppSpacing.sm),
          RadioGroup<bool>(
            groupValue: _protected,
            onChanged: (value) {
              if (!_busy && value != null) {
                setState(() => _protected = value);
              }
            },
            child: Column(
              children: [
                RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.backupStandard),
                  subtitle: Text(l10n.backupNotEncrypted),
                  value: false,
                ),
                RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.backupEncrypted),
                  subtitle: const Text('AES-256-GCM'),
                  value: true,
                ),
              ],
            ),
          ),
          if (_protected) ...[
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(labelText: l10n.backupPassword),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _confirm,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.backupPasswordAgain,
                errorText: _passwordError,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.backupIncluded,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.backupIncludedBody),
          if (_estimate != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.backupEstimate(_formatSize(_estimate!, locale))),
          ],
          if (_failed) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.backupFailedTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: _busy ? null : _export,
              child: Text(l10n.actionRetry),
            ),
            TextButton(
              onPressed: _busy ? null : _export,
              child: Text(l10n.actionChooseAnotherLocation),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.actionExport,
            onPressed: _busy ? null : _export,
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _busy ? null : () => _export(share: true),
              child: Text(l10n.actionShare),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _estimateSize() async {
    try {
      final bytes = await _build(password: null);
      if (mounted) {
        setState(() => _estimate = bytes.length);
      }
    } on Object {
      // The export button reports a real failure.
    }
  }

  Future<void> _export({bool share = false}) async {
    final l10n = AppLocalizations.of(context);
    String? password;
    if (_protected) {
      if (_password.text.length < 8) {
        setState(() => _passwordError = l10n.backupPasswordShort);
        return;
      }
      if (_password.text != _confirm.text) {
        setState(() => _passwordError = l10n.backupPasswordMismatch);
        return;
      }
      password = _password.text;
    }
    setState(() {
      _busy = true;
      _failed = false;
      _passwordError = null;
    });
    try {
      final bytes = await _build(password: password);
      final name = _fileName(ref.read(clockProvider).now());
      if (share) {
        await ref
            .read(backupManagerProvider)
            .share(fileName: name, bytes: bytes);
      } else {
        final saved = await ref
            .read(backupManagerProvider)
            .save(fileName: name, bytes: bytes);
        if (!saved) {
          if (mounted) {
            setState(() => _busy = false);
          }
          return;
        }
      }
      final preferences = await SharedPreferences.getInstance();
      await preferences.setInt(lastBackupBytesKey, bytes.length);
      if (mounted) {
        setState(() {
          _busy = false;
          _estimate = bytes.length;
        });
      }
    } on Object {
      if (mounted) {
        setState(() {
          _busy = false;
          _failed = true;
        });
      }
    }
  }

  Future<Uint8List> _build({required String? password}) async {
    final settings = await ref.read(settingsControllerProvider.future);
    final payload = await ref.read(backupRepositoryProvider).readPayload();
    return encodeBackup(
      payload: payload,
      appVersion: backupAppVersion,
      createdAt: ref.read(clockProvider).now(),
      locale: settings.language.code,
      devicePlatform: defaultTargetPlatform.name,
      password: password,
    );
  }

  String _fileName(DateTime now) {
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    return 'porar-sathi-${now.year}-$month-$day.$backupFileExtension';
  }

  String _formatSize(int bytes, Locale locale) {
    if (bytes < 1024) {
      return '${LocaleFormat.formatNumber(bytes, locale)} B';
    }
    return '${LocaleFormat.formatNumber((bytes / 1024).round(), locale)} KB';
  }
}
