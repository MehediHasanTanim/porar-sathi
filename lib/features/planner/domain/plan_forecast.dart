import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/planning_days.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';

enum StudyPace { ahead, onTrack, slightlyBehind, behind, atRisk }

enum PlanningSuggestion {
  increaseAvailability,
  increaseIntensity,
  reduceRevisionBuffer,
  prioritizeChapters,
  changeEstimates,
  changeExamDate,
}

final class PlanForecast {
  const PlanForecast({
    required this.expectedFinishDate,
    required this.examDate,
    required this.daysBeforeExam,
    required this.revisionBufferDays,
    required this.pace,
    required this.risk,
    required this.requiredMinutes,
    required this.availableMinutes,
    required this.shortfallMinutes,
    required this.unscheduledMinutes,
    required this.averageDailyMinutes,
    required this.suggestions,
  });

  final DateTime? expectedFinishDate;
  final DateTime? examDate;
  final int? daysBeforeExam;
  final int revisionBufferDays;
  final StudyPace pace;
  final PlannerRiskLevel risk;
  final int requiredMinutes;
  final int availableMinutes;
  final int shortfallMinutes;
  final int unscheduledMinutes;
  final int averageDailyMinutes;
  final List<PlanningSuggestion> suggestions;
}

PlanForecast forecastPlan({
  required PlanningInput input,
  required List<PlanningDay> days,
  required int requiredMinutes,
  required int scheduledMinutes,
  required int unscheduledMinutes,
  required Map<DateTime, int> scheduledByDate,
}) {
  final available = days.fold<int>(0, (sum, day) => sum + day.usableMinutes);
  final capacityGap = requiredMinutes - available;
  final shortfall = _max(capacityGap, unscheduledMinutes);
  final exam = _nextExam(input);
  final finish = _finishDate(
    today: input.today,
    days: days,
    requiredMinutes: requiredMinutes,
  );
  final pace = _pace(
    finish: requiredMinutes == 0 ? input.today : finish,
    exam: exam,
    revisionBufferDays: input.plan.revisionBufferDays,
    unscheduledMinutes: unscheduledMinutes,
  );
  final risk = _risk(
    requiredMinutes: requiredMinutes,
    availableMinutes: available,
    unscheduledMinutes: unscheduledMinutes,
    minSession: input.config.minSessionMinutes,
  );
  final average = _average(scheduledByDate, scheduledMinutes, days);
  return PlanForecast(
    expectedFinishDate: requiredMinutes == 0 ? input.today : finish,
    examDate: exam,
    daysBeforeExam: exam?.difference(input.today).inDays,
    revisionBufferDays: input.plan.revisionBufferDays,
    pace: pace,
    risk: risk,
    requiredMinutes: requiredMinutes,
    availableMinutes: available,
    shortfallMinutes: shortfall < 0 ? 0 : shortfall,
    unscheduledMinutes: unscheduledMinutes < 0 ? 0 : unscheduledMinutes,
    averageDailyMinutes: average,
    suggestions: shortfall > 0 || unscheduledMinutes > 0
        ? PlanningSuggestion.values
        : const [],
  );
}

DateTime? _nextExam(PlanningInput input) {
  DateTime? earliest;
  for (final exam in input.exams) {
    final date = calendarDate(exam.startDate);
    if (date.isBefore(input.today)) {
      continue;
    }
    if (earliest == null || date.isBefore(earliest)) {
      earliest = date;
    }
  }
  return earliest;
}

DateTime? _finishDate({
  required DateTime today,
  required List<PlanningDay> days,
  required int requiredMinutes,
}) {
  if (requiredMinutes <= 0) {
    return today;
  }
  var left = requiredMinutes;
  DateTime? last;
  for (final day in days) {
    if (day.usableMinutes <= 0) {
      continue;
    }
    last = day.capacity.date;
    left -= day.usableMinutes;
    if (left <= 0) {
      return day.capacity.date;
    }
  }
  return last == null || left > 0 ? null : last;
}

StudyPace _pace({
  required DateTime? finish,
  required DateTime? exam,
  required int revisionBufferDays,
  required int unscheduledMinutes,
}) {
  if (exam == null) {
    return unscheduledMinutes > 0 ? StudyPace.atRisk : StudyPace.onTrack;
  }
  if (finish == null || unscheduledMinutes > 0 && !finish.isBefore(exam)) {
    return StudyPace.atRisk;
  }
  final slack = exam.difference(finish).inDays;
  if (slack < 0) {
    return StudyPace.atRisk;
  }
  final buffer = revisionBufferDays < 0 ? 0 : revisionBufferDays;
  if (slack > buffer + 7) {
    return StudyPace.ahead;
  }
  if (slack >= buffer) {
    return StudyPace.onTrack;
  }
  final halfway = (buffer / 2).ceil();
  if (slack >= halfway) {
    return StudyPace.slightlyBehind;
  }
  if (slack >= 1) {
    return StudyPace.behind;
  }
  return StudyPace.atRisk;
}

PlannerRiskLevel _risk({
  required int requiredMinutes,
  required int availableMinutes,
  required int unscheduledMinutes,
  required int minSession,
}) {
  if (requiredMinutes <= 0) {
    return PlannerRiskLevel.none;
  }
  if (availableMinutes <= 0) {
    return PlannerRiskLevel.impossible;
  }
  final pressure = requiredMinutes / availableMinutes;
  if (unscheduledMinutes > 0 && (pressure > 1.2 || availableMinutes < requiredMinutes)) {
    return pressure > 1.2 ? PlannerRiskLevel.impossible : PlannerRiskLevel.high;
  }
  if (unscheduledMinutes >= minSession) {
    return PlannerRiskLevel.high;
  }
  if (unscheduledMinutes > 0 || pressure > 0.8) {
    return PlannerRiskLevel.medium;
  }
  if (pressure > 0.5) {
    return PlannerRiskLevel.low;
  }
  return PlannerRiskLevel.none;
}

int _average(
  Map<DateTime, int> scheduledByDate,
  int scheduledMinutes,
  List<PlanningDay> days,
) {
  if (scheduledByDate.isNotEmpty) {
    return (scheduledMinutes / scheduledByDate.length).round();
  }
  final studyDays = days.where((day) => day.usableMinutes > 0).toList();
  if (studyDays.isEmpty) {
    return 0;
  }
  final total = studyDays.fold<int>(0, (sum, day) => sum + day.usableMinutes);
  return (total / studyDays.length).round();
}

int _max(int a, int b) => a > b ? a : b;
