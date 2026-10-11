import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_repository.dart';
import 'package:porar_sathi/features/planner/domain/planner_run_repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_repository.dart';
import 'package:porar_sathi/features/sessions/domain/today_dashboard.dart';
import 'package:porar_sathi/features/subjects/domain/subject_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter_repository.dart';

Future<TodayDashboard> loadTodayDashboard({
  required String planId,
  required DateTime today,
  required StudyTaskRepository tasks,
  required SubjectRepository subjects,
  required ChapterRepository chapters,
  required ExamRepository exams,
  required RevisionRepository revisions,
  required PlannerRunRepository runs,
}) async {
  final day = calendarDate(today);
  final todayTasks = await tasks.watchByPlanOnDate(planId, day).first;
  final subjectRows = await subjects.watchByPlan(planId, includeArchived: true).first;
  final chapterRows = await chapters.listByPlan(planId);
  final examRows = await exams.watchByPlan(planId).first;
  final backlog = await tasks.listBacklog(planId, day);
  final due = await revisions.listDue(planId, day);
  final history = await runs.watchByPlan(planId).first;
  final subjectById = {for (final subject in subjectRows) subject.id: subject};
  final chapterById = {for (final chapter in chapterRows) chapter.id: chapter};
  final items = [
    for (final task in todayTasks)
      TodayTaskItem(
        task: task,
        subject: subjectById[task.subjectId],
        chapter: task.chapterId == null ? null : chapterById[task.chapterId],
      ),
  ];
  final planned = items.fold<int>(0, (sum, item) => sum + item.task.plannedMinutes);
  final done = items.where((item) => taskIsDone(item.task)).length;
  return TodayDashboard(
    tasks: items,
    plannedMinutes: planned,
    doneCount: done,
    syllabusPercent: syllabusCompletionPercent(chapterRows),
    backlogMinutes: backlogMinutes(backlog),
    backlogCount: backlog.length,
    revisionDueCount: revisionDueCount(due),
    pace: paceFromRun(history.isEmpty ? null : history.first),
    nextExam: _nextExam(examRows, day),
    daysUntilExam: _daysUntil(_nextExam(examRows, day), day),
  );
}

Exam? _nextExam(List<Exam> exams, DateTime today) {
  Exam? nearest;
  for (final exam in exams) {
    if (calendarDate(exam.startDate).isBefore(today)) {
      continue;
    }
    if (nearest == null || exam.startDate.isBefore(nearest.startDate)) {
      nearest = exam;
    }
  }
  return nearest;
}

int? _daysUntil(Exam? exam, DateTime today) {
  if (exam == null) {
    return null;
  }
  return calendarDate(exam.startDate).difference(today).inDays;
}
