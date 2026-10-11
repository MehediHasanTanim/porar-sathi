import 'package:flutter/material.dart';

import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSyllabus)),
      body: EmptyState(
        icon: Icons.menu_book_outlined,
        title: l10n.noSubjectsTitle,
        body: l10n.noSubjectsBody,
      ),
    );
  }
}
