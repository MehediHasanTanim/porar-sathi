import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/progress/application/load_progress.dart';
import 'package:porar_sathi/features/progress/domain/progress_calculator.dart';
import 'package:porar_sathi/features/progress/domain/progress_report.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

Future<ProgressView?> loadProgressView(WidgetRef ref, {ProgressRange range = ProgressRange.month}) async {
  final settings = await ref.read(settingsControllerProvider.future);
  final planId = settings.currentStudyPlanId;
  if (planId == null) {
    return null;
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
  return buildProgressView(
    today: inputs.today,
    planStart: inputs.planStart,
    range: range,
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

class SubjectProgressScreen extends ConsumerStatefulWidget {
  const SubjectProgressScreen({required this.subjectId, super.key});

  final String subjectId;

  @override
  ConsumerState<SubjectProgressScreen> createState() => _SubjectProgressScreenState();
}

class _SubjectProgressScreenState extends ConsumerState<SubjectProgressScreen> {
  ProgressView? _view;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final view = await loadProgressView(ref);
      if (mounted) {
        setState(() => _view = view);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final view = _view;
    if (view == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final subject = view.subjects.where((item) => item.subjectId == widget.subjectId).firstOrNull;
    if (subject == null) {
      return Scaffold(appBar: AppBar(title: Text(l10n.navProgress)));
    }
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('${subject.percent}%', style: Theme.of(context).textTheme.headlineSmall),
          Text(l10n.chaptersCompleted(subject.chaptersCompleted, subject.chapterCount)),
          Text('${l10n.confidence} ${subject.confidencePercent}%'),
          Text('${l10n.studyTime} ${LocaleFormat.formatDuration(subject.studyMinutes, l10n)}'),
          Text(l10n.pendingTasks(subject.pendingTasks)),
          Text(l10n.revisionDueCount(subject.revisionDue)),
        ],
      ),
    );
  }
}

class ConsistencyScreen extends ConsumerStatefulWidget {
  const ConsistencyScreen({super.key});

  @override
  ConsumerState<ConsistencyScreen> createState() => _ConsistencyScreenState();
}

class _ConsistencyScreenState extends ConsumerState<ConsistencyScreen> {
  ProgressView? _week;
  ProgressView? _month;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final week = await loadProgressView(ref, range: ProgressRange.week);
      final month = await loadProgressView(ref, range: ProgressRange.month);
      if (mounted) {
        setState(() {
          _week = week;
          _month = month;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final week = _week;
    final month = _month;
    if (week == null || month == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.consistency)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.consistencyOf(month.consistency.studiedDays, month.consistency.availableDays),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Text('${l10n.rangeWeek}: ${l10n.consistencyOf(week.consistency.studiedDays, week.consistency.availableDays)}'),
          Text('${l10n.rangeMonth}: ${l10n.consistencyOf(month.consistency.studiedDays, month.consistency.availableDays)}'),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.consistencyNote),
        ],
      ),
    );
  }
}

class ReadinessScreen extends ConsumerStatefulWidget {
  const ReadinessScreen({super.key});

  @override
  ConsumerState<ReadinessScreen> createState() => _ReadinessScreenState();
}

class _ReadinessScreenState extends ConsumerState<ReadinessScreen> {
  ProgressView? _view;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final view = await loadProgressView(ref);
      if (mounted) {
        setState(() => _view = view);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final view = _view;
    if (view == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final readiness = view.readiness;
    final pace = view.pace;
    final colors = context.semanticColors;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.preparationReadiness)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('${readiness.percent}%', style: Theme.of(context).textTheme.headlineMedium),
          Text(
            _paceLabel(l10n, pace.pace),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: pace.pace == StudyPace.atRisk ? colors.danger : colors.success,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.paceBecause(_paceLabel(l10n, pace.pace))),
          Text(l10n.remainingWork(LocaleFormat.formatDuration(pace.remainingMinutes, l10n))),
          Text(l10n.capacityBeforeExam(LocaleFormat.formatDuration(pace.capacityMinutes, l10n))),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.syllabusProgress(readiness.syllabusPercent)),
          Text('${l10n.confidence} ${readiness.confidencePercent}%'),
          Text('${l10n.revisionCompletion} ${readiness.revisionPercent}%'),
          Text('${l10n.backlog} ${readiness.backlogHealthPercent}%'),
          Text('${l10n.consistency} ${readiness.consistencyPercent}%'),
          const SizedBox(height: AppSpacing.lg),
          AppCard(child: Text(l10n.readinessDisclaimer)),
        ],
      ),
    );
  }
}

class DailySummaryScreen extends ConsumerStatefulWidget {
  const DailySummaryScreen({super.key});

  @override
  ConsumerState<DailySummaryScreen> createState() => _DailySummaryScreenState();
}

class _DailySummaryScreenState extends ConsumerState<DailySummaryScreen> {
  ProgressView? _view;
  Map<String, String> _names = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final settings = await ref.read(settingsControllerProvider.future);
      final planId = settings.currentStudyPlanId;
      if (planId == null) {
        return;
      }
      final subjects = await ref.read(subjectRepositoryProvider).watchByPlan(planId).first;
      final view = await loadProgressView(ref);
      if (mounted) {
        setState(() {
          _view = view;
          _names = {for (final subject in subjects) subject.id: subject.name};
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final daily = _view?.daily;
    if (daily == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dailySummary)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('${l10n.targetLabel} ${LocaleFormat.formatDuration(daily.plannedMinutes, l10n)}'),
          Text('${l10n.studiedLabel} ${LocaleFormat.formatDuration(daily.actualMinutes, l10n)}'),
          Text('${l10n.completed} ${daily.completedTasks}'),
          Text('${l10n.actionPartial} ${daily.partialTasks}'),
          Text('${l10n.taskMissed} ${daily.missedTasks}'),
          Text(
            '${l10n.mostStudied} ${_names[daily.mostStudiedSubjectId] ?? l10n.noStudyYet}',
          ),
        ],
      ),
    );
  }
}

class WeeklySummaryScreen extends ConsumerStatefulWidget {
  const WeeklySummaryScreen({super.key});

  @override
  ConsumerState<WeeklySummaryScreen> createState() => _WeeklySummaryScreenState();
}

class _WeeklySummaryScreenState extends ConsumerState<WeeklySummaryScreen> {
  ProgressView? _view;
  Map<String, String> _names = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final settings = await ref.read(settingsControllerProvider.future);
      final planId = settings.currentStudyPlanId;
      if (planId == null) {
        return;
      }
      final subjects = await ref.read(subjectRepositoryProvider).watchByPlan(planId).first;
      final view = await loadProgressView(ref);
      if (mounted) {
        setState(() {
          _view = view;
          _names = {for (final subject in subjects) subject.id: subject.name};
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final week = _view?.weekly;
    if (week == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.weeklySummary)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('${l10n.targetLabel} ${LocaleFormat.formatDuration(week.targetMinutes, l10n)}'),
          Text('${l10n.studiedLabel} ${LocaleFormat.formatDuration(week.actualMinutes, l10n)}'),
          Text('${l10n.taskCompletion} ${week.taskCompletionPercent}%'),
          Text('${l10n.syllabusChange} ${week.syllabusDelta}%'),
          Text(l10n.revisionsCompleted(week.revisionCount)),
          Text('${l10n.mostImproved} ${_names[week.mostImprovedSubjectId] ?? l10n.noStudyYet}'),
          Text('${l10n.needsAttention} ${_names[week.neglectedSubjectId] ?? l10n.balancedStudy}'),
        ],
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
