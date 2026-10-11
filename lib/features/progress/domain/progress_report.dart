import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/progress/domain/progress_calculator.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

final class SubjectProgressView {
  const SubjectProgressView({
    required this.subjectId,
    required this.name,
    required this.percent,
    required this.chaptersCompleted,
    required this.chapterCount,
    required this.confidencePercent,
    required this.studyMinutes,
    required this.pendingTasks,
    required this.revisionDue,
  });

  final String subjectId;
  final String name;
  final int percent;
  final int chaptersCompleted;
  final int chapterCount;
  final int confidencePercent;
  final int studyMinutes;
  final int pendingTasks;
  final int revisionDue;
}

final class ProgressView {
  const ProgressView({
    required this.syllabusPercent,
    required this.studyMinutes,
    required this.tasksCompleted,
    required this.tasksTotal,
    required this.revisionsCompleted,
    required this.consistency,
    required this.shares,
    required this.neglectedSubjectId,
    required this.backlogMinutes,
    required this.readiness,
    required this.pace,
    required this.subjects,
    required this.daily,
    required this.weekly,
  });

  final int syllabusPercent;
  final int studyMinutes;
  final int tasksCompleted;
  final int tasksTotal;
  final int revisionsCompleted;
  final ConsistencyWindow consistency;
  final List<SubjectShare> shares;
  final String? neglectedSubjectId;
  final int backlogMinutes;
  final ReadinessScore readiness;
  final OnTrackReport pace;
  final List<SubjectProgressView> subjects;
  final DailySummary daily;
  final WeeklySummary weekly;
}

ProgressView buildProgressView({
  required DateTime today,
  required DateTime planStart,
  required ProgressRange range,
  required List<Subject> subjects,
  required List<Chapter> chapters,
  required List<StudyTask> tasks,
  required List<StudySession> sessions,
  required List<RevisionSchedule> revisions,
  required int backlogMinutes,
  required int capacityBeforeExam,
  int? daysBeforeExam,
  int revisionBufferDays = 7,
  required bool Function(DateTime date) isAvailable,
}) {
  final activeSubjects = [
    for (final subject in subjects)
      if (subject.status == SubjectStatus.active) subject,
  ];
  final names = {for (final subject in activeSubjects) subject.id: subject.name};
  final syllabus = overallProgressPercent(chapters);
  final studied = _studiedDates(sessions);
  final consistency = consistencyWindow(
    today: today,
    dayCount: rangeDayCount(range, today, planStart),
    isAvailable: isAvailable,
    wasStudied: studied.contains,
  );
  final confidence = confidencePercent(chapters);
  final revisionPercent = revisionCompletionPercent(revisions);
  final estimated = _estimated(chapters);
  final readiness = preparationReadiness(
    syllabusPercent: syllabus,
    confidencePercent: confidence,
    revisionPercent: revisionPercent,
    backlogHealthPercent: backlogHealthPercent(
      backlogMinutes: backlogMinutes,
      estimatedMinutes: estimated,
    ),
    consistencyPercent: consistency.percent,
  );
  final minutesBySubject = <String, int>{
    for (final subject in activeSubjects) subject.id: 0,
  };
  var studyMinutes = 0;
  for (final session in sessions) {
    if (!inProgressRange(
      date: session.startedAt,
      today: today,
      range: range,
      planStart: planStart,
    )) {
      continue;
    }
    final minutes = session.actualMinutes < 0 ? 0 : session.actualMinutes;
    studyMinutes += minutes;
    if (names.containsKey(session.subjectId)) {
      minutesBySubject[session.subjectId] = (minutesBySubject[session.subjectId] ?? 0) + minutes;
    }
  }
  var tasksCompleted = 0;
  var tasksTotal = 0;
  for (final task in tasks) {
    if (task.status == TaskStatus.cancelled) {
      continue;
    }
    if (!inProgressRange(
      date: task.plannedDate,
      today: today,
      range: range,
      planStart: planStart,
    )) {
      continue;
    }
    tasksTotal += 1;
    if (task.status == TaskStatus.completed) {
      tasksCompleted += 1;
    }
  }
  var revisionsCompleted = 0;
  for (final revision in revisions) {
    final completedAt = revision.completedAt;
    if (revision.status != RevisionStatus.completed || completedAt == null) {
      continue;
    }
    if (inProgressRange(date: completedAt, today: today, range: range, planStart: planStart)) {
      revisionsCompleted += 1;
    }
  }
  final remainingBySubject = <String, int>{};
  for (final subject in activeSubjects) {
    remainingBySubject[subject.id] = _remaining(
      chapters.where((chapter) => chapter.subjectId == subject.id).toList(),
    );
  }
  final weekly = summarizeWeek(
    today: today,
    tasks: tasks,
    sessions: sessions,
    chapters: chapters,
    revisions: revisions,
    remainingBySubject: remainingBySubject,
  );
  return ProgressView(
    syllabusPercent: syllabus,
    studyMinutes: studyMinutes,
    tasksCompleted: tasksCompleted,
    tasksTotal: tasksTotal,
    revisionsCompleted: revisionsCompleted,
    consistency: consistency,
    shares: subjectShares(minutesBySubject: minutesBySubject),
    neglectedSubjectId: weekly.neglectedSubjectId,
    backlogMinutes: backlogMinutes,
    readiness: readiness,
    pace: classifyOnTrack(
      remainingMinutes: _remaining(chapters),
      capacityMinutes: capacityBeforeExam,
      daysBeforeExam: daysBeforeExam,
      revisionBufferDays: revisionBufferDays,
    ),
    subjects: [
      for (final subject in activeSubjects)
        _subjectView(
          subject: subject,
          chapters: chapters,
          tasks: tasks,
          sessions: sessions,
          revisions: revisions,
        ),
    ],
    daily: summarizeDay(day: today, tasks: tasks, sessions: sessions),
    weekly: weekly,
  );
}

SubjectProgressView _subjectView({
  required Subject subject,
  required List<Chapter> chapters,
  required List<StudyTask> tasks,
  required List<StudySession> sessions,
  required List<RevisionSchedule> revisions,
}) {
  final own = [for (final chapter in chapters) if (chapter.subjectId == subject.id) chapter];
  final chapterIds = {for (final chapter in own) chapter.id};
  var completed = 0;
  for (final chapter in own) {
    if (chapter.status == ChapterStatus.completed || chapter.status == ChapterStatus.revised) {
      completed += 1;
    }
  }
  var study = 0;
  for (final session in sessions) {
    if (session.subjectId == subject.id) {
      study += session.actualMinutes < 0 ? 0 : session.actualMinutes;
    }
  }
  var pending = 0;
  for (final task in tasks) {
    if (task.subjectId != subject.id) {
      continue;
    }
    if (task.status == TaskStatus.planned ||
        task.status == TaskStatus.inProgress ||
        task.status == TaskStatus.partiallyCompleted) {
      pending += 1;
    }
  }
  var due = 0;
  for (final revision in revisions) {
    if (!chapterIds.contains(revision.chapterId)) {
      continue;
    }
    if (revision.status == RevisionStatus.pending ||
        revision.status == RevisionStatus.scheduled ||
        revision.status == RevisionStatus.overdue) {
      due += 1;
    }
  }
  return SubjectProgressView(
    subjectId: subject.id,
    name: subject.name,
    percent: subjectProgressPercent(own),
    chaptersCompleted: completed,
    chapterCount: own.where((chapter) => chapter.status != ChapterStatus.skipped).length,
    confidencePercent: confidencePercent(own),
    studyMinutes: study,
    pendingTasks: pending,
    revisionDue: due,
  );
}

Set<DateTime> _studiedDates(List<StudySession> sessions) {
  return {
    for (final session in sessions)
      if (session.actualMinutes > 0) calendarDate(session.startedAt),
  };
}

int _estimated(List<Chapter> chapters) {
  var total = 0;
  for (final chapter in chapters) {
    if (chapter.status == ChapterStatus.skipped || chapter.estimatedMinutes <= 0) {
      continue;
    }
    total += chapter.estimatedMinutes;
  }
  return total;
}

int _remaining(List<Chapter> chapters) {
  var total = 0;
  for (final chapter in chapters) {
    if (chapter.status == ChapterStatus.skipped ||
        chapter.status == ChapterStatus.completed ||
        chapter.status == ChapterStatus.revised ||
        chapter.estimatedMinutes <= 0) {
      continue;
    }
    final done = chapter.completedMinutes < 0
        ? 0
        : (chapter.completedMinutes > chapter.estimatedMinutes
              ? chapter.estimatedMinutes
              : chapter.completedMinutes);
    total += chapter.estimatedMinutes - done;
  }
  return total;
}
