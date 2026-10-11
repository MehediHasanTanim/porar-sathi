import 'package:flutter/material.dart';

import 'package:porar_sathi/l10n/app_localizations.dart';

Future<bool> confirmAction(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmLabel,
  String? cancelLabel,
  bool destructive = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel ?? l10n.actionCancel),
        ),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                )
              : null,
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<bool> confirmDiscard(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return confirmAction(
    context,
    title: l10n.discardChangesTitle,
    body: l10n.discardChangesBody,
    confirmLabel: l10n.actionDiscard,
    cancelLabel: l10n.actionKeepEditing,
    destructive: true,
  );
}
