import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/planner/application/commit_day_rollover.dart';
import 'package:porar_sathi/features/planner/application/load_adaptive_plan.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/sessions/application/load_today.dart';
import 'package:porar_sathi/features/sessions/application/study_timer_controller.dart';
import 'package:porar_sathi/features/sessions/domain/study_timer.dart';
import 'package:porar_sathi/features/sessions/domain/today_dashboard.dart';
import 'package:porar_sathi/features/sessions/presentation/study_flow_screens.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/subjects/domain/subject_appearance.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  TodayDashboard? _dashboard;
  var _loading = true;
  var _hasPlan = false;
  var _needsReplan = false;

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
        setState(() {
          _hasPlan = false;
          _loading = false;
        });
      }
      return;
    }
    final clock = ref.read(clockProvider);
    final today = clock.today();
    try {
      await commitDayRollover(
        tasks: ref.read(studyTaskRepositoryProvider),
        revisions: ref.read(revisionRepositoryProvider),
        planId: planId,
        today: today,
        now: clock.now(),
      );
    } on Object {
      // Today still opens if rollover cannot be stored.
    }
    var needsReplan = false;
    if (settings.autoReplanEnabled) {
      try {
        final ids = ref.read(idGeneratorProvider);
        final proposal = await loadAdaptivePlan(
          plans: ref.read(studyPlanRepositoryProvider),
          subjects: ref.read(subjectRepositoryProvider),
          chapters: ref.read(chapterRepositoryProvider),
          exams: ref.read(examRepositoryProvider),
          availability: ref.read(availabilityRepositoryProvider),
          tasks: ref.read(studyTaskRepositoryProvider),
          revisions: ref.read(revisionRepositoryProvider),
          runs: ref.read(plannerRunRepositoryProvider),
          planId: planId,
          today: today,
          createdAt: clock.now(),
          runId: ids.next(),
          ids: [for (var index = 0; index < 40; index++) ids.next()],
          trigger: PlannerTrigger.missedTask,
        );
        if (proposal.diff.hasChanges && !proposal.diff.major) {
          await ref.read(studyTaskRepositoryProvider).applyAdaptivePlan(
            run: proposal.run,
            tasks: proposal.tasks,
            today: today,
          );
        }
        needsReplan = proposal.diff.major && proposal.diff.hasChanges;
      } on Object {
        needsReplan = false;
      }
    }
    final dashboard = await loadTodayDashboard(
      planId: planId,
      today: today,
      tasks: ref.read(studyTaskRepositoryProvider),
      subjects: ref.read(subjectRepositoryProvider),
      chapters: ref.read(chapterRepositoryProvider),
      exams: ref.read(examRepositoryProvider),
      revisions: ref.read(revisionRepositoryProvider),
      runs: ref.read(plannerRunRepositoryProvider),
    );
    if (mounted) {
      setState(() {
        _hasPlan = true;
        _dashboard = dashboard;
        _needsReplan = needsReplan;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = ref.watch(clockProvider).now();
    final timer = ref.watch(studyTimerControllerProvider).asData?.value;
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final dashboard = _dashboard;
    return Scaffold(
      body: SafeArea(
        child: dashboard == null || !_hasPlan
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(now: now),
                  Expanded(
                    child: EmptyState(
                      icon: Icons.menu_book_outlined,
                      title: l10n.todayEmptyTitle,
                      body: l10n.todayEmptyBody,
                    ),
                  ),
                ],
              )
            : ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  _Header(now: now),
                  if (_needsReplan) ...[
                    const SizedBox(height: AppSpacing.md),
                    AppCard(
                      onTap: () => context.push(AppRoutes.replan),
                      child: Text(l10n.planNeedsUpdate),
                    ),
                  ],
                  if (timer != null &&
                      (timer.phase == TimerPhase.running ||
                          timer.phase == TimerPhase.paused)) ...[
                    const SizedBox(height: AppSpacing.md),
                    AppCard(
                      onTap: () => context.push(AppRoutes.session),
                      child: Text(l10n.resumeSession),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  if (dashboard.allDone)
                    _Notice(title: l10n.todayAllDone, body: l10n.tomorrowReady)
                  else if (dashboard.tasks.isEmpty)
                    _Notice(title: l10n.todayEmptyTitle, body: l10n.todayEmptyBody)
                  else ...[
                    _Hero(dashboard: dashboard),
                    if (dashboard.nextExam != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      _ExamCard(dashboard: dashboard),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    Text(l10n.todayStudy, style: Theme.of(context).textTheme.titleMedium),
                    for (final item in dashboard.tasks) ...[
                      const SizedBox(height: AppSpacing.sm),
                      _TaskCard(
                        item: item,
                        onChanged: _load,
                      ),
                    ],
                  ],
                  if (dashboard.revisionDueCount > 0) ...[
                    const SizedBox(height: AppSpacing.lg),
                    AppCard(
                      child: Row(
                        children: [
                          Expanded(child: Text(l10n.revisionDueCount(dashboard.revisionDueCount))),
                          TextButton(
                            onPressed: () => context.push(AppRoutes.revisions),
                            child: Text(l10n.actionReview),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (dashboard.backlogMinutes > 0) ...[
                    const SizedBox(height: AppSpacing.sm),
                    AppCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.backlogBehind(
                                LocaleFormat.formatDuration(dashboard.backlogMinutes, l10n),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.push(AppRoutes.backlog),
                            child: Text(l10n.actionViewBacklog),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: l10n.actionQuickStudy,
                    onPressed: () async {
                      await context.push(AppRoutes.quickStudy);
                      await _load();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(body, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.now});

  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleFormat.greeting(now, l10n), style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          LocaleFormat.formatDate(now, Localizations.localeOf(context)),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.muted),
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.dashboard});

  final TodayDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.todayTarget, style: Theme.of(context).textTheme.titleSmall),
          Text(
            LocaleFormat.formatDuration(dashboard.plannedMinutes, l10n),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(l10n.tasksDone(dashboard.doneCount, dashboard.tasks.length)),
          Text(l10n.syllabusProgress(dashboard.syllabusPercent)),
        ],
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  const _ExamCard({required this.dashboard});

  final TodayDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exam = dashboard.nextExam!;
    final pace = _paceLabel(l10n, dashboard.pace);
    final colors = context.semanticColors;
    final color = switch (dashboard.pace) {
      StudyPace.ahead || StudyPace.onTrack => colors.success,
      StudyPace.slightlyBehind => colors.warning,
      StudyPace.behind || StudyPace.atRisk => colors.danger,
    };
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(exam.name, style: Theme.of(context).textTheme.titleMedium),
          if (dashboard.daysUntilExam != null) Text(l10n.daysRemaining(dashboard.daysUntilExam!)),
          Text(pace, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _TaskCard extends ConsumerWidget {
  const _TaskCard({required this.item, required this.onChanged});

  final TodayTaskItem item;
  final Future<void> Function() onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subject = item.subject;
    final priority = item.chapter?.priority ?? Priority.normal;
    return AppCard(
      onTap: () async {
        await context.push(AppRoutes.task(item.task.id));
        await onChanged();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 72,
            color: SubjectAppearance.colorFor(subject?.colorToken ?? 'blue'),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject?.name ?? item.task.title, style: Theme.of(context).textTheme.titleSmall),
                Text(item.chapter?.title ?? item.task.title),
                Text(LocaleFormat.formatDuration(item.task.plannedMinutes, l10n)),
                Text('${_typeLabel(l10n, item.task.taskType)} · ${_statusLabel(l10n, item.task.status)}'),
                if (priority == Priority.high || priority == Priority.critical)
                  Text(l10n.highPriority),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: taskIsDone(item.task)
                    ? null
                    : () => showStartSheet(
                        context: context,
                        ref: ref,
                        task: item.task,
                        subjectName: subject?.name ?? item.task.title,
                        title: item.chapter?.title ?? item.task.title,
                        examName: null,
                      ),
                child: Text(l10n.actionStart),
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'complete':
                      await context.push(AppRoutes.completeTask(item.task.id));
                    case 'partial':
                      await context.push(AppRoutes.partialTask(item.task.id));
                    case 'move':
                      await context.push(AppRoutes.moveTask(item.task.id));
                    case 'skip':
                      await showSkipSheet(context: context, ref: ref, task: item.task);
                  }
                  await onChanged();
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'complete', child: Text(l10n.actionComplete)),
                  PopupMenuItem(value: 'partial', child: Text(l10n.actionPartial)),
                  PopupMenuItem(value: 'skip', child: Text(l10n.actionSkip)),
                  PopupMenuItem(value: 'move', child: Text(l10n.actionMove)),
                ],
              ),
            ],
          ),
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

String _typeLabel(AppLocalizations l10n, TaskType type) {
  return switch (type) {
    TaskType.newStudy => l10n.taskNewStudy,
    TaskType.continueStudy => l10n.taskContinue,
    TaskType.revision => l10n.taskRevision,
    TaskType.practice => l10n.taskPractice,
    _ => l10n.taskNewStudy,
  };
}

String _statusLabel(AppLocalizations l10n, TaskStatus status) {
  return switch (status) {
    TaskStatus.completed => l10n.completed,
    TaskStatus.partiallyCompleted || TaskStatus.inProgress => l10n.inProgress,
    TaskStatus.missed => l10n.taskMissed,
    TaskStatus.skipped => l10n.skipped,
    TaskStatus.cancelled => l10n.skipped,
    TaskStatus.planned => l10n.taskPlanned,
  };
}
