import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

final class TodayTaskItem {
  const TodayTaskItem({
    required this.task,
    required this.subject,
    required this.chapter,
  });

  final StudyTask task;
  final Subject? subject;
  final Chapter? chapter;
}

final class TodayDashboard {
  const TodayDashboard({
    required this.tasks,
    required this.plannedMinutes,
    required this.doneCount,
    required this.syllabusPercent,
    required this.backlogMinutes,
    required this.backlogCount,
    required this.revisionDueCount,
    required this.pace,
    required this.nextExam,
    required this.daysUntilExam,
  });

  final List<TodayTaskItem> tasks;
  final int plannedMinutes;
  final int doneCount;
  final int syllabusPercent;
  final int backlogMinutes;
  final int backlogCount;
  final int revisionDueCount;
  final StudyPace pace;
  final Exam? nextExam;
  final int? daysUntilExam;

  bool get allDone => tasks.isNotEmpty && doneCount == tasks.length;
}

int syllabusCompletionPercent(List<Chapter> chapters) {
  var estimated = 0;
  var done = 0;
  for (final chapter in chapters) {
    if (chapter.status == ChapterStatus.skipped) {
      continue;
    }
    estimated += chapter.estimatedMinutes;
    if (chapter.status == ChapterStatus.completed ||
        chapter.status == ChapterStatus.revised) {
      done += chapter.estimatedMinutes;
      continue;
    }
    final completed = chapter.completedMinutes < 0
        ? 0
        : (chapter.completedMinutes > chapter.estimatedMinutes
              ? chapter.estimatedMinutes
              : chapter.completedMinutes);
    done += completed;
  }
  if (estimated <= 0) {
    return 0;
  }
  final percent = (done * 100 / estimated).round();
  if (percent < 0) {
    return 0;
  }
  if (percent > 100) {
    return 100;
  }
  return percent;
}

int backlogMinutes(List<StudyTask> tasks) {
  var total = 0;
  for (final task in tasks) {
    final done = task.actualMinutes ?? 0;
    final left = task.plannedMinutes - done;
    if (left > 0) {
      total += left;
    }
  }
  return total;
}

StudyPace paceFromRun(PlannerRun? run) {
  if (run == null) {
    return StudyPace.onTrack;
  }
  return switch (run.riskLevel) {
    PlannerRiskLevel.none || PlannerRiskLevel.low => StudyPace.onTrack,
    PlannerRiskLevel.medium => StudyPace.slightlyBehind,
    PlannerRiskLevel.high => StudyPace.behind,
    PlannerRiskLevel.impossible => StudyPace.atRisk,
  };
}

bool taskIsDone(StudyTask task) {
  return task.status == TaskStatus.completed ||
      task.status == TaskStatus.skipped ||
      task.status == TaskStatus.cancelled;
}

int revisionDueCount(List<RevisionSchedule> schedules) {
  var count = 0;
  for (final schedule in schedules) {
    if (schedule.status == RevisionStatus.pending ||
        schedule.status == RevisionStatus.scheduled ||
        schedule.status == RevisionStatus.overdue) {
      count += 1;
    }
  }
  return count;
}
