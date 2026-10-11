import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_states.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class StudySettingsScreen extends ConsumerStatefulWidget {
  const StudySettingsScreen({super.key});

  @override
  ConsumerState<StudySettingsScreen> createState() =>
      _StudySettingsScreenState();
}

class _StudySettingsScreenState extends ConsumerState<StudySettingsScreen> {
  StudyPlan? _plan;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPlan());
  }

  Future<void> _loadPlan() async {
    final settings = await ref.read(settingsControllerProvider.future);
    final id = settings.currentStudyPlanId;
    if (id == null) {
      if (mounted) {
        setState(() => _plan = null);
      }
      return;
    }
    final plan = await ref.read(studyPlanRepositoryProvider).findById(id);
    if (mounted) {
      setState(() => _plan = plan);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider).asData?.value;
    if (settings == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.studySettingsTitle)),
        body: const LoadingState(),
      );
    }

    final plan = _plan;
    final session = plan?.maxSessionMinutes ?? settings.defaultSessionDuration;
    final buffer = plan?.planningBufferPercent ?? settings.planningBuffer;
    final workload = plan?.maxDailyMinutes ?? settings.maxDailyMinutes;
    final mode = plan?.planningMode ?? settings.defaultPlanningMode;
    final intensity = plan?.dailyIntensity ?? settings.defaultDailyIntensity;
    final colors = context.semanticColors;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.studySettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          if (plan != null)
            Text(
              l10n.settingsApplyToPlan,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
          _ChoiceSection(
            title: l10n.firstDayOfWeek,
            children: [
              for (final day in FirstDayOfWeek.values)
                ChoiceChip(
                  label: Text(_dayLabel(l10n, day)),
                  selected: settings.firstDayOfWeek == day,
                  onSelected: (_) => _save(
                    () => ref
                        .read(settingsControllerProvider.notifier)
                        .setFirstDayOfWeek(day),
                  ),
                ),
            ],
          ),
          _ChoiceSection(
            title: l10n.defaultSession,
            children: [
              for (final minutes in const [30, 45, 60, 90])
                ChoiceChip(
                  label: Text(LocaleFormat.formatDuration(minutes, l10n)),
                  selected: session == minutes,
                  onSelected: (_) => _savePlan(
                    () => ref
                        .read(settingsControllerProvider.notifier)
                        .setDefaultSessionDuration(minutes),
                    (current) => current.copyWith(maxSessionMinutes: minutes),
                  ),
                ),
            ],
          ),
          _ChoiceSection(
            title: l10n.planningBuffer,
            help: l10n.planningBufferHelp,
            children: [
              for (final percent in const [10, 15, 20])
                ChoiceChip(
                  label: Text(l10n.bufferPercent(percent)),
                  selected: buffer == percent,
                  onSelected: (_) => _savePlan(
                    () => ref
                        .read(settingsControllerProvider.notifier)
                        .setPlanningBuffer(percent),
                    (current) =>
                        current.copyWith(planningBufferPercent: percent),
                  ),
                ),
            ],
          ),
          _ChoiceSection(
            title: l10n.maxDailyWorkload,
            children: [
              for (final minutes in const [60, 120, 180, 240])
                ChoiceChip(
                  label: Text(LocaleFormat.formatDuration(minutes, l10n)),
                  selected: workload == minutes,
                  onSelected: (_) => _savePlan(
                    () => ref
                        .read(settingsControllerProvider.notifier)
                        .setMaxDailyMinutes(minutes),
                    (current) => current.copyWith(maxDailyMinutes: minutes),
                  ),
                ),
            ],
          ),
          _ChoiceSection(
            title: l10n.revisionPolicy,
            help: _policyHelp(l10n, settings.revisionPolicy),
            children: [
              for (final policy in RevisionPolicy.values)
                ChoiceChip(
                  label: Text(_policyLabel(l10n, policy)),
                  selected: settings.revisionPolicy == policy,
                  onSelected: (_) => _save(
                    () => ref
                        .read(settingsControllerProvider.notifier)
                        .setRevisionPolicy(policy),
                  ),
                ),
            ],
          ),
          _ChoiceSection(
            title: l10n.planningMode,
            children: [
              for (final value in const [
                PlanningMode.balanced,
                PlanningMode.weakSubjectFocus,
                PlanningMode.light,
                PlanningMode.examCrunch,
              ])
                ChoiceChip(
                  label: Text(_modeLabel(l10n, value)),
                  selected: mode == value,
                  onSelected: (_) => _savePlan(
                    () => ref
                        .read(settingsControllerProvider.notifier)
                        .setDefaultPlanningMode(value),
                    (current) => current.copyWith(planningMode: value),
                  ),
                ),
            ],
          ),
          _ChoiceSection(
            title: l10n.studyIntensity,
            children: [
              for (final value in DailyIntensity.values)
                ChoiceChip(
                  label: Text(_intensityLabel(l10n, value)),
                  selected: intensity == value,
                  onSelected: (_) => _savePlan(
                    () => ref
                        .read(settingsControllerProvider.notifier)
                        .setDefaultDailyIntensity(value),
                    (current) => current.copyWith(dailyIntensity: value),
                  ),
                ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.autoReplan),
            subtitle: Text(l10n.autoReplanHelp),
            value: settings.autoReplanEnabled,
            onChanged: (value) => _save(
              () => ref
                  .read(settingsControllerProvider.notifier)
                  .setAutoReplanEnabled(enabled: value),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save(Future<void> Function() action) async {
    try {
      await action();
      if (mounted) {
        showSaveSuccess(context);
      }
    } on Object {
      if (!mounted) {
        return;
      }
      await showSaveFailed(context, onRetry: () => _save(action));
    }
  }

  Future<void> _savePlan(
    Future<void> Function() settingsWrite,
    StudyPlan Function(StudyPlan current) transform,
  ) async {
    try {
      final plan = _plan;
      if (plan != null) {
        final saved = await ref
            .read(studyPlanRepositoryProvider)
            .save(
              transform(plan)
                  .copyWith(updatedAt: ref.read(clockProvider).now()),
            );
        if (mounted) {
          setState(() => _plan = saved);
        }
      }
      await settingsWrite();
      if (mounted) {
        showSaveSuccess(context);
      }
    } on Object {
      if (!mounted) {
        return;
      }
      await showSaveFailed(
        context,
        onRetry: () => _savePlan(settingsWrite, transform),
      );
    }
  }
}

class _ChoiceSection extends StatelessWidget {
  const _ChoiceSection({
    required this.title,
    required this.children,
    this.help,
  });

  final String title;
  final String? help;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          if (help != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              help!,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: children,
          ),
        ],
      ),
    );
  }
}

String _dayLabel(AppLocalizations l10n, FirstDayOfWeek day) {
  return switch (day) {
    FirstDayOfWeek.saturday => l10n.saturday,
    FirstDayOfWeek.sunday => l10n.sunday,
    FirstDayOfWeek.monday => l10n.monday,
  };
}

String _policyLabel(AppLocalizations l10n, RevisionPolicy policy) {
  return switch (policy) {
    RevisionPolicy.standard => l10n.revisionStandard,
    RevisionPolicy.light => l10n.revisionLight,
    RevisionPolicy.frequent => l10n.revisionFrequent,
  };
}

String _policyHelp(AppLocalizations l10n, RevisionPolicy policy) {
  return switch (policy) {
    RevisionPolicy.standard => l10n.revisionStandardHelp,
    RevisionPolicy.light => l10n.revisionLightHelp,
    RevisionPolicy.frequent => l10n.revisionFrequentHelp,
  };
}

String _modeLabel(AppLocalizations l10n, PlanningMode mode) {
  return switch (mode) {
    PlanningMode.weakSubjectFocus => l10n.modeWeak,
    PlanningMode.light => l10n.modeLight,
    PlanningMode.examCrunch => l10n.modeCrunch,
    _ => l10n.modeBalanced,
  };
}

String _intensityLabel(AppLocalizations l10n, DailyIntensity intensity) {
  return switch (intensity) {
    DailyIntensity.light => l10n.intensityLight,
    DailyIntensity.focused => l10n.intensityFocused,
    DailyIntensity.intensive => l10n.intensityIntensive,
    DailyIntensity.normal => l10n.intensityNormal,
  };
}
