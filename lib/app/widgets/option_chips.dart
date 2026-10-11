import 'package:flutter/material.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';

class OptionChips extends StatelessWidget {
  const OptionChips({
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (var index = 0; index < labels.length; index++)
          ChoiceChip(
            label: Text(labels[index]),
            selected: index == selectedIndex,
            onSelected: (_) => onSelected(index),
          ),
      ],
    );
  }
}

class LabeledField extends StatelessWidget {
  const LabeledField({
    required this.label,
    required this.child,
    super.key,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        child,
      ],
    );
  }
}
