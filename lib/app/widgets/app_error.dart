import 'package:flutter/material.dart';

import 'package:porar_sathi/app/localization/error_text.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

void showAppError(BuildContext context, Object error) {
  final l10n = AppLocalizations.of(context);
  final message = error is AppException
      ? errorText(error, l10n)
      : l10n.errorGeneric;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
