import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/progress/application/load_progress.dart';
import 'package:porar_sathi/features/progress/domain/progress_calculator.dart';
import 'package:porar_sathi/features/progress/domain/progress_report.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  ProgressInputs? _inputs;
  var _range = ProgressRange.week;
  var _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final settings = await ref.read(settingsControllerProvider.future);
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      if (mounted) {
        setState(() => _loading = false);
      }
      return;
    }
    final inputs = await loadProgressInputs(
      plans: ref.read(studyPlanRepositoryProvider),
      subjects: ref.read(subjectRepositoryProvider),
      chapters: ref.read(chapterRepositoryProvider),
      exams: ref.read(examRepositoryProvider),
      availability: ref.read(availabilityRepositoryProvider),
      tasks: ref.read(studyTaskRepositoryProvider),
      revisions: ref.read(revisionRepositoryProvider),
      sessions: ref.read(studySessionRepositoryProvider),
      planId: planId,
      today: ref.read(clockProvider).today(),
    );
    if (mounted) {
      setState(() {
        _inputs = inputs;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final inputs = _inputs;
    if (inputs == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.navProgress)),
        body: EmptyState(
          icon: Icons.bar_chart_rounded,
          title: l10n.navProgress,
          body: l10n.progressEmptyBody,
        ),
      );
    }
    final view = _view(inputs);
    final names = {for (final subject in inputs.subjects) subject.id: subject.name};
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgress)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          OptionChips(
            labels: [l10n.rangeWeek, l10n.rangeMonth, l10n.rangeAll],
            selectedIndex: _range.index,
            onSelected: (index) => setState(() => _range = ProgressRange.values[index]),
          ),
          const SizedBox(height: AppSpacing.md),
          _Metric(label: l10n.syllabusProgress(view.syllabusPercent), value: ''),
          _Metric(
            label: l10n.studyTime,
            value: LocaleFormat.formatDuration(view.studyMinutes, l10n),
          ),
          _Metric(
            label: l10n.taskCompletion,
            value: l10n.tasksFraction(view.tasksCompleted, view.tasksTotal),
          ),
          _Metric(
            label: l10n.revisionCompletion,
            value: l10n.revisionsCompleted(view.revisionsCompleted),
          ),
          AppCard(
            onTap: () => context.push(AppRoutes.progressConsistency),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.consistency, style: Theme.of(context).textTheme.titleSmall),
                Text(
                  l10n.consistencyOf(view.consistency.studiedDays, view.consistency.availableDays),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _Metric(
            label: l10n.subjectBalance,
            value: view.neglectedSubjectId == null
                ? l10n.balancedStudy
                : (names[view.neglectedSubjectId] ?? l10n.needsAttention),
          ),
          _Metric(
            label: l10n.backlog,
            value: LocaleFormat.formatDuration(view.backlogMinutes, l10n),
          ),
          AppCard(
            onTap: () => context.push(AppRoutes.progressReadiness),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.preparationReadiness, style: Theme.of(context).textTheme.titleSmall),
                Text('${view.readiness.percent}%'),
                Text(
                  _paceLabel(l10n, view.pace.pace),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: _paceColor(context, view.pace.pace),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.subjectBalance, style: Theme.of(context).textTheme.titleMedium),
          for (final share in view.shares)
            Text('${names[share.subjectId] ?? share.subjectId} ${share.percent}%'),
          const SizedBox(height: AppSpacing.lg),
          for (final subject in view.subjects) ...[
            AppCard(
              onTap: () => context.push(AppRoutes.subjectProgress(subject.subjectId)),
              child: Row(
                children: [
                  Expanded(child: Text(subject.name)),
                  Text('${subject.percent}%'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.progressDaily),
            child: Text(l10n.dailySummary),
          ),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.progressWeekly),
            child: Text(l10n.weeklySummary),
          ),
        ],
      ),
    );
  }

  ProgressView _view(ProgressInputs inputs) {
    return buildProgressView(
      today: inputs.today,
      planStart: inputs.planStart,
      range: _range,
      subjects: inputs.subjects,
      chapters: inputs.chapters,
      tasks: inputs.tasks,
      sessions: inputs.sessions,
      revisions: inputs.revisions,
      backlogMinutes: inputs.backlogMinutes,
      capacityBeforeExam: inputs.capacityBeforeExam,
      daysBeforeExam: inputs.daysBeforeExam,
      revisionBufferDays: inputs.revisionBufferDays,
      isAvailable: inputs.availableDays.contains,
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            if (value.isNotEmpty) Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

String _paceLabel(AppLocalizations l10n, StudyPace pace) {
  return switch (pace) {
    StudyPace.ahead => l10n.paceAhead,
    StudyPace.onTrack => l10n.paceOnTrack,
    StudyPace.slightlyBehind => l10n.paceSlightlyBehind,
    StudyPace.behind => l10n.paceBehind,
    StudyPace.atRisk => l10n.paceAtRisk,
  };
}

Color _paceColor(BuildContext context, StudyPace pace) {
  final colors = context.semanticColors;
  return switch (pace) {
    StudyPace.ahead || StudyPace.onTrack => colors.success,
    StudyPace.slightlyBehind => colors.warning,
    StudyPace.behind || StudyPace.atRisk => colors.danger,
  };
}
