import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/app_states.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class PlanPreviewContent extends StatelessWidget {
  const PlanPreviewContent({
    required this.result,
    required this.today,
    super.key,
  });

  final PlanResult result;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final forecast = result.forecast;
    final locale = Localizations.localeOf(context).toString();
    final colors = context.semanticColors;
    final paceColor = switch (forecast.pace) {
      StudyPace.ahead || StudyPace.onTrack => colors.success,
      StudyPace.slightlyBehind => colors.warning,
      StudyPace.behind || StudyPace.atRisk => colors.danger,
    };
    final bySubject = <String, int>{};
    for (final task in result.tasks) {
      final name = task.title.split(':').first;
      bySubject[name] = (bySubject[name] ?? 0) + task.plannedMinutes;
    }
    final names = bySubject.keys.toList()..sort();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.averageDailyStudy, style: Theme.of(context).textTheme.titleSmall),
              Text(LocaleFormat.formatDuration(forecast.averageDailyMinutes, l10n)),
              const SizedBox(height: AppSpacing.sm),
              Text(l10n.summaryFinish, style: Theme.of(context).textTheme.titleSmall),
              Text(
                forecast.expectedFinishDate == null
                    ? l10n.summaryFinishPending
                    : DateFormat.yMMMd(locale).format(forecast.expectedFinishDate!),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${l10n.summaryExam}: ${forecast.examDate == null ? l10n.summaryNoExam : DateFormat.yMMMd(locale).format(forecast.examDate!)}',
              ),
              Text('${l10n.summaryRevisionBuffer}: ${l10n.revisionDays(forecast.revisionBufferDays)}'),
              Text(
                _paceLabel(l10n, forecast.pace),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: paceColor),
              ),
              Text('${l10n.riskLabel}: ${_riskLabel(l10n, forecast.risk)}'),
              Text(l10n.tasksGenerated(result.tasks.length)),
            ],
          ),
        ),
        if (forecast.shortfallMinutes > 0) ...[
          const SizedBox(height: AppSpacing.md),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImpossibleScheduleNotice(
                  title: l10n.riskImpossible,
                  summary: l10n.planShortfall(
                    LocaleFormat.formatDuration(forecast.requiredMinutes, l10n),
                    LocaleFormat.formatDuration(forecast.availableMinutes, l10n),
                    LocaleFormat.formatDuration(forecast.shortfallMinutes, l10n),
                  ),
                  suggestions: [
                    for (final suggestion in forecast.suggestions)
                      _suggestionLabel(l10n, suggestion),
                  ],
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        Text(l10n.firstDays, style: Theme.of(context).textTheme.titleMedium),
        for (var offset = 0; offset < 3; offset++)
          _DayPreview(
            date: calendarDate(today.add(Duration(days: offset))),
            tasks: [
              for (final task in result.tasks)
                if (calendarDate(task.plannedDate) ==
                    calendarDate(today.add(Duration(days: offset))))
                  task,
            ],
            noStudy: _isNoStudy(result, calendarDate(today.add(Duration(days: offset)))),
          ),
        if (names.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(l10n.subjectAllocation, style: Theme.of(context).textTheme.titleMedium),
          for (final name in names)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(name),
              trailing: Text(LocaleFormat.formatDuration(bySubject[name] ?? 0, l10n)),
            ),
        ],
      ],
    );
  }
}

bool _isNoStudy(PlanResult result, DateTime date) {
  for (final day in result.days) {
    if (day.capacity.date == date) {
      return day.capacity.isNoStudyDay;
    }
  }
  return false;
}

class _DayPreview extends StatelessWidget {
  const _DayPreview({
    required this.date,
    required this.tasks,
    required this.noStudy,
  });

  final DateTime date;
  final List<StudyTask> tasks;
  final bool noStudy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        Text(DateFormat.MMMd(locale).format(date), style: Theme.of(context).textTheme.titleSmall),
        if (tasks.isEmpty)
          Text(noStudy ? l10n.offDay : l10n.summaryNoTasks)
        else
          for (final task in tasks)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(task.title),
              trailing: Text(LocaleFormat.formatDuration(task.plannedMinutes, l10n)),
            ),
      ],
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

String _riskLabel(AppLocalizations l10n, PlannerRiskLevel risk) {
  return switch (risk) {
    PlannerRiskLevel.none => l10n.riskNone,
    PlannerRiskLevel.low => l10n.riskLow,
    PlannerRiskLevel.medium => l10n.riskMedium,
    PlannerRiskLevel.high => l10n.riskHigh,
    PlannerRiskLevel.impossible => l10n.riskImpossible,
  };
}

String _suggestionLabel(AppLocalizations l10n, PlanningSuggestion suggestion) {
  return switch (suggestion) {
    PlanningSuggestion.increaseAvailability => l10n.suggestionIncreaseAvailability,
    PlanningSuggestion.increaseIntensity => l10n.suggestionIncreaseIntensity,
    PlanningSuggestion.reduceRevisionBuffer => l10n.suggestionReduceBuffer,
    PlanningSuggestion.prioritizeChapters => l10n.suggestionPrioritize,
    PlanningSuggestion.changeEstimates => l10n.suggestionEstimates,
    PlanningSuggestion.changeExamDate => l10n.suggestionExamDate,
  };
}
