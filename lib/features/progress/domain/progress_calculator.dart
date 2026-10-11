import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

enum ProgressRange { week, month, all }

/// Chapter completion from minutes. Completed chapters count in full.
int chapterProgressPercent(Chapter chapter) {
  if (chapter.estimatedMinutes <= 0) {
    return 0;
  }
  if (chapter.status == ChapterStatus.completed || chapter.status == ChapterStatus.revised) {
    return 100;
  }
  return _percent(_countedMinutes(chapter), chapter.estimatedMinutes);
}

/// Subject progress weighted by each chapter's estimated minutes.
int subjectProgressPercent(List<Chapter> chapters) {
  return _weighted(chapters);
}

/// Overall progress weighted by subject workload, which is chapter minutes.
///
/// A 10-minute finished chapter and a 90-minute untouched chapter are 10%,
/// not the average of 100 and 0.
int overallProgressPercent(List<Chapter> chapters) {
  return _weighted(chapters);
}

int _weighted(List<Chapter> chapters) {
  var estimated = 0;
  var done = 0;
  for (final chapter in chapters) {
    if (chapter.status == ChapterStatus.skipped || chapter.estimatedMinutes <= 0) {
      continue;
    }
    estimated += chapter.estimatedMinutes;
    done += _countedMinutes(chapter);
  }
  return _percent(done, estimated);
}

int _countedMinutes(Chapter chapter) {
  if (chapter.status == ChapterStatus.completed || chapter.status == ChapterStatus.revised) {
    return chapter.estimatedMinutes;
  }
  if (chapter.completedMinutes < 0) {
    return 0;
  }
  if (chapter.completedMinutes > chapter.estimatedMinutes) {
    return chapter.estimatedMinutes;
  }
  return chapter.completedMinutes;
}

int _percent(int done, int total) {
  if (total <= 0) {
    return 0;
  }
  final percent = (done * 100 / total).round();
  if (percent < 0) {
    return 0;
  }
  if (percent > 100) {
    return 100;
  }
  return percent;
}

final class DailySummary {
  const DailySummary({
    required this.plannedMinutes,
    required this.actualMinutes,
    required this.completedTasks,
    required this.partialTasks,
    required this.missedTasks,
    required this.mostStudiedSubjectId,
  });

  final int plannedMinutes;
  final int actualMinutes;
  final int completedTasks;
  final int partialTasks;
  final int missedTasks;
  final String? mostStudiedSubjectId;
}

DailySummary summarizeDay({
  required DateTime day,
  required List<StudyTask> tasks,
  required List<StudySession> sessions,
}) {
  final date = calendarDate(day);
  var planned = 0;
  var completed = 0;
  var partial = 0;
  var missed = 0;
  for (final task in tasks) {
    if (calendarDate(task.plannedDate) != date) {
      continue;
    }
    planned += task.plannedMinutes;
    if (task.status == TaskStatus.completed) {
      completed += 1;
    } else if (task.status == TaskStatus.partiallyCompleted) {
      partial += 1;
    } else if (task.status == TaskStatus.missed) {
      missed += 1;
    }
  }
  final bySubject = <String, int>{};
  var actual = 0;
  for (final session in sessions) {
    if (calendarDate(session.startedAt) != date) {
      continue;
    }
    final minutes = session.actualMinutes < 0 ? 0 : session.actualMinutes;
    actual += minutes;
    bySubject[session.subjectId] = (bySubject[session.subjectId] ?? 0) + minutes;
  }
  return DailySummary(
    plannedMinutes: planned,
    actualMinutes: actual,
    completedTasks: completed,
    partialTasks: partial,
    missedTasks: missed,
    mostStudiedSubjectId: _busiest(bySubject),
  );
}

final class WeeklySummary {
  const WeeklySummary({
    required this.targetMinutes,
    required this.actualMinutes,
    required this.taskCompletionPercent,
    required this.syllabusDelta,
    required this.revisionCount,
    required this.mostImprovedSubjectId,
    required this.neglectedSubjectId,
  });

  final int targetMinutes;
  final int actualMinutes;
  final int taskCompletionPercent;
  final int syllabusDelta;
  final int revisionCount;
  final String? mostImprovedSubjectId;
  final String? neglectedSubjectId;
}

WeeklySummary summarizeWeek({
  required DateTime today,
  required List<StudyTask> tasks,
  required List<StudySession> sessions,
  required List<Chapter> chapters,
  required List<RevisionSchedule> revisions,
  required Map<String, int> remainingBySubject,
}) {
  final start = calendarDate(today).subtract(const Duration(days: 6));
  final end = calendarDate(today);
  var target = 0;
  var considered = 0;
  var completed = 0;
  for (final task in tasks) {
    final date = calendarDate(task.plannedDate);
    if (date.isBefore(start) || date.isAfter(end)) {
      continue;
    }
    if (task.status == TaskStatus.cancelled) {
      continue;
    }
    target += task.plannedMinutes;
    considered += 1;
    if (task.status == TaskStatus.completed) {
      completed += 1;
    }
  }
  final studiedBySubject = <String, int>{};
  final studiedByChapter = <String, int>{};
  var actual = 0;
  final tasksById = {for (final task in tasks) task.id: task};
  for (final session in sessions) {
    final date = calendarDate(session.startedAt);
    if (date.isBefore(start) || date.isAfter(end)) {
      continue;
    }
    final minutes = session.actualMinutes < 0 ? 0 : session.actualMinutes;
    actual += minutes;
    studiedBySubject[session.subjectId] = (studiedBySubject[session.subjectId] ?? 0) + minutes;
    final task = session.studyTaskId == null ? null : tasksById[session.studyTaskId];
    if (task?.taskType == TaskType.revision || session.chapterId == null) {
      continue;
    }
    studiedByChapter[session.chapterId!] = (studiedByChapter[session.chapterId!] ?? 0) + minutes;
  }
  var revisionCount = 0;
  for (final revision in revisions) {
    final completedAt = revision.completedAt;
    if (revision.status != RevisionStatus.completed || completedAt == null) {
      continue;
    }
    final date = calendarDate(completedAt);
    if (!date.isBefore(start) && !date.isAfter(end)) {
      revisionCount += 1;
    }
  }
  return WeeklySummary(
    targetMinutes: target,
    actualMinutes: actual,
    taskCompletionPercent: _percent(completed, considered),
    syllabusDelta: _syllabusDelta(chapters, studiedByChapter),
    revisionCount: revisionCount,
    mostImprovedSubjectId: _busiest(studiedBySubject),
    neglectedSubjectId: _neglected(remainingBySubject, studiedBySubject),
  );
}

int _syllabusDelta(List<Chapter> chapters, Map<String, int> studiedByChapter) {
  final current = overallProgressPercent(chapters);
  final rewound = [
    for (final chapter in chapters)
      chapter.copyWith(
        completedMinutes: _rewoundMinutes(chapter, studiedByChapter[chapter.id] ?? 0),
        status: ChapterStatus.inProgress,
      ),
  ];
  final previous = overallProgressPercent(rewound);
  final delta = current - previous;
  return delta < 0 ? 0 : delta;
}

int _rewoundMinutes(Chapter chapter, int studied) {
  final current = _countedMinutes(chapter);
  final left = current - studied;
  return left < 0 ? 0 : left;
}

String? _busiest(Map<String, int> minutesBySubject) {
  String? winner;
  var best = 0;
  final ids = minutesBySubject.keys.toList()..sort();
  for (final id in ids) {
    final minutes = minutesBySubject[id] ?? 0;
    if (minutes > best) {
      best = minutes;
      winner = id;
    }
  }
  return best <= 0 ? null : winner;
}

String? _neglected(Map<String, int> remainingBySubject, Map<String, int> studiedBySubject) {
  String? winner;
  var lowestStudy = 1 << 30;
  var highestRemaining = -1;
  final ids = remainingBySubject.keys.toList()..sort();
  for (final id in ids) {
    final remaining = remainingBySubject[id] ?? 0;
    if (remaining <= 0) {
      continue;
    }
    final studied = studiedBySubject[id] ?? 0;
    if (studied < lowestStudy || (studied == lowestStudy && remaining > highestRemaining)) {
      lowestStudy = studied;
      highestRemaining = remaining;
      winner = id;
    }
  }
  return winner;
}

final class ConsistencyWindow {
  const ConsistencyWindow({required this.studiedDays, required this.availableDays});

  final int studiedDays;
  final int availableDays;

  int get percent {
    if (availableDays <= 0) {
      return 100;
    }
    return _percent(studiedDays, availableDays);
  }
}

/// Studied available days divided by available days. Off days are ignored.
ConsistencyWindow consistencyWindow({
  required DateTime today,
  required int dayCount,
  required bool Function(DateTime date) isAvailable,
  required bool Function(DateTime date) wasStudied,
}) {
  final end = calendarDate(today);
  var available = 0;
  var studied = 0;
  for (var offset = 0; offset < dayCount; offset++) {
    final date = end.subtract(Duration(days: offset));
    if (!isAvailable(date)) {
      continue;
    }
    available += 1;
    if (wasStudied(date)) {
      studied += 1;
    }
  }
  return ConsistencyWindow(studiedDays: studied, availableDays: available);
}

final class ReadinessScore {
  const ReadinessScore({
    required this.percent,
    required this.syllabusPercent,
    required this.confidencePercent,
    required this.revisionPercent,
    required this.backlogHealthPercent,
    required this.consistencyPercent,
  });

  final int percent;
  final int syllabusPercent;
  final int confidencePercent;
  final int revisionPercent;
  final int backlogHealthPercent;
  final int consistencyPercent;
}

/// Preparation indicator. This is not an exam-score prediction.
ReadinessScore preparationReadiness({
  required int syllabusPercent,
  required int confidencePercent,
  required int revisionPercent,
  required int backlogHealthPercent,
  required int consistencyPercent,
}) {
  final syllabus = syllabusPercent.clamp(0, 100);
  final confidence = confidencePercent.clamp(0, 100);
  final revision = revisionPercent.clamp(0, 100);
  final backlog = backlogHealthPercent.clamp(0, 100);
  final consistency = consistencyPercent.clamp(0, 100);
  final percent =
      (syllabus * 40 + confidence * 25 + revision * 20 + backlog * 10 + consistency * 5) ~/ 100;
  return ReadinessScore(
    percent: percent,
    syllabusPercent: syllabus,
    confidencePercent: confidence,
    revisionPercent: revision,
    backlogHealthPercent: backlog,
    consistencyPercent: consistency,
  );
}

int confidencePercent(List<Chapter> chapters) {
  var estimated = 0;
  var weighted = 0;
  for (final chapter in chapters) {
    if (chapter.status == ChapterStatus.skipped || chapter.estimatedMinutes <= 0) {
      continue;
    }
    estimated += chapter.estimatedMinutes;
    weighted += chapter.estimatedMinutes * _confidencePoints(chapter.confidence);
  }
  return _percent(weighted, estimated * 100);
}

int _confidencePoints(Confidence confidence) {
  return switch (confidence) {
    Confidence.veryLow => 0,
    Confidence.low => 25,
    Confidence.medium => 50,
    Confidence.high => 75,
    Confidence.veryHigh => 100,
  };
}

int revisionCompletionPercent(List<RevisionSchedule> revisions) {
  var total = 0;
  var completed = 0;
  for (final revision in revisions) {
    if (revision.status == RevisionStatus.skipped) {
      continue;
    }
    total += 1;
    if (revision.status == RevisionStatus.completed) {
      completed += 1;
    }
  }
  if (total == 0) {
    return 100;
  }
  return _percent(completed, total);
}

int backlogHealthPercent({required int backlogMinutes, required int estimatedMinutes}) {
  if (backlogMinutes <= 0) {
    return 100;
  }
  if (estimatedMinutes <= 0) {
    return 0;
  }
  final healthy = estimatedMinutes - backlogMinutes;
  return _percent(healthy < 0 ? 0 : healthy, estimatedMinutes);
}

final class OnTrackReport {
  const OnTrackReport({
    required this.pace,
    required this.remainingMinutes,
    required this.capacityMinutes,
  });

  final StudyPace pace;
  final int remainingMinutes;
  final int capacityMinutes;
}

/// Classifies pace from remaining work and capacity before the exam.
OnTrackReport classifyOnTrack({
  required int remainingMinutes,
  required int capacityMinutes,
  int? daysBeforeExam,
  int revisionBufferDays = 7,
}) {
  final remaining = remainingMinutes < 0 ? 0 : remainingMinutes;
  final capacity = capacityMinutes < 0 ? 0 : capacityMinutes;
  final pace = _pace(
    remaining: remaining,
    capacity: capacity,
    daysBeforeExam: daysBeforeExam,
    revisionBufferDays: revisionBufferDays < 0 ? 0 : revisionBufferDays,
  );
  return OnTrackReport(pace: pace, remainingMinutes: remaining, capacityMinutes: capacity);
}

StudyPace _pace({
  required int remaining,
  required int capacity,
  required int? daysBeforeExam,
  required int revisionBufferDays,
}) {
  if (remaining == 0) {
    return StudyPace.onTrack;
  }
  if (capacity < remaining) {
    return StudyPace.atRisk;
  }
  if (daysBeforeExam == null || daysBeforeExam <= 0) {
    return StudyPace.onTrack;
  }
  if (daysBeforeExam > revisionBufferDays + 7) {
    return StudyPace.ahead;
  }
  if (daysBeforeExam >= revisionBufferDays) {
    return StudyPace.onTrack;
  }
  final halfway = (revisionBufferDays / 2).ceil();
  if (daysBeforeExam >= halfway) {
    return StudyPace.slightlyBehind;
  }
  if (daysBeforeExam >= 1) {
    return StudyPace.behind;
  }
  return StudyPace.atRisk;
}

final class SubjectShare {
  const SubjectShare({required this.subjectId, required this.minutes, required this.percent});

  final String subjectId;
  final int minutes;
  final int percent;
}

List<SubjectShare> subjectShares({
  required Map<String, int> minutesBySubject,
}) {
  final total = minutesBySubject.values.fold<int>(0, (sum, minutes) => sum + minutes);
  final ids = minutesBySubject.keys.toList()..sort();
  return [
    for (final id in ids)
      SubjectShare(
        subjectId: id,
        minutes: minutesBySubject[id] ?? 0,
        percent: _percent(minutesBySubject[id] ?? 0, total),
      ),
  ];
}

bool inProgressRange({
  required DateTime date,
  required DateTime today,
  required ProgressRange range,
  required DateTime planStart,
}) {
  final day = calendarDate(date);
  final end = calendarDate(today);
  if (day.isAfter(end)) {
    return false;
  }
  final start = switch (range) {
    ProgressRange.week => end.subtract(const Duration(days: 6)),
    ProgressRange.month => end.subtract(const Duration(days: 29)),
    ProgressRange.all => calendarDate(planStart),
  };
  return !day.isBefore(start);
}

int rangeDayCount(ProgressRange range, DateTime today, DateTime planStart) {
  return switch (range) {
    ProgressRange.week => 7,
    ProgressRange.month => 30,
    ProgressRange.all => _allDays(today, planStart),
  };
}

int _allDays(DateTime today, DateTime planStart) {
  final days = calendarDate(today).difference(calendarDate(planStart)).inDays + 1;
  if (days < 1) {
    return 1;
  }
  if (days > 366) {
    return 366;
  }
  return days;
}
