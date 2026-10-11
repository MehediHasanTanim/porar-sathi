import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/app/widgets/selection_card.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/notifications/notification_scheduler.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/onboarding/application/onboarding_controller.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_draft.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';
import 'package:porar_sathi/features/onboarding/presentation/onboarding_scaffold.dart';
import 'package:porar_sathi/features/planner/application/load_planning_input.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/study_planner.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/planner/presentation/plan_preview.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class WeeklyAvailabilityScreen extends ConsumerStatefulWidget {
  const WeeklyAvailabilityScreen({this.onboarding = true, super.key});

  final bool onboarding;

  @override
  ConsumerState<WeeklyAvailabilityScreen> createState() =>
      _WeeklyAvailabilityScreenState();
}

class _WeeklyAvailabilityScreenState extends ConsumerState<WeeklyAvailabilityScreen> {
  List<int>? _minutes;
  var _preset = 120;

  @override
  void initState() {
    super.initState();
    if (!widget.onboarding) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadSavedWeek());
    }
  }

  Future<void> _loadSavedWeek() async {
    final settings = await ref.read(settingsControllerProvider.future);
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      return;
    }
    final week = await ref.read(availabilityRepositoryProvider).watchWeek(planId).first;
    if (week.isEmpty || !mounted) {
      return;
    }
    final minutes = List<int>.filled(OnboardingDraft.weekdays.length, 0);
    for (final day in week) {
      final index = OnboardingDraft.weekdays.indexOf(day.weekday);
      if (index >= 0) {
        minutes[index] = day.isStudyDay ? day.totalAvailableMinutes : 0;
      }
    }
    setState(() => _minutes = minutes);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider).asData?.value;
    _minutes ??= [...?draft?.weekdayMinutes];
    final minutes = _minutes;
    if (minutes == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final studyMinutes = minutes.where((value) => value > 0).toList();
    final average = studyMinutes.isEmpty
        ? 0
        : (studyMinutes.reduce((a, b) => a + b) / studyMinutes.length).round();
    final weekly = minutes.fold<int>(0, (sum, value) => sum + value);
    final body = ListView(
      children: [
        OptionChips(
          labels: [
            l10n.preset1h,
            l10n.preset2h,
            l10n.preset3h,
            l10n.presetCustom,
          ],
          selectedIndex: switch (_preset) {
            60 => 0,
            120 => 1,
            180 => 2,
            _ => 3,
          },
          onSelected: (index) {
            const values = [60, 120, 180, -1];
            final value = values[index];
            if (value < 0) {
              setState(() => _preset = -1);
              return;
            }
            setState(() {
              _preset = value;
              _minutes = [
                for (var day = 0; day < 7; day++) day == 6 ? 0 : value,
              ];
            });
          },
        ),
        const SizedBox(height: AppSpacing.md),
        for (var index = 0; index < OnboardingDraft.weekdays.length; index++)
          _DayRow(
            label: _weekdayLabel(l10n, OnboardingDraft.weekdays[index]),
            minutes: minutes[index],
            onChanged: (value) => setState(() {
              _preset = -1;
              _minutes![index] = value;
            }),
          ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.weeklyStudyTime, style: Theme.of(context).textTheme.titleSmall),
              Text(
                LocaleFormat.formatDuration(weekly, l10n),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(l10n.averagePerStudyDay(LocaleFormat.formatDuration(average, l10n))),
            ],
          ),
        ),
      ],
    );
    if (!widget.onboarding) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.availabilityEdit)),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Expanded(child: body),
              FilledButton(
                onPressed: () => _save(minutes, pop: true),
                child: Text(l10n.actionSave),
              ),
            ],
          ),
        ),
      );
    }
    return OnboardingScaffold(
      step: OnboardingStep.availability,
      title: l10n.availabilityTitle,
      subtitle: l10n.availabilitySubtitle,
      body: body,
      primaryLabel: l10n.actionContinue,
      onPrimary: () => _save(minutes, pop: false),
    );
  }

  Future<void> _save(List<int> minutes, {required bool pop}) async {
    try {
      if (pop) {
        await _saveActiveWeek(minutes);
      } else {
        await ref.read(onboardingControllerProvider.notifier).saveAvailability(minutes);
      }
      if (!mounted) {
        return;
      }
      if (pop) {
        context.pop();
      } else {
        context.go(OnboardingStep.studyTime.route);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }

  Future<void> _saveActiveWeek(List<int> minutes) async {
    if (minutes.length != OnboardingDraft.weekdays.length ||
        minutes.every((value) => value <= 0)) {
      throw const ValidationException(ValidationIssue.availabilityMinutes);
    }
    final settings = await ref.read(settingsControllerProvider.future);
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      throw const DatabaseException(message: 'Study plan was not found.');
    }
    final clock = ref.read(clockProvider);
    final existing = await ref.read(availabilityRepositoryProvider).watchWeek(planId).first;
    final days = [
      for (var index = 0; index < minutes.length; index++)
        WeeklyAvailability(
          id: '$planId-day-${OnboardingDraft.weekdays[index]}',
          studyPlanId: planId,
          weekday: OnboardingDraft.weekdays[index],
          totalAvailableMinutes: minutes[index] < 0 ? 0 : minutes[index],
          isStudyDay: minutes[index] > 0,
          preferredStartTime: _preferredStart(existing, OnboardingDraft.weekdays[index]),
          preferredEndTime: _preferredEnd(existing, OnboardingDraft.weekdays[index]),
          createdAt: clock.now(),
          updatedAt: clock.now(),
        ),
    ];
    await ref.read(availabilityRepositoryProvider).replaceWeek(planId, days);
    final busiest = minutes.fold<int>(0, (best, value) => value > best ? value : best);
    final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
    if (plan != null) {
      await ref.read(studyPlanRepositoryProvider).save(
        plan.copyWith(maxDailyMinutes: busiest, updatedAt: clock.now()),
      );
    }
  }

  int? _preferredStart(List<WeeklyAvailability> week, int weekday) {
    for (final day in week) {
      if (day.weekday == weekday) {
        return day.preferredStartTime;
      }
    }
    return null;
  }

  int? _preferredEnd(List<WeeklyAvailability> week, int weekday) {
    for (final day in week) {
      if (day.weekday == weekday) {
        return day.preferredEndTime;
      }
    }
    return null;
  }

  String _weekdayLabel(AppLocalizations l10n, int weekday) {
    return switch (weekday) {
      DateTime.sunday => l10n.sunday,
      DateTime.monday => l10n.monday,
      DateTime.tuesday => l10n.tuesday,
      DateTime.wednesday => l10n.wednesday,
      DateTime.thursday => l10n.thursday,
      DateTime.friday => l10n.friday,
      _ => l10n.saturday,
    };
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({
    required this.label,
    required this.minutes,
    required this.onChanged,
  });

  final String label;
  final int minutes;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final enabled = minutes > 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label, style: Theme.of(context).textTheme.titleMedium)),
          Text(enabled ? LocaleFormat.formatDuration(minutes, l10n) : l10n.offDay),
          const SizedBox(width: AppSpacing.xs),
          Switch(
            value: enabled,
            onChanged: (value) => onChanged(value ? 120 : 0),
          ),
          IconButton(
            onPressed: !enabled
                ? null
                : () async {
                    final picked = await showModalBottomSheet<int>(
                      context: context,
                      builder: (context) => _MinuteSheet(current: minutes),
                    );
                    if (picked != null) {
                      onChanged(picked);
                    }
                  },
            icon: const Icon(Icons.expand_more),
          ),
        ],
      ),
    );
  }
}

class _MinuteSheet extends StatelessWidget {
  const _MinuteSheet({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const choices = [30, 60, 90, 120, 150, 180, 240];
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          for (final minutes in choices)
            ListTile(
              title: Text(LocaleFormat.formatDuration(minutes, l10n)),
              selected: minutes == current,
              onTap: () => Navigator.pop(context, minutes),
            ),
        ],
      ),
    );
  }
}

class PreferredStudyTimeScreen extends ConsumerStatefulWidget {
  const PreferredStudyTimeScreen({super.key});

  @override
  ConsumerState<PreferredStudyTimeScreen> createState() =>
      _PreferredStudyTimeScreenState();
}

class _PreferredStudyTimeScreenState extends ConsumerState<PreferredStudyTimeScreen> {
  final _selected = <int>{};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final periods = [
      (l10n.periodMorning, l10n.periodMorningTime, 6 * 60, 10 * 60, Icons.wb_sunny_outlined),
      (l10n.periodAfternoon, l10n.periodAfternoonTime, 12 * 60, 16 * 60, Icons.wb_twilight),
      (l10n.periodEvening, l10n.periodEveningTime, 17 * 60, 21 * 60, Icons.nights_stay_outlined),
      (l10n.periodNight, l10n.periodNightTime, 21 * 60, 23 * 60 + 59, Icons.bedtime_outlined),
    ];
    return OnboardingScaffold(
      step: OnboardingStep.studyTime,
      title: l10n.studyTimeTitle,
      subtitle: l10n.studyTimeSubtitle,
      body: ListView(
        children: [
          for (var index = 0; index < periods.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: SelectionCard(
                icon: periods[index].$5,
                title: periods[index].$1,
                subtitle: periods[index].$2,
                selected: _selected.contains(index),
                onTap: () => setState(() {
                  if (!_selected.add(index)) {
                    _selected.remove(index);
                  }
                }),
              ),
            ),
        ],
      ),
      primaryLabel: l10n.actionContinue,
      onPrimary: () => _save(periods),
      secondaryLabel: l10n.actionSkip,
      onSecondary: () => _save(periods, skip: true),
    );
  }

  Future<void> _save(
    List<(String, String, int, int, IconData)> periods, {
    bool skip = false,
  }) async {
    int? start;
    int? end;
    if (!skip && _selected.isNotEmpty) {
      final chosen = _selected.map((index) => periods[index]).toList();
      start = chosen.map((item) => item.$3).reduce((a, b) => a < b ? a : b);
      end = chosen.map((item) => item.$4).reduce((a, b) => a > b ? a : b);
    }
    try {
      await ref.read(onboardingControllerProvider.notifier).saveStudyTime(
        startMinute: start,
        endMinute: end,
      );
      if (mounted) {
        context.go(OnboardingStep.preferences.route);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}

class PlanningPreferencesScreen extends ConsumerStatefulWidget {
  const PlanningPreferencesScreen({super.key});

  @override
  ConsumerState<PlanningPreferencesScreen> createState() =>
      _PlanningPreferencesScreenState();
}

class _PlanningPreferencesScreenState
    extends ConsumerState<PlanningPreferencesScreen> {
  var _mode = PlanningMode.balanced;
  var _intensity = DailyIntensity.normal;
  var _session = 45;
  var _buffer = 15;
  var _revision = 7;
  var _ready = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider).asData?.value;
    if (draft != null && !_ready) {
      _mode = PlanningMode.fromCode(draft.planningMode);
      _intensity = DailyIntensity.fromCode(draft.dailyIntensity);
      _session = draft.maxSessionMinutes;
      _buffer = draft.planningBufferPercent;
      _revision = draft.revisionBufferDays;
      _ready = true;
    }
    final modes = [
      (PlanningMode.balanced, l10n.modeBalanced, l10n.modeBalancedBody, Icons.balance),
      (PlanningMode.weakSubjectFocus, l10n.modeWeak, l10n.modeWeakBody, Icons.psychology_alt_outlined),
      (PlanningMode.light, l10n.modeLight, l10n.modeLightBody, Icons.spa_outlined),
      (PlanningMode.examCrunch, l10n.modeCrunch, l10n.modeCrunchBody, Icons.bolt),
    ];
    return OnboardingScaffold(
      step: OnboardingStep.preferences,
      title: l10n.preferencesTitle,
      body: ListView(
        children: [
          Text(l10n.planningMode, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final mode in modes)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: SelectionCard(
                icon: mode.$4,
                title: mode.$2,
                subtitle: mode.$3,
                selected: _mode == mode.$1,
                onTap: () => setState(() => _mode = mode.$1),
              ),
            ),
          Text(l10n.studyIntensity, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          OptionChips(
            labels: [l10n.intensityLight, l10n.intensityNormal, l10n.intensityFocused],
            selectedIndex: switch (_intensity) {
              DailyIntensity.light => 0,
              DailyIntensity.focused || DailyIntensity.intensive => 2,
              _ => 1,
            },
            onSelected: (index) => setState(() {
              _intensity = [DailyIntensity.light, DailyIntensity.normal, DailyIntensity.focused][index];
            }),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.maxSession, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          OptionChips(
            labels: const ['30', '45', '60', '90'],
            selectedIndex: [30, 45, 60, 90].contains(_session)
                ? [30, 45, 60, 90].indexOf(_session)
                : 1,
            onSelected: (index) => setState(() => _session = [30, 45, 60, 90][index]),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.planningBuffer, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          OptionChips(
            labels: [l10n.bufferPercent(10), l10n.bufferPercent(15), l10n.bufferPercent(20)],
            selectedIndex: [10, 15, 20].contains(_buffer)
                ? [10, 15, 20].indexOf(_buffer)
                : 1,
            onSelected: (index) => setState(() => _buffer = [10, 15, 20][index]),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.revisionBuffer, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          OptionChips(
            labels: [l10n.revisionDays(7), l10n.revisionDays(14), l10n.revisionDays(21)],
            selectedIndex: [7, 14, 21].contains(_revision) ? [7, 14, 21].indexOf(_revision) : 0,
            onSelected: (index) => setState(() => _revision = [7, 14, 21][index]),
          ),
        ],
      ),
      primaryLabel: l10n.actionCreatePlan,
      onPrimary: draft == null
          ? null
          : () async {
              try {
                await ref.read(onboardingControllerProvider.notifier).savePreferences(
                  mode: _mode,
                  intensity: _intensity,
                  maxSessionMinutes: _session,
                  planningBufferPercent: _buffer,
                  revisionBufferDays: _revision,
                );
                if (context.mounted) {
                  context.go(OnboardingStep.summary.route);
                }
              } on Object catch (error) {
                if (context.mounted) {
                  showAppError(context, error);
                }
              }
            },
    );
  }
}

class PlanSummaryScreen extends ConsumerStatefulWidget {
  const PlanSummaryScreen({super.key});

  @override
  ConsumerState<PlanSummaryScreen> createState() => _PlanSummaryScreenState();
}

class _PlanSummaryScreenState extends ConsumerState<PlanSummaryScreen> {
  PlanResult? _result;
  Object? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final draft = await ref.read(onboardingControllerProvider.future);
    final planId = draft.planId;
    if (planId == null) {
      return;
    }
    try {
      final clock = ref.read(clockProvider);
      final input = await loadPlanningInput(
        plans: ref.read(studyPlanRepositoryProvider),
        subjects: ref.read(subjectRepositoryProvider),
        chapters: ref.read(chapterRepositoryProvider),
        exams: ref.read(examRepositoryProvider),
        availability: ref.read(availabilityRepositoryProvider),
        tasks: ref.read(studyTaskRepositoryProvider),
        planId: planId,
        today: clock.today(),
      );
      final result = DeterministicStudyPlanner(clock).generate(
        input,
        runId: ref.read(idGeneratorProvider).next(),
        createdAt: clock.now(),
      );
      if (mounted) {
        setState(() {
          _result = result;
          _error = null;
        });
      }
    } on Object catch (error) {
      if (mounted) {
        setState(() => _error = error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final result = _result;
    if (_error != null) {
      return Scaffold(body: Center(child: Text(l10n.errorGeneric)));
    }
    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final today = ref.read(clockProvider).today();
    return OnboardingScaffold(
      step: OnboardingStep.summary,
      title: l10n.summaryTitle,
      body: ListView(
        children: [
          PlanPreviewContent(result: result, today: today),
        ],
      ),
      primaryLabel: l10n.actionUsePlan,
      onPrimary: () async {
        try {
          await ref.read(studyTaskRepositoryProvider).replaceGeneratedPlan(
            run: result.run,
            tasks: result.tasks,
          );
          await ref.read(onboardingControllerProvider.notifier).goTo(OnboardingStep.notifications);
          if (context.mounted) {
            context.go(OnboardingStep.notifications.route);
          }
        } on Object catch (error) {
          if (context.mounted) {
            showAppError(context, error);
          }
        }
      },
      secondaryLabel: l10n.actionAdjustAvailability,
      onSecondary: () => context.go(OnboardingStep.availability.route),
    );
  }
}

class NotificationEducationScreen extends ConsumerWidget {
  const NotificationEducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return OnboardingScaffold(
      step: OnboardingStep.notifications,
      title: l10n.notificationsTitle,
      subtitle: l10n.notificationsBody,
      body: const SizedBox.shrink(),
      primaryLabel: l10n.actionEnableReminders,
      onPrimary: () async {
        try {
          await LocalNotificationScheduler().requestPermission();
        } on Object {
          // Setup continues even if the system dialog is dismissed.
        }
        await ref.read(onboardingControllerProvider.notifier).goTo(OnboardingStep.complete);
        if (context.mounted) {
          context.go(OnboardingStep.complete.route);
        }
      },
      secondaryLabel: l10n.actionNotNow,
      onSecondary: () async {
        await ref.read(onboardingControllerProvider.notifier).goTo(OnboardingStep.complete);
        if (context.mounted) {
          context.go(OnboardingStep.complete.route);
        }
      },
    );
  }
}

class SetupCompleteScreen extends ConsumerWidget {
  const SetupCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider).asData?.value;
    return OnboardingScaffold(
      step: OnboardingStep.complete,
      title: l10n.completeTitle,
      subtitle: l10n.completeBody,
      body: ListView(
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(draft?.planName ?? l10n.studyPlan, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.completeNoTasks),
                const SizedBox(height: AppSpacing.sm),
                const Icon(Icons.check_circle, color: AppPalette.secondary, size: 36),
              ],
            ),
          ),
        ],
      ),
      primaryLabel: l10n.actionSeeToday,
      onPrimary: () async {
        await ref.read(settingsControllerProvider.notifier).completeOnboarding();
        if (context.mounted) {
          context.go(AppRoutes.today);
        }
      },
    );
  }
}
