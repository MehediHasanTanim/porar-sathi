import 'package:flutter/material.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/syllabus/domain/syllabus_query.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

Future<SyllabusQuery?> showSyllabusFilterSheet(
  BuildContext context,
  SyllabusQuery current,
) {
  return showModalBottomSheet<SyllabusQuery>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _FilterSheet(current: current),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.current});

  final SyllabusQuery current;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late ChapterStatus? _status = widget.current.status;
  late Difficulty? _difficulty = widget.current.difficulty;
  late Confidence? _confidence = widget.current.confidence;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.filters, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.55,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.chapterStatus,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _chips(
                      selected: _status,
                      options: [
                        for (final status in ChapterStatus.values)
                          (status, _statusLabel(l10n, status)),
                      ],
                      onSelected: (status) => setState(() => _status = status),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.difficulty,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _chips(
                      selected: _difficulty,
                      options: [
                        for (final value in Difficulty.values)
                          (value, _difficultyLabel(l10n, value)),
                      ],
                      onSelected: (value) =>
                          setState(() => _difficulty = value),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.confidence,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _chips(
                      selected: _confidence,
                      options: [
                        for (final value in Confidence.values)
                          (value, _confidenceLabel(l10n, value)),
                      ],
                      onSelected: (value) =>
                          setState(() => _confidence = value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(
                      context,
                      SyllabusQuery(text: widget.current.text),
                    ),
                    child: Text(l10n.actionClear),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(
                      context,
                      SyllabusQuery(
                        text: widget.current.text,
                        status: _status,
                        difficulty: _difficulty,
                        confidence: _confidence,
                      ),
                    ),
                    child: Text(l10n.actionApply),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chips<T>({
    required T? selected,
    required List<(T, String)> options,
    required ValueChanged<T?> onSelected,
  }) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        FilterChip(
          label: Text(l10n.filterAll),
          selected: selected == null,
          onSelected: (_) => onSelected(null),
        ),
        for (final option in options)
          FilterChip(
            label: Text(option.$2),
            selected: selected == option.$1,
            onSelected: (_) => onSelected(option.$1),
          ),
      ],
    );
  }
}

String _statusLabel(AppLocalizations l10n, ChapterStatus status) {
  return switch (status) {
    ChapterStatus.notStarted => l10n.notStarted,
    ChapterStatus.planned => l10n.statusPlanned,
    ChapterStatus.inProgress => l10n.inProgress,
    ChapterStatus.completed => l10n.completed,
    ChapterStatus.revisionDue => l10n.revisionDue,
    ChapterStatus.revised => l10n.statusRevised,
    ChapterStatus.skipped => l10n.skipped,
  };
}

String _difficultyLabel(AppLocalizations l10n, Difficulty difficulty) {
  return switch (difficulty) {
    Difficulty.veryEasy => l10n.difficultyVeryEasy,
    Difficulty.easy => l10n.difficultyEasy,
    Difficulty.moderate => l10n.difficultyModerate,
    Difficulty.difficult => l10n.difficultyHard,
    Difficulty.veryDifficult => l10n.difficultyVeryDifficult,
  };
}

String _confidenceLabel(AppLocalizations l10n, Confidence confidence) {
  return switch (confidence) {
    Confidence.veryLow => l10n.confidenceVeryLow,
    Confidence.low => l10n.confidenceLow,
    Confidence.medium => l10n.confidenceMedium,
    Confidence.high => l10n.confidenceHigh,
    Confidence.veryHigh => l10n.confidenceVeryHigh,
  };
}
