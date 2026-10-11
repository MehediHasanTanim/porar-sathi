import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/exams/domain/exam_repository.dart';
import 'package:porar_sathi/features/planner/application/load_planning_input.dart';
import 'package:porar_sathi/features/planner/domain/adaptive_plan.dart';
import 'package:porar_sathi/features/planner/domain/availability_repository.dart';
import 'package:porar_sathi/features/planner/domain/catch_up_plan.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/planner_run_repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter_repository.dart';

Future<AdaptivePlan> loadAdaptivePlan({
  required StudyPlanRepository plans,
  required SubjectRepository subjects,
  required ChapterRepository chapters,
  required ExamRepository exams,
  required AvailabilityRepository availability,
  required StudyTaskRepository tasks,
  required RevisionRepository revisions,
  required PlannerRunRepository runs,
  required String planId,
  required DateTime today,
  required DateTime createdAt,
  required String runId,
  required List<String> ids,
  PlannerTrigger trigger = PlannerTrigger.userRequest,
}) async {
  final input = await loadPlanningInput(
    plans: plans,
    subjects: subjects,
    chapters: chapters,
    exams: exams,
    availability: availability,
    tasks: tasks,
    planId: planId,
    today: today,
  );
  final generated = generatePlan(
    input,
    runId: runId,
    createdAt: createdAt,
    trigger: trigger,
  );
  final scheduled = <DateTime, int>{};
  for (final task in generated.tasks) {
    final date = calendarDate(task.plannedDate);
    scheduled[date] = (scheduled[date] ?? 0) + task.plannedMinutes;
  }
  final spare = [
    for (final day in generated.days)
      DaySpare(
        date: day.capacity.date,
        spareMinutes: _left(day.usableMinutes, scheduled[day.capacity.date] ?? 0),
      ),
  ];
  final history = await runs.watchByPlan(planId).first;
  final revisionRows = await revisions.listByPlan(planId);
  final backlog = await tasks.listBacklog(planId, today);
  DateTime? examDate;
  for (final exam in input.exams) {
    final start = calendarDate(exam.startDate);
    if (start.isBefore(today)) {
      continue;
    }
    if (examDate == null || start.isBefore(examDate)) {
      examDate = start;
    }
  }
  return buildAdaptivePlan(
    studyPlanId: planId,
    runId: runId,
    today: today,
    createdAt: createdAt,
    trigger: trigger,
    existing: input.existingTasks,
    generated: generated.tasks,
    spare: spare,
    revisions: revisionRows,
    subjectByChapter: {for (final chapter in input.chapters) chapter.id: chapter.subjectId},
    backlog: backlog,
    ids: ids,
    forecast: generated.forecast,
    previousRun: history.isEmpty ? null : history.first,
    examDate: examDate,
    algorithmVersion: plannerAlgorithmVersion,
  );
}

int _left(int usable, int used) {
  final left = usable - used;
  return left < 0 ? 0 : left;
}
