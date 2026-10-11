import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class PlanScreen extends ConsumerStatefulWidget {
  const PlanScreen({super.key});

  @override
  ConsumerState<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends ConsumerState<PlanScreen> {
  List<WeeklyAvailability> _week = [];
  List<CalendarException> _exceptions = [];
  var _buffer = 15;
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
    final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
    final week = await ref.read(availabilityRepositoryProvider).watchWeek(planId).first;
    final exceptions = await ref.read(availabilityRepositoryProvider).watchExceptions(planId).first;
    if (mounted) {
      setState(() {
        _hasPlan = true;
        _week = week;
        _exceptions = exceptions;
        _buffer = plan?.planningBufferPercent ?? settings.planningBuffer;
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
    final capacity = capacityForDate(
      date: today,
      week: _week,
      exceptions: _exceptions,
      planningBufferPercent: _buffer,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.studyPlan)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.todayCapacity, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${l10n.weeklyStudyTime}: ${LocaleFormat.formatDuration(capacity.baseMinutes, l10n)}'),
                Text('${l10n.exceptionMinutes}: ${LocaleFormat.formatDuration(capacity.availableMinutes, l10n)}'),
                Text('${l10n.capacityBuffer}: ${LocaleFormat.formatDuration(capacity.bufferMinutes, l10n)}'),
                Text(
                  '${l10n.schedulableCapacity}: ${LocaleFormat.formatDuration(capacity.schedulableMinutes, l10n)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: () async {
              await context.push(AppRoutes.availability);
              await _load();
            },
            child: Text(l10n.availabilityEdit),
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
