import 'package:flutter/material.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
