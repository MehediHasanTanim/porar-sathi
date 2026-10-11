import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/exams/domain/exam_repository.dart';
import 'package:porar_sathi/features/planner/domain/availability_repository.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/planner/domain/day_rollover.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/study_task_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/sessions/domain/study_session_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/subjects/domain/subject_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter_repository.dart';

final class ProgressInputs {
  const ProgressInputs({
    required this.today,
    required this.planStart,
    required this.subjects,
    required this.chapters,
    required this.tasks,
    required this.sessions,
    required this.revisions,
    required this.backlogMinutes,
    required this.capacityBeforeExam,
    required this.daysBeforeExam,
    required this.revisionBufferDays,
    required this.availableDays,
  });

  final DateTime today;
  final DateTime planStart;
  final List<Subject> subjects;
  final List<Chapter> chapters;
  final List<StudyTask> tasks;
  final List<StudySession> sessions;
  final List<RevisionSchedule> revisions;
  final int backlogMinutes;
  final int capacityBeforeExam;
  final int? daysBeforeExam;
  final int revisionBufferDays;
  final Set<DateTime> availableDays;
}

Future<ProgressInputs> loadProgressInputs({
  required StudyPlanRepository plans,
  required SubjectRepository subjects,
  required ChapterRepository chapters,
  required ExamRepository exams,
  required AvailabilityRepository availability,
  required StudyTaskRepository tasks,
  required RevisionRepository revisions,
  required StudySessionRepository sessions,
  required String planId,
  required DateTime today,
}) async {
  final plan = await plans.findById(planId);
  if (plan == null) {
    throw const DatabaseException(message: 'Study plan was not found.');
  }
  final subjectRows = await subjects.watchByPlan(planId, includeArchived: true).first;
  final chapterRows = await chapters.listByPlan(planId);
  final taskRows = await tasks.listByPlan(planId);
  final revisionRows = await revisions.listByPlan(planId);
  final sessionRows = await sessions.listBySubjects([
    for (final subject in subjectRows) subject.id,
  ]);
  final week = await availability.watchWeek(planId).first;
  final exceptions = await availability.watchExceptions(planId).first;
  final examRows = await exams.watchByPlan(planId).first;
  final day = calendarDate(today);
  DateTime? examDate;
  for (final exam in examRows) {
    final start = calendarDate(exam.startDate);
    if (!start.isBefore(day) && (examDate == null || start.isBefore(examDate))) {
      examDate = start;
    }
  }
  final horizon = examDate ?? day.add(const Duration(days: 30));
  var capacity = 0;
  var cursor = day;
  var guard = 0;
  while (cursor.isBefore(horizon) && guard < 366) {
    final slot = capacityForDate(
      date: cursor,
      week: week,
      exceptions: exceptions,
      planningBufferPercent: plan.planningBufferPercent,
    );
    capacity += slot.usableMinutes;
    cursor = cursor.add(const Duration(days: 1));
    guard += 1;
  }
  final available = <DateTime>{};
  final lookback = day.subtract(const Duration(days: 365));
  var probe = calendarDate(plan.startDate).isAfter(lookback)
      ? calendarDate(plan.startDate)
      : lookback;
  if (probe.isAfter(day)) {
    probe = day;
  }
  while (!probe.isAfter(day)) {
    final slot = capacityForDate(
      date: probe,
      week: week,
      exceptions: exceptions,
      planningBufferPercent: plan.planningBufferPercent,
    );
    if (!slot.isNoStudyDay && slot.usableMinutes > 0) {
      available.add(probe);
    }
    probe = probe.add(const Duration(days: 1));
  }
  final backlog = await tasks.listBacklog(planId, day);
  final backlogMinutes = backlog.fold<int>(0, (sum, task) => sum + remainingTaskMinutes(task));
  return ProgressInputs(
    today: day,
    planStart: calendarDate(plan.startDate),
    subjects: subjectRows,
    chapters: chapterRows,
    tasks: taskRows,
    sessions: sessionRows,
    revisions: revisionRows,
    backlogMinutes: backlogMinutes,
    capacityBeforeExam: capacity,
    daysBeforeExam: examDate?.difference(day).inDays,
    revisionBufferDays: plan.revisionBufferDays,
    availableDays: available,
  );
}
