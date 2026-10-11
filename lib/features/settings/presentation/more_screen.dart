import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/settings_tile.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.moreTitle)),
      body: ListView(
        padding: const EdgeInsets.only(top: AppSpacing.xs),
        children: [
          SettingsTile(
            icon: Icons.tune,
            iconColor: const Color(0xFF7C5CFC),
            title: l10n.studySettingsTitle,
            onTap: () => context.push(AppRoutes.settings),
          ),
          SettingsTile(
            icon: Icons.notifications_outlined,
            iconColor: const Color(0xFF2F6FED),
            title: l10n.notificationSettingsTitle,
            onTap: () => context.push(AppRoutes.notifications),
          ),
          SettingsTile(
            icon: Icons.palette_outlined,
            iconColor: const Color(0xFF2F6FED),
            title: l10n.appearanceTitle,
            onTap: () => context.push(AppRoutes.appearance),
          ),
          SettingsTile(
            icon: Icons.translate,
            iconColor: const Color(0xFF12B981),
            title: l10n.languageTitle,
            onTap: () => context.push(AppRoutes.language),
          ),
        ],
      ),
    );
  }
}
