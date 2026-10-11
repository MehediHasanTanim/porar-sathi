import 'package:flutter/material.dart';

import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgress)),
      body: EmptyState(
        icon: Icons.bar_chart_rounded,
        title: l10n.navProgress,
        body: l10n.progressEmptyBody,
      ),
    );
  }
}
