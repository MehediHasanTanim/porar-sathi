import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/catch_up_plan.dart';
import 'package:porar_sathi/features/planner/domain/day_rollover.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/replan_diff.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';

final class AdaptivePlan {
  const AdaptivePlan({
    required this.run,
    required this.tasks,
    required this.catchUp,
    required this.diff,
  });

  final PlannerRun run;
  final List<StudyTask> tasks;
  final CatchUpPlan catchUp;
  final ReplanDiff diff;
}

final class BacklogSubjectLoad {
  const BacklogSubjectLoad({
    required this.subjectId,
    required this.name,
    required this.taskCount,
    required this.minutes,
  });

  final String subjectId;
  final String name;
  final int taskCount;
  final int minutes;
}

final class BacklogSnapshot {
  const BacklogSnapshot({
    required this.overdueCount,
    required this.remainingMinutes,
    required this.subjects,
    required this.oldest,
    required this.recovery,
  });

  final int overdueCount;
  final int remainingMinutes;
  final List<BacklogSubjectLoad> subjects;
  final StudyTask? oldest;
  final CatchUpPlan recovery;
}

BacklogSnapshot buildBacklogSnapshot({
  required List<StudyTask> backlog,
  required Map<String, String> subjectNames,
  required List<DaySpare> spare,
  DateTime? examDate,
}) {
  final ordered = [...backlog]..sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
  var minutes = 0;
  final bySubject = <String, BacklogSubjectLoad>{};
  for (final task in ordered) {
    final left = remainingTaskMinutes(task);
    minutes += left;
    final current = bySubject[task.subjectId];
    bySubject[task.subjectId] = BacklogSubjectLoad(
      subjectId: task.subjectId,
      name: subjectNames[task.subjectId] ?? task.title,
      taskCount: (current?.taskCount ?? 0) + 1,
      minutes: (current?.minutes ?? 0) + left,
    );
  }
  final subjects = bySubject.values.toList()
    ..sort((a, b) {
      final byMinutes = b.minutes.compareTo(a.minutes);
      return byMinutes != 0 ? byMinutes : a.name.compareTo(b.name);
    });
  return BacklogSnapshot(
    overdueCount: ordered.length,
    remainingMinutes: minutes,
    subjects: subjects,
    oldest: ordered.isEmpty ? null : ordered.first,
    recovery: buildCatchUpPlan(
      backlogMinutes: minutes,
      spare: spare,
      examDate: examDate,
    ),
  );
}

/// Replaces future generated work and keeps protected tasks untouched.
AdaptivePlan buildAdaptivePlan({
  required String studyPlanId,
  required String runId,
  required DateTime today,
  required DateTime createdAt,
  required PlannerTrigger trigger,
  required List<StudyTask> existing,
  required List<StudyTask> generated,
  required List<DaySpare> spare,
  required List<RevisionSchedule> revisions,
  required Map<String, String> subjectByChapter,
  required List<StudyTask> backlog,
  required List<String> ids,
  required PlanForecast forecast,
  PlannerRun? previousRun,
  DateTime? examDate,
  String algorithmVersion = 'planner_v1',
}) {
  final day = calendarDate(today);
  final open = <DaySpare>[
    for (final slot in spare)
      DaySpare(date: calendarDate(slot.date), spareMinutes: slot.spareMinutes),
  ];
  final tasks = <StudyTask>[...generated];
  var idIndex = 0;
  final backlogMinutes = backlog.fold<int>(0, (sum, task) => sum + remainingTaskMinutes(task));
  final catchUp = buildCatchUpPlan(
    backlogMinutes: backlogMinutes,
    spare: open,
    examDate: examDate,
  );
  idIndex = _placeCatchUp(
    tasks: tasks,
    backlog: backlog,
    plan: catchUp,
    ids: ids,
    idIndex: idIndex,
    studyPlanId: studyPlanId,
    runId: runId,
    createdAt: createdAt,
    open: open,
  );
  _placeRevisions(
    tasks: tasks,
    revisions: revisions,
    existing: existing,
    subjectByChapter: subjectByChapter,
    today: day,
    ids: ids,
    idIndex: idIndex,
    studyPlanId: studyPlanId,
    runId: runId,
    createdAt: createdAt,
    examDate: examDate == null ? null : calendarDate(examDate),
    open: open,
  );
  final risk = _worse(forecast.risk, catchUp.risk);
  final diff = diffReplan(
    today: day,
    existing: existing,
    proposed: tasks,
    previousFinish: previousRun?.expectedFinishDate,
    nextFinish: forecast.expectedFinishDate,
    previousRisk: previousRun?.riskLevel,
    nextRisk: risk,
  );
  return AdaptivePlan(
    run: PlannerRun(
      id: runId,
      studyPlanId: studyPlanId,
      trigger: trigger,
      startedAt: createdAt,
      completedAt: createdAt,
      inputTaskCount: existing.length,
      outputTaskCount: tasks.length,
      riskLevel: risk,
      expectedFinishDate: forecast.expectedFinishDate,
      algorithmVersion: algorithmVersion,
    ),
    tasks: tasks,
    catchUp: catchUp,
    diff: diff,
  );
}

int _placeCatchUp({
  required List<StudyTask> tasks,
  required List<StudyTask> backlog,
  required CatchUpPlan plan,
  required List<String> ids,
  required int idIndex,
  required String studyPlanId,
  required String runId,
  required DateTime createdAt,
  required List<DaySpare> open,
}) {
  final pending = [...backlog]..sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
  final owed = [for (final task in pending) remainingTaskMinutes(task)];
  var cursor = idIndex;
  for (final day in plan.days) {
    var room = day.minutes;
    for (var index = 0; index < pending.length && room > 0; index++) {
      if (owed[index] <= 0 || cursor >= ids.length) {
        continue;
      }
      final take = owed[index] < room ? owed[index] : room;
      if (take <= 0) {
        continue;
      }
      final source = pending[index];
      tasks.add(
        source.copyWith(
          id: ids[cursor],
          plannedDate: day.date,
          plannedMinutes: take,
          actualMinutes: null,
          status: TaskStatus.planned,
          completionPercent: 0,
          source: TaskSource.catchUp,
          isLocked: false,
          generationBatchId: runId,
          completedAt: null,
          createdAt: createdAt,
          updatedAt: createdAt,
        ),
      );
      owed[index] -= take;
      room -= take;
      cursor += 1;
      _consume(open, day.date, take);
    }
  }
  return cursor;
}

void _placeRevisions({
  required List<StudyTask> tasks,
  required List<RevisionSchedule> revisions,
  required List<StudyTask> existing,
  required Map<String, String> subjectByChapter,
  required DateTime today,
  required List<String> ids,
  required int idIndex,
  required String studyPlanId,
  required String runId,
  required DateTime createdAt,
  required DateTime? examDate,
  required List<DaySpare> open,
}) {
  var cursor = idIndex;
  final ordered = [...revisions]
    ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  for (final revision in ordered) {
    if (cursor >= ids.length) {
      return;
    }
    final openStatus =
        revision.status == RevisionStatus.pending ||
        revision.status == RevisionStatus.scheduled ||
        revision.status == RevisionStatus.overdue;
    if (!openStatus || _revisionAlreadyProtected(existing, revision, today)) {
      continue;
    }
    final date = _revisionDate(revision, open, today, examDate);
    if (date == null) {
      continue;
    }
    final subjectId =
        subjectByChapter[revision.chapterId] ??
        _subjectForChapter(existing, tasks, revision.chapterId);
    if (subjectId == null) {
      continue;
    }
    tasks.add(
      StudyTask(
        id: ids[cursor],
        studyPlanId: studyPlanId,
        subjectId: subjectId,
        chapterId: revision.chapterId,
        taskType: TaskType.revision,
        title: 'Revision ${revision.revisionNumber}',
        plannedDate: date,
        plannedMinutes: revision.estimatedMinutes,
        priorityScore: 0,
        isLocked: false,
        status: TaskStatus.planned,
        completionPercent: 0,
        source: TaskSource.revisionEngine,
        generationBatchId: runId,
        createdAt: createdAt,
        updatedAt: createdAt,
      ),
    );
    _consume(open, date, revision.estimatedMinutes);
    cursor += 1;
  }
}

bool _revisionAlreadyProtected(
  List<StudyTask> existing,
  RevisionSchedule revision,
  DateTime today,
) {
  for (final task in existing) {
    if (!taskIsPreserved(task, today)) {
      continue;
    }
    if (task.chapterId == revision.chapterId &&
        task.taskType == TaskType.revision &&
        task.status == TaskStatus.planned) {
      return true;
    }
  }
  return false;
}

DateTime? _revisionDate(
  RevisionSchedule revision,
  List<DaySpare> open,
  DateTime today,
  DateTime? examDate,
) {
  final preferred = calendarDate(revision.dueDate).isBefore(today)
      ? today
      : calendarDate(revision.dueDate);
  if (examDate != null && !preferred.isBefore(examDate)) {
    return null;
  }
  for (final slot in open) {
    if (slot.date.isBefore(preferred) || slot.spareMinutes < revision.estimatedMinutes) {
      continue;
    }
    if (examDate != null && !slot.date.isBefore(examDate)) {
      continue;
    }
    return slot.date;
  }
  return null;
}

String? _subjectForChapter(
  List<StudyTask> existing,
  List<StudyTask> tasks,
  String chapterId,
) {
  for (final task in [...existing, ...tasks]) {
    if (task.chapterId == chapterId) {
      return task.subjectId;
    }
  }
  return null;
}

void _consume(List<DaySpare> open, DateTime date, int minutes) {
  for (var index = 0; index < open.length; index++) {
    final slot = open[index];
    if (slot.date == calendarDate(date)) {
      final left = slot.spareMinutes - minutes;
      open[index] = DaySpare(date: slot.date, spareMinutes: left < 0 ? 0 : left);
    }
  }
}

PlannerRiskLevel _worse(PlannerRiskLevel left, PlannerRiskLevel right) {
  return left.index >= right.index ? left : right;
}
