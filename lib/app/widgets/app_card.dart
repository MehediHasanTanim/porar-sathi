import 'package:flutter/material.dart';

import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.selected = false,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool selected;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final borderColor = selected ? AppPalette.primary : colors.outline;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
