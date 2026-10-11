import 'package:flutter/material.dart';

import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.studyPlan)),
      body: EmptyState(
        icon: Icons.calendar_month_outlined,
        title: l10n.studyPlan,
        body: l10n.planEmptyBody,
      ),
    );
  }
}
