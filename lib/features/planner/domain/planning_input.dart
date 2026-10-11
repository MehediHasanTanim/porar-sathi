import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/validation/validators.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

/// Maximum points for each scoring component. The defaults sum to 100.
final class ScoreWeights {
  const ScoreWeights({
    this.examUrgency = 25,
    this.difficulty = 10,
    this.confidence = 15,
    this.subjectPriority = 10,
    this.chapterPriority = 10,
    this.examImportance = 10,
    this.backlog = 10,
    this.revision = 5,
    this.neglect = 5,
  });

  final int examUrgency;
  final int difficulty;
  final int confidence;
  final int subjectPriority;
  final int chapterPriority;
  final int examImportance;
  final int backlog;
  final int revision;
  final int neglect;
}

final class PlanningConfig {
  const PlanningConfig({
    this.weights = const ScoreWeights(),
    this.minSessionMinutes = 20,
    this.maxDailySharePercent = 60,
    this.urgencyOverrideDays = 7,
    this.ignoreCompleted = true,
    this.ignoreSkipped = true,
    this.ignoreRevised = true,
  });

  final ScoreWeights weights;
  final int minSessionMinutes;
  final int maxDailySharePercent;
  final int urgencyOverrideDays;
  final bool ignoreCompleted;
  final bool ignoreSkipped;
  final bool ignoreRevised;
}

/// Everything the planner needs for one run. Collections are ordered.
final class PlanningInput {
  const PlanningInput({
    required this.today,
    required this.plan,
    required this.subjects,
    required this.chapters,
    required this.exams,
    required this.syllabus,
    required this.week,
    required this.exceptions,
    required this.lockedTasks,
    required this.existingTasks,
    this.config = const PlanningConfig(),
  });

  final DateTime today;
  final StudyPlan plan;
  final List<Subject> subjects;
  final List<Chapter> chapters;
  final List<Exam> exams;
  final List<ExamSyllabusItem> syllabus;
  final List<WeeklyAvailability> week;
  final List<CalendarException> exceptions;
  final List<StudyTask> lockedTasks;
  final List<StudyTask> existingTasks;
  final PlanningConfig config;
}

/// Validates [input] and returns the same facts in a stable order.
PlanningInput preparePlanningInput(PlanningInput input) {
  final today = calendarDate(input.today);
  requireValid(Validators.planningBufferPercent(input.plan.planningBufferPercent));
  requireValid(Validators.sessionMinutes(input.plan.maxSessionMinutes));
  requireValid(Validators.revisionBufferDays(input.plan.revisionBufferDays));
  final minSession = input.config.minSessionMinutes;
  if (minSession <= 0 || minSession > input.plan.maxSessionMinutes) {
    throw const ValidationException(ValidationIssue.sessionDuration);
  }
  if (input.config.maxDailySharePercent < 1 ||
      input.config.maxDailySharePercent > 100) {
    throw const ValidationException(ValidationIssue.planningBuffer);
  }
  for (final weight in [
    input.config.weights.examUrgency,
    input.config.weights.difficulty,
    input.config.weights.confidence,
    input.config.weights.subjectPriority,
    input.config.weights.chapterPriority,
    input.config.weights.examImportance,
    input.config.weights.backlog,
    input.config.weights.revision,
    input.config.weights.neglect,
  ]) {
    if (weight < 0) {
      throw const ValidationException(ValidationIssue.completionPercent);
    }
  }

  final subjects = [...input.subjects]
    ..sort((a, b) {
      final order = a.sortOrder.compareTo(b.sortOrder);
      if (order != 0) {
        return order;
      }
      final name = a.name.compareTo(b.name);
      if (name != 0) {
        return name;
      }
      return a.id.compareTo(b.id);
    });
  final subjectIds = {for (final subject in subjects) subject.id};
  for (final subject in subjects) {
    if (subject.studyPlanId != input.plan.id) {
      throw const ValidationException(
        ValidationIssue.requiredText,
        message: 'Subject is not part of this study plan.',
      );
    }
  }

  final chapters = [...input.chapters]
    ..sort((a, b) {
      final subject = a.subjectId.compareTo(b.subjectId);
      if (subject != 0) {
        return subject;
      }
      final order = a.sortOrder.compareTo(b.sortOrder);
      if (order != 0) {
        return order;
      }
      final number = (a.chapterNumber ?? 0).compareTo(b.chapterNumber ?? 0);
      if (number != 0) {
        return number;
      }
      return a.id.compareTo(b.id);
    });
  for (final chapter in chapters) {
    if (!subjectIds.contains(chapter.subjectId)) {
      throw const ValidationException(
        ValidationIssue.requiredText,
        message: 'Chapter subject was not found.',
      );
    }
  }

  final exams = [...input.exams]
    ..sort((a, b) {
      final date = a.startDate.compareTo(b.startDate);
      if (date != 0) {
        return date;
      }
      return a.id.compareTo(b.id);
    });
  final examIds = {for (final exam in exams) exam.id};
  for (final exam in exams) {
    if (exam.studyPlanId != input.plan.id) {
      throw const ValidationException(
        ValidationIssue.requiredText,
        message: 'Exam is not part of this study plan.',
      );
    }
  }

  final syllabus = [...input.syllabus]..sort((a, b) => a.id.compareTo(b.id));
  for (final item in syllabus) {
    if (!examIds.contains(item.examId) || !subjectIds.contains(item.subjectId)) {
      throw const ValidationException(
        ValidationIssue.requiredText,
        message: 'Syllabus item does not match this plan.',
      );
    }
  }

  final week = [...input.week]..sort((a, b) => a.weekday.compareTo(b.weekday));
  final seenDays = <int>{};
  for (final day in week) {
    requireValid(Validators.weekday(day.weekday));
    if (!seenDays.add(day.weekday)) {
      throw const ValidationException(ValidationIssue.weekday);
    }
  }

  final exceptions = [...input.exceptions]
    ..sort((a, b) {
      final date = a.date.compareTo(b.date);
      if (date != 0) {
        return date;
      }
      return a.id.compareTo(b.id);
    });
  final locked = [...input.lockedTasks]
    ..sort((a, b) {
      final date = a.plannedDate.compareTo(b.plannedDate);
      if (date != 0) {
        return date;
      }
      return a.id.compareTo(b.id);
    });
  for (final task in locked) {
    if (task.studyPlanId != input.plan.id || !task.isLocked) {
      throw const ValidationException(
        ValidationIssue.requiredText,
        message: 'Locked task does not belong to this plan.',
      );
    }
  }
  final existing = [...input.existingTasks]
    ..sort((a, b) => a.id.compareTo(b.id));

  return PlanningInput(
    today: today,
    plan: input.plan,
    subjects: subjects,
    chapters: chapters,
    exams: exams,
    syllabus: syllabus,
    week: week,
    exceptions: exceptions,
    lockedTasks: locked,
    existingTasks: existing,
    config: input.config,
  );
}
