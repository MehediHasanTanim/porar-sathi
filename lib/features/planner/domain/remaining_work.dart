import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

/// One chapter the planner may still schedule.
final class RemainingChapter {
  const RemainingChapter({
    required this.chapter,
    required this.subject,
    required this.exam,
    required this.remainingMinutes,
    required this.backlogDays,
    required this.deadline,
    required this.unfinishedRatio,
  });

  final Chapter chapter;
  final Subject subject;
  final Exam? exam;
  final int remainingMinutes;
  final int backlogDays;
  final DateTime? deadline;
  final double unfinishedRatio;
}

/// Minutes still required. Never negative.
int remainingChapterMinutes(
  Chapter chapter, {
  bool ignoreCompleted = true,
  bool ignoreSkipped = true,
  bool ignoreRevised = true,
}) {
  if (ignoreCompleted &&
      (chapter.status == ChapterStatus.completed ||
          chapter.status == ChapterStatus.revised)) {
    return 0;
  }
  if (ignoreRevised && chapter.status == ChapterStatus.revised) {
    return 0;
  }
  if (ignoreSkipped && chapter.status == ChapterStatus.skipped) {
    return 0;
  }
  final remaining = chapter.estimatedMinutes - chapter.completedMinutes;
  return remaining < 0 ? 0 : remaining;
}

List<RemainingChapter> remainingWork(PlanningInput input) {
  final subjects = {for (final subject in input.subjects) subject.id: subject};
  final items = <RemainingChapter>[];
  for (final chapter in input.chapters) {
    final subject = subjects[chapter.subjectId];
    if (subject == null || subject.status != SubjectStatus.active) {
      continue;
    }
    final minutes = remainingChapterMinutes(
      chapter,
      ignoreCompleted: input.config.ignoreCompleted,
      ignoreSkipped: input.config.ignoreSkipped,
      ignoreRevised: input.config.ignoreRevised,
    );
    if (minutes == 0 && chapter.status != ChapterStatus.revisionDue) {
      continue;
    }
    if (minutes == 0) {
      continue;
    }
    final exam = _examFor(input, chapter);
    items.add(
      RemainingChapter(
        chapter: chapter,
        subject: subject,
        exam: exam,
        remainingMinutes: minutes,
        backlogDays: _backlogDays(input, chapter.id),
        deadline: exam == null ? null : calendarDate(exam.startDate),
        unfinishedRatio: _subjectUnfinishedRatio(input, subject.id),
      ),
    );
  }
  return items;
}

/// Remaining minutes of [chapters] that this exam includes.
int examRemainingMinutes({
  required PlanningInput input,
  required Exam exam,
  required List<RemainingChapter> work,
}) {
  var total = 0;
  for (final item in work) {
    if (item.exam?.id == exam.id) {
      total += item.remainingMinutes;
    }
  }
  return total;
}

Exam? _examFor(PlanningInput input, Chapter chapter) {
  Exam? earliest;
  for (final item in input.syllabus) {
    final matchesChapter = item.chapterId == chapter.id;
    final matchesSubject = item.chapterId == null && item.subjectId == chapter.subjectId;
    if (!matchesChapter && !matchesSubject) {
      continue;
    }
    final exam = _findExam(input, item.examId);
    if (exam == null || exam.startDate.isBefore(input.today)) {
      continue;
    }
    if (earliest == null || exam.startDate.isBefore(earliest.startDate)) {
      earliest = exam;
    }
  }
  if (earliest != null) {
    return earliest;
  }
  final primary = input.plan.primaryExamId;
  if (primary != null) {
    final exam = _findExam(input, primary);
    if (exam != null && !exam.startDate.isBefore(input.today)) {
      return exam;
    }
  }
  for (final exam in input.exams) {
    if (!exam.startDate.isBefore(input.today)) {
      return exam;
    }
  }
  return null;
}

Exam? _findExam(PlanningInput input, String id) {
  for (final exam in input.exams) {
    if (exam.id == id) {
      return exam;
    }
  }
  return null;
}

int _backlogDays(PlanningInput input, String chapterId) {
  var oldest = 0;
  for (final task in input.existingTasks) {
    if (task.chapterId != chapterId || task.status != TaskStatus.missed) {
      continue;
    }
    final days = input.today.difference(calendarDate(task.plannedDate)).inDays;
    if (days > oldest) {
      oldest = days;
    }
  }
  return oldest;
}

double _subjectUnfinishedRatio(PlanningInput input, String subjectId) {
  var estimated = 0;
  var remaining = 0;
  for (final chapter in input.chapters) {
    if (chapter.subjectId != subjectId) {
      continue;
    }
    estimated += chapter.estimatedMinutes;
    remaining += remainingChapterMinutes(
      chapter,
      ignoreCompleted: input.config.ignoreCompleted,
      ignoreSkipped: input.config.ignoreSkipped,
      ignoreRevised: input.config.ignoreRevised,
    );
  }
  if (estimated <= 0) {
    return 1;
  }
  final ratio = remaining / estimated;
  if (ratio < 0) {
    return 0;
  }
  if (ratio > 1) {
    return 1;
  }
  return ratio;
}
