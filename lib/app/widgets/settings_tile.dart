import 'package:flutter/material.dart';

import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(title, style: Theme.of(context).textTheme.titleMedium),
                ),
                Icon(Icons.chevron_right, color: colors.muted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
