import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/planner/application/load_adaptive_plan.dart';
import 'package:porar_sathi/features/planner/domain/adaptive_plan.dart';
import 'package:porar_sathi/features/planner/domain/replan_diff.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class ReplanPreviewScreen extends ConsumerStatefulWidget {
  const ReplanPreviewScreen({super.key});

  @override
  ConsumerState<ReplanPreviewScreen> createState() => _ReplanPreviewScreenState();
}

class _ReplanPreviewScreenState extends ConsumerState<ReplanPreviewScreen> {
  AdaptivePlan? _plan;
  var _applied = false;
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
    final clock = ref.read(clockProvider);
    final ids = ref.read(idGeneratorProvider);
    final plan = await loadAdaptivePlan(
      plans: ref.read(studyPlanRepositoryProvider),
      subjects: ref.read(subjectRepositoryProvider),
      chapters: ref.read(chapterRepositoryProvider),
      exams: ref.read(examRepositoryProvider),
      availability: ref.read(availabilityRepositoryProvider),
      tasks: ref.read(studyTaskRepositoryProvider),
      revisions: ref.read(revisionRepositoryProvider),
      runs: ref.read(plannerRunRepositoryProvider),
      planId: planId,
      today: clock.today(),
      createdAt: clock.now(),
      runId: ids.next(),
      ids: [for (var index = 0; index < 40; index++) ids.next()],
      trigger: PlannerTrigger.userRequest,
    );
    if (mounted) {
      setState(() {
        _plan = plan;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plan = _plan;
    if (_loading || plan == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final diff = plan.diff;
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(_applied ? l10n.planUpdated : l10n.replanTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          if (_applied) ...[
            Text(l10n.planUpdated, style: Theme.of(context).textTheme.headlineSmall),
            if (plan.run.expectedFinishDate != null)
              Text(LocaleFormat.formatDate(plan.run.expectedFinishDate!, locale)),
            Text(l10n.recoveryEstimate(plan.catchUp.recoveryDays)),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: l10n.actionViewToday,
              onPressed: () => context.go(AppRoutes.today),
            ),
          ] else ...[
            Text(l10n.replanMoved(diff.moved.length)),
            Text(l10n.replanAdded(diff.added.length)),
            Text(l10n.replanRemoved(diff.removed.length)),
            if (diff.previousFinish != null && diff.nextFinish != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(l10n.finishChange),
              Text(
                '${LocaleFormat.formatDate(diff.previousFinish!, locale)} → ${LocaleFormat.formatDate(diff.nextFinish!, locale)}',
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.replanTitle, style: Theme.of(context).textTheme.titleMedium),
            for (final change in [...diff.moved, ...diff.added, ...diff.removed])
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(_changeLabel(change, locale)),
              ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(label: l10n.actionApplyChanges, onPressed: _apply),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => context.pop(),
              child: Text(l10n.actionKeepPlan),
            ),
          ],
        ],
      ),
    );
  }

  String _changeLabel(ReplanTaskChange change, Locale locale) {
    final from = change.from == null ? '' : LocaleFormat.formatDate(change.from!, locale);
    final to = change.to == null ? '' : LocaleFormat.formatDate(change.to!, locale);
    if (from.isEmpty) {
      return '${change.title} → $to';
    }
    if (to.isEmpty) {
      return '${change.title} $from';
    }
    return '${change.title} $from → $to';
  }

  Future<void> _apply() async {
    final plan = _plan;
    if (plan == null) {
      return;
    }
    try {
      await ref.read(studyTaskRepositoryProvider).applyAdaptivePlan(
        run: plan.run,
        tasks: plan.tasks,
        today: ref.read(clockProvider).today(),
      );
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
