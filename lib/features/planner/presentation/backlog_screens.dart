import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/notifications/application/reconcile_reminders.dart';
import 'package:porar_sathi/features/planner/domain/adaptive_plan.dart';
import 'package:porar_sathi/features/planner/domain/catch_up_plan.dart';
import 'package:porar_sathi/features/planner/domain/day_rollover.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/sessions/presentation/study_flow_screens.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class BacklogDashboardScreen extends ConsumerStatefulWidget {
  const BacklogDashboardScreen({super.key});

  @override
  ConsumerState<BacklogDashboardScreen> createState() =>
      _BacklogDashboardScreenState();
}

class _BacklogDashboardScreenState
    extends ConsumerState<BacklogDashboardScreen> {
  BacklogSnapshot? _snapshot;
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
    final today = ref.read(clockProvider).today();
    final tasks = ref.read(studyTaskRepositoryProvider);
    final backlog = await tasks.listBacklog(planId, today);
    final subjects = await ref
        .read(subjectRepositoryProvider)
        .watchByPlan(planId, includeArchived: true)
        .first;
    final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
    final week = await ref
        .read(availabilityRepositoryProvider)
        .watchWeek(planId)
        .first;
    final exceptions = await ref
        .read(availabilityRepositoryProvider)
        .watchExceptions(planId)
        .first;
    final existing = await tasks.listByPlan(planId);
    final exams = await ref
        .read(examRepositoryProvider)
        .watchByPlan(planId)
        .first;
    DateTime? examDate;
    for (final exam in exams) {
      final start = calendarDate(exam.startDate);
      if (!start.isBefore(today) &&
          (examDate == null || start.isBefore(examDate))) {
        examDate = start;
      }
    }
    final snapshot = buildBacklogSnapshot(
      backlog: backlog,
      subjectNames: {for (final subject in subjects) subject.id: subject.name},
      spare: spareCapacity(
        today: today,
        week: week,
        exceptions: exceptions,
        planningBufferPercent: plan?.planningBufferPercent ?? 15,
        occupying: existing,
      ),
      examDate: examDate,
    );
    if (mounted) {
      setState(() {
        _snapshot = snapshot;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final snapshot = _snapshot;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.backlogTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : snapshot == null || snapshot.overdueCount == 0
          ? EmptyState(
              icon: Icons.inbox_outlined,
              title: l10n.backlogTitle,
              body: l10n.noBacklog,
            )
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text(l10n.overdueTasks(snapshot.overdueCount)),
                Text(
                  LocaleFormat.formatDuration(snapshot.remainingMinutes, l10n),
                ),
                Text(l10n.recoveryEstimate(snapshot.recovery.recoveryDays)),
                if (snapshot.oldest != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.oldestMissed,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  AppCard(
                    onTap: () => context.push(
                      AppRoutes.backlogTask(snapshot.oldest!.id),
                    ),
                    child: Text(snapshot.oldest!.title),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                for (final subject in snapshot.subjects)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Text('${subject.name} — ${subject.taskCount}'),
                  ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: l10n.actionBuildCatchUp,
                  onPressed: () => context.push(AppRoutes.catchUp),
                ),
              ],
            ),
    );
  }
}

class BacklogTaskScreen extends ConsumerStatefulWidget {
  const BacklogTaskScreen({required this.taskId, super.key});

  final String taskId;

  @override
  ConsumerState<BacklogTaskScreen> createState() => _BacklogTaskScreenState();
}

class _BacklogTaskScreenState extends ConsumerState<BacklogTaskScreen> {
  StudyTask? _task;
  String? _subjectName;
  String? _chapterTitle;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final task = await ref
        .read(studyTaskRepositoryProvider)
        .findById(widget.taskId);
    if (task == null || !mounted) {
      return;
    }
    final subject = await ref
        .read(subjectRepositoryProvider)
        .findById(task.subjectId);
    final chapter = task.chapterId == null
        ? null
        : await ref.read(chapterRepositoryProvider).findById(task.chapterId!);
    if (mounted) {
      setState(() {
        _task = task;
        _subjectName = subject?.name;
        _chapterTitle = chapter?.title;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final task = _task;
    if (task == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final today = ref.watch(clockProvider).today();
    final overdue = today.difference(calendarDate(task.plannedDate)).inDays;
    return Scaffold(
      appBar: AppBar(title: Text(_subjectName ?? task.title)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            LocaleFormat.formatDate(
              task.plannedDate,
              Localizations.localeOf(context),
            ),
          ),
          Text(_chapterTitle ?? task.title),
          Text(LocaleFormat.formatDuration(task.plannedMinutes, l10n)),
          Text('${task.completionPercent}%'),
          Text(l10n.daysOverdue(overdue < 0 ? 0 : overdue)),
          Text(LocaleFormat.formatDuration(remainingTaskMinutes(task), l10n)),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.actionStudyNow,
            onPressed: () => showStartSheet(
              context: context,
              ref: ref,
              task: task,
              subjectName: _subjectName ?? task.title,
              title: _chapterTitle ?? task.title,
              examName: null,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.moveTask(task.id)),
            child: Text(l10n.actionReschedule),
          ),
          OutlinedButton(
            onPressed: () async {
              await showSkipSheet(context: context, ref: ref, task: task);
              if (context.mounted) {
                context.pop();
              }
            },
            child: Text(l10n.actionSkip),
          ),
          OutlinedButton(
            onPressed: () async {
              final now = ref.read(clockProvider).now();
              await ref
                  .read(studyTaskRepositoryProvider)
                  .save(
                    task.copyWith(status: TaskStatus.cancelled, updatedAt: now),
                  );
              await reconcileReminders(ref);
              if (context.mounted) {
                context.pop();
              }
            },
            child: Text(l10n.actionRemove),
          ),
        ],
      ),
    );
  }
}

class CatchUpScreen extends ConsumerStatefulWidget {
  const CatchUpScreen({super.key});

  @override
  ConsumerState<CatchUpScreen> createState() => _CatchUpScreenState();
}

class _CatchUpScreenState extends ConsumerState<CatchUpScreen> {
  CatchUpPlan? _plan;
  List<StudyTask> _backlog = [];
  var _applied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final settings = await ref.read(settingsControllerProvider.future);
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      return;
    }
    final today = ref.read(clockProvider).today();
    final tasks = ref.read(studyTaskRepositoryProvider);
    final backlog = await tasks.listBacklog(planId, today);
    final existing = await tasks.listByPlan(planId);
    final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
    final week = await ref
        .read(availabilityRepositoryProvider)
        .watchWeek(planId)
        .first;
    final exceptions = await ref
        .read(availabilityRepositoryProvider)
        .watchExceptions(planId)
        .first;
    final exams = await ref
        .read(examRepositoryProvider)
        .watchByPlan(planId)
        .first;
    DateTime? examDate;
    for (final exam in exams) {
      final start = calendarDate(exam.startDate);
      if (!start.isBefore(today) &&
          (examDate == null || start.isBefore(examDate))) {
        examDate = start;
      }
    }
    final recovery = buildCatchUpPlan(
      backlogMinutes: backlog.fold<int>(
        0,
        (sum, task) => sum + remainingTaskMinutes(task),
      ),
      spare: spareCapacity(
        today: today,
        week: week,
        exceptions: exceptions,
        planningBufferPercent: plan?.planningBufferPercent ?? 15,
        occupying: existing,
      ),
      examDate: examDate,
    );
    if (mounted) {
      setState(() {
        _plan = recovery;
        _backlog = backlog;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plan = _plan;
    if (plan == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.catchUpTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.recoveryEstimate(plan.recoveryDays),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.extraStudy),
          for (final day in plan.days)
            Text(
              '${LocaleFormat.formatDate(day.date, locale)} +${LocaleFormat.formatDuration(day.minutes, l10n)}',
            ),
          const SizedBox(height: AppSpacing.lg),
          if (_applied)
            Text(l10n.catchUpAdded)
          else
            PrimaryButton(label: l10n.actionApply, onPressed: _apply),
          if (_applied) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.plan),
              child: Text(l10n.actionViewUpdatedPlan),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _apply() async {
    final plan = _plan;
    if (plan == null) {
      return;
    }
    final now = ref.read(clockProvider).now();
    final ids = ref.read(idGeneratorProvider);
    final tasks = <StudyTask>[];
    final ordered = [..._backlog]
      ..sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
    final owed = [for (final task in ordered) remainingTaskMinutes(task)];
    for (final day in plan.days) {
      var room = day.minutes;
      for (var index = 0; index < ordered.length && room > 0; index++) {
        if (owed[index] <= 0) {
          continue;
        }
        final take = owed[index] < room ? owed[index] : room;
        final source = ordered[index];
        tasks.add(
          source.copyWith(
            id: ids.next(),
            plannedDate: day.date,
            plannedMinutes: take,
            actualMinutes: null,
            status: TaskStatus.planned,
            completionPercent: 0,
            source: TaskSource.catchUp,
            isLocked: false,
            generationBatchId: null,
            completedAt: null,
            createdAt: now,
            updatedAt: now,
          ),
        );
        owed[index] -= take;
        room -= take;
      }
    }
    try {
      if (tasks.isNotEmpty) {
        await ref.read(studyTaskRepositoryProvider).saveAll(tasks);
        await reconcileReminders(ref);
      }
      if (mounted) {
        setState(() => _applied = true);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}
