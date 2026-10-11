import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/planner/application/load_planning_input.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/study_planner.dart';
import 'package:porar_sathi/features/planner/presentation/plan_preview.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class PlanScreen extends ConsumerStatefulWidget {
  const PlanScreen({super.key});

  @override
  ConsumerState<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends ConsumerState<PlanScreen> {
  List<CalendarException> _exceptions = [];
  PlanResult? _result;
  var _loading = true;
  var _hasPlan = false;

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
      trigger: PlannerTrigger.userRequest,
    );
    final exceptions = await ref.read(availabilityRepositoryProvider).watchExceptions(planId).first;
    if (mounted) {
      setState(() {
        _hasPlan = true;
        _result = result;
        _exceptions = exceptions;
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
    if (!_hasPlan) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.studyPlan)),
        body: EmptyState(
          icon: Icons.calendar_month_outlined,
          title: l10n.studyPlan,
          body: l10n.planEmptyBody,
        ),
      );
    }
    final today = ref.watch(clockProvider).today();
    final result = _result;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.studyPlan)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          if (result != null) PlanPreviewContent(result: result, today: today),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: result == null
                ? null
                : () async {
                    try {
                      await ref.read(studyTaskRepositoryProvider).replaceGeneratedPlan(
                        run: result.run,
                        tasks: result.tasks,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.tasksGenerated(result.tasks.length))),
                        );
                      }
                    } on Object catch (error) {
                      if (context.mounted) {
                        showAppError(context, error);
                      }
                    }
                  },
            child: Text(l10n.actionUsePlan),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.replan),
            child: Text(l10n.actionUpdatePlan),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: () async {
              await context.push(AppRoutes.availability);
              await _load();
            },
            child: Text(l10n.actionAdjustAvailability),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: () async {
              await context.push(AppRoutes.newException);
              await _load();
            },
            child: Text(l10n.addException),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.exceptionsTitle, style: Theme.of(context).textTheme.titleMedium),
          if (_exceptions.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(l10n.noExceptions),
            ),
          for (final exception in _exceptions)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(exception.reason ?? exception.exceptionType.code),
              subtitle: Text(
                exception.isNoStudyDay
                    ? l10n.noStudyDay
                    : LocaleFormat.formatDuration(exception.availableMinutesOverride ?? 0, l10n),
              ),
              trailing: IconButton(
                tooltip: l10n.actionDelete,
                onPressed: () async {
                  await ref.read(availabilityRepositoryProvider).deleteException(exception.id);
                  await _load();
                },
                icon: const Icon(Icons.delete_outline),
              ),
            ),
        ],
      ),
    );
  }
}
