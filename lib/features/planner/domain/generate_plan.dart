import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/planning_days.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/planner/domain/priority_score.dart';
import 'package:porar_sathi/features/planner/domain/remaining_work.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/task_allocator.dart';

const plannerAlgorithmVersion = 'planner_v1';

final class PlanResult {
  const PlanResult({
    required this.run,
    required this.tasks,
    required this.unscheduled,
    required this.forecast,
    required this.scores,
    required this.days,
  });

  final PlannerRun run;
  final List<StudyTask> tasks;
  final List<UnscheduledSlice> unscheduled;
  final PlanForecast forecast;
  final Map<String, ScoreExplanation> scores;
  final List<PlanningDay> days;
}

/// Builds a plan without writing it. Unplaced work stays on [PlanResult.unscheduled].
PlanResult generatePlan(
  PlanningInput raw, {
  required String runId,
  required DateTime createdAt,
  PlannerTrigger trigger = PlannerTrigger.initialPlan,
}) {
  final input = preparePlanningInput(raw);
  final days = buildPlanningDays(input);
  final work = remainingWork(input);
  final recent = _recentMinutes(input);
  final subjectRemaining = <String, int>{};
  var totalRemaining = 0;
  for (final item in work) {
    subjectRemaining[item.subject.id] =
        (subjectRemaining[item.subject.id] ?? 0) + item.remainingMinutes;
    totalRemaining += item.remainingMinutes;
  }
  final scores = <String, ScoreExplanation>{};
  final scored = <ScoredWork>[];
  for (final item in work) {
    final explanation = scoreChapter(
      work: item,
      input: input,
      recentSubjectMinutes: recent.bySubject[item.subject.id] ?? 0,
      recentTotalMinutes: recent.total,
      subjectRemaining: subjectRemaining[item.subject.id] ?? 0,
      totalRemaining: totalRemaining,
    );
    scores[item.chapter.id] = explanation;
    scored.add(ScoredWork(work: item, score: explanation));
  }
  final allocation = allocateTasks(input: input, days: days, scored: scored);
  final tasks = <StudyTask>[];
  final cursors = <DateTime, int>{};
  final scheduledByDate = <DateTime, int>{};
  var scheduled = 0;
  for (final placement in allocation.placements) {
    final date = calendarDate(placement.date);
    final start = cursors[date] ?? _dayStart(days, date);
    cursors[date] = start + placement.minutes;
    scheduled += placement.minutes;
    scheduledByDate[date] = (scheduledByDate[date] ?? 0) + placement.minutes;
    final title = '${placement.work.subject.name}: ${placement.work.chapter.title}';
    tasks.add(
      StudyTask(
        id: '$runId-${placement.order}',
        studyPlanId: input.plan.id,
        subjectId: placement.work.subject.id,
        chapterId: placement.work.chapter.id,
        examId: placement.work.exam?.id,
        taskType: placement.work.chapter.status == ChapterStatus.inProgress
            ? TaskType.continueStudy
            : TaskType.newStudy,
        title: title.length <= 120 ? title : title.substring(0, 120),
        plannedDate: date,
        plannedStartTime: start >= 24 * 60 ? (24 * 60) - 1 : start,
        plannedMinutes: placement.minutes,
        priorityScore: placement.score.total,
        isLocked: false,
        status: TaskStatus.planned,
        completionPercent: 0,
        source: TaskSource.autoPlanner,
        generationBatchId: runId,
        createdAt: createdAt,
        updatedAt: createdAt,
      ),
    );
  }
  final unscheduledMinutes = allocation.unscheduled.fold<int>(
    0,
    (sum, slice) => sum + slice.minutes,
  );
  final forecast = forecastPlan(
    input: input,
    days: days,
    requiredMinutes: totalRemaining,
    scheduledMinutes: scheduled,
    unscheduledMinutes: unscheduledMinutes,
    scheduledByDate: scheduledByDate,
  );
  return PlanResult(
    run: PlannerRun(
      id: runId,
      studyPlanId: input.plan.id,
      trigger: trigger,
      startedAt: createdAt,
      completedAt: createdAt,
      inputTaskCount: work.length,
      outputTaskCount: tasks.length,
      riskLevel: forecast.risk,
      expectedFinishDate: forecast.expectedFinishDate,
      algorithmVersion: plannerAlgorithmVersion,
    ),
    tasks: tasks,
    unscheduled: allocation.unscheduled,
    forecast: forecast,
    scores: scores,
    days: days,
  );
}

int _dayStart(List<PlanningDay> days, DateTime date) {
  for (final day in days) {
    if (day.capacity.date == date && day.preferredStart != null) {
      return day.preferredStart!;
    }
  }
  return 9 * 60;
}

({Map<String, int> bySubject, int total}) _recentMinutes(PlanningInput input) {
  final start = input.today.subtract(const Duration(days: 14));
  final bySubject = <String, int>{};
  var total = 0;
  for (final task in input.existingTasks) {
    final counted = task.status == TaskStatus.completed ||
        task.status == TaskStatus.partiallyCompleted;
    if (!counted || task.plannedDate.isBefore(start)) {
      continue;
    }
    final minutes = task.actualMinutes ?? task.plannedMinutes;
    bySubject[task.subjectId] = (bySubject[task.subjectId] ?? 0) + minutes;
    total += minutes;
  }
  return (bySubject: bySubject, total: total);
}
