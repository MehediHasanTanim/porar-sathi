import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

enum _ExceptionMode { none, reduced, extra }

class CalendarExceptionScreen extends ConsumerStatefulWidget {
  const CalendarExceptionScreen({super.key});

  @override
  ConsumerState<CalendarExceptionScreen> createState() =>
      _CalendarExceptionScreenState();
}

class _CalendarExceptionScreenState extends ConsumerState<CalendarExceptionScreen> {
  final _reason = TextEditingController();
  late DateTime _date;
  var _mode = _ExceptionMode.none;
  var _type = CalendarExceptionType.holiday;
  var _minutes = 60;
  var _started = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!_started) {
      _date = ref.read(clockProvider).today();
      _started = true;
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.exceptionsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.exceptionDate),
            subtitle: Text(DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(_date)),
            onTap: () async {
              final today = ref.read(clockProvider).today();
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: today.subtract(const Duration(days: 1)),
                lastDate: DateTime(today.year + 3),
              );
              if (picked != null) {
                setState(() => _date = picked);
              }
            },
          ),
          Text(l10n.exceptionType),
          OptionChips(
            labels: [l10n.noStudyDay, l10n.reducedAvailability, l10n.extraStudyDay],
            selectedIndex: _mode.index,
            onSelected: (index) => setState(() {
              _mode = _ExceptionMode.values[index];
              _type = switch (_mode) {
                _ExceptionMode.none => CalendarExceptionType.holiday,
                _ExceptionMode.reduced => CalendarExceptionType.coaching,
                _ExceptionMode.extra => CalendarExceptionType.custom,
              };
            }),
          ),
          if (_mode != _ExceptionMode.none) ...[
            const SizedBox(height: AppSpacing.md),
            Text(l10n.exceptionMinutes),
            OptionChips(
              labels: const ['30', '60', '90', '120', '180'],
              selectedIndex: [30, 60, 90, 120, 180].contains(_minutes)
                  ? [30, 60, 90, 120, 180].indexOf(_minutes)
                  : 1,
              onSelected: (index) => setState(() => _minutes = [30, 60, 90, 120, 180][index]),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.exceptionReason,
            child: TextField(controller: _reason),
          ),
          const SizedBox(height: AppSpacing.xl),
          FilledButton(onPressed: _save, child: Text(l10n.saveOverride)),
        ],
      ),
    );
  }

  Future<void> _save() async {
    try {
      final settings = await ref.read(settingsControllerProvider.future);
      final planId = settings.currentStudyPlanId;
      if (planId == null) {
        throw const DatabaseException(message: 'Study plan was not found.');
      }
      final clock = ref.read(clockProvider);
      final exception = CalendarException(
        id: ref.read(idGeneratorProvider).next(),
        studyPlanId: planId,
        date: _date,
        exceptionType: _type,
        availableMinutesOverride: _mode == _ExceptionMode.none ? 0 : _minutes,
        reason: _reason.text,
        isNoStudyDay: _mode == _ExceptionMode.none,
        createdAt: clock.now(),
      );
      await ref.read(availabilityRepositoryProvider).saveException(exception);
      final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
      final week = await ref.read(availabilityRepositoryProvider).watchWeek(planId).first;
      final exceptions = await ref.read(availabilityRepositoryProvider).watchExceptions(planId).first;
      final capacity = capacityForDate(
        date: _date,
        week: week,
        exceptions: exceptions,
        planningBufferPercent: plan?.planningBufferPercent ?? settings.planningBuffer,
      );
      if (!mounted) {
        return;
      }
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.exceptionSaved(LocaleFormat.formatDuration(capacity.schedulableMinutes, l10n)),
          ),
        ),
      );
      context.pop();
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}
