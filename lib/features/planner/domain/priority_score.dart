import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/planner/domain/remaining_work.dart';

final class ScoreComponent {
  const ScoreComponent({
    required this.id,
    required this.label,
    required this.points,
  });

  final String id;
  final String label;
  final int points;
}

final class ScoreExplanation {
  const ScoreExplanation({required this.total, required this.components});

  final int total;
  final List<ScoreComponent> components;

  /// `Physics Chapter 4 = 78` followed by each non-zero component.
  String format(String title) {
    final lines = <String>['$title = $total'];
    for (final component in components) {
      if (component.points == 0) {
        continue;
      }
      lines.add('${component.label} +${component.points}');
    }
    return lines.join('\n');
  }
}

/// Bands from the design doc, before syllabus pressure and weight scaling.
int examUrgencyBand(int daysRemaining) {
  if (daysRemaining <= 3) {
    return 25;
  }
  if (daysRemaining <= 7) {
    return 23;
  }
  if (daysRemaining <= 14) {
    return 20;
  }
  if (daysRemaining <= 30) {
    return 15;
  }
  if (daysRemaining <= 60) {
    return 10;
  }
  return 5;
}

int difficultyBand(Difficulty difficulty) {
  return switch (difficulty) {
    Difficulty.veryEasy => 1,
    Difficulty.easy => 3,
    Difficulty.moderate => 5,
    Difficulty.difficult => 8,
    Difficulty.veryDifficult => 10,
  };
}

int confidenceBand(Confidence confidence) {
  return switch (confidence) {
    Confidence.veryHigh => 1,
    Confidence.high => 3,
    Confidence.medium => 7,
    Confidence.low => 11,
    Confidence.veryLow => 15,
  };
}

int priorityBand(Priority priority) {
  return switch (priority) {
    Priority.low => 2,
    Priority.normal => 5,
    Priority.high => 8,
    Priority.critical => 10,
  };
}

int backlogBand(int daysOverdue) {
  if (daysOverdue <= 0) {
    return 0;
  }
  if (daysOverdue == 1) {
    return 2;
  }
  if (daysOverdue == 2) {
    return 4;
  }
  if (daysOverdue <= 4) {
    return 5;
  }
  if (daysOverdue <= 6) {
    return 7;
  }
  return 10;
}

int revisionBand(ChapterStatus status) {
  return status == ChapterStatus.revisionDue ? 5 : 0;
}

/// 0 when this subject has had a fair share of recent study, else up to 5.
int neglectBand({
  required int subjectMinutes,
  required int totalMinutes,
  required int subjectRemaining,
  required int totalRemaining,
}) {
  if (totalMinutes <= 0 || totalRemaining <= 0 || subjectRemaining <= 0) {
    return 0;
  }
  final actualShare = subjectMinutes / totalMinutes;
  final requiredShare = subjectRemaining / totalRemaining;
  if (requiredShare <= 0) {
    return 0;
  }
  final ratio = actualShare / requiredShare;
  if (ratio >= 0.6) {
    return 0;
  }
  if (ratio >= 0.3) {
    return 3;
  }
  return 5;
}

int scaleBand(int band, int tableMax, int weight) {
  if (band <= 0 || tableMax <= 0 || weight <= 0) {
    return 0;
  }
  final scaled = (band * weight / tableMax).round();
  return scaled > weight ? weight : scaled;
}

ScoreExplanation scoreChapter({
  required RemainingChapter work,
  required PlanningInput input,
  required int recentSubjectMinutes,
  required int recentTotalMinutes,
  required int subjectRemaining,
  required int totalRemaining,
}) {
  final weights = input.config.weights;
  final days = work.exam?.startDate.difference(input.today).inDays;
  final urgencyBand = days == null ? 0 : examUrgencyBand(days);
  final pressure = 0.4 + (0.6 * work.unfinishedRatio);
  final urgency = scaleBand((urgencyBand * pressure).round(), 25, weights.examUrgency);
  var difficulty = scaleBand(
    difficultyBand(work.chapter.difficulty),
    10,
    weights.difficulty,
  );
  var confidence = scaleBand(
    confidenceBand(work.chapter.confidence),
    15,
    weights.confidence,
  );
  if (input.plan.planningMode == PlanningMode.weakSubjectFocus) {
    difficulty = _boost(difficulty, weights.difficulty);
    confidence = _boost(confidence, weights.confidence);
  }
  final components = [
    ScoreComponent(id: 'examUrgency', label: 'Exam urgency', points: urgency),
    ScoreComponent(id: 'difficulty', label: 'Difficulty', points: difficulty),
    ScoreComponent(
      id: 'confidence',
      label: 'Low confidence',
      points: confidence,
    ),
    ScoreComponent(
      id: 'subjectPriority',
      label: 'Subject priority',
      points: scaleBand(priorityBand(work.subject.priority), 10, weights.subjectPriority),
    ),
    ScoreComponent(
      id: 'chapterPriority',
      label: 'Chapter priority',
      points: scaleBand(priorityBand(work.chapter.priority), 10, weights.chapterPriority),
    ),
    ScoreComponent(
      id: 'examImportance',
      label: 'Exam importance',
      points: scaleBand(
        work.exam == null ? 0 : priorityBand(work.exam!.importance),
        10,
        weights.examImportance,
      ),
    ),
    ScoreComponent(
      id: 'backlog',
      label: 'Backlog',
      points: scaleBand(backlogBand(work.backlogDays), 10, weights.backlog),
    ),
    ScoreComponent(
      id: 'revision',
      label: 'Revision',
      points: scaleBand(revisionBand(work.chapter.status), 5, weights.revision),
    ),
    ScoreComponent(
      id: 'neglect',
      label: 'Neglect',
      points: scaleBand(
        neglectBand(
          subjectMinutes: recentSubjectMinutes,
          totalMinutes: recentTotalMinutes,
          subjectRemaining: subjectRemaining,
          totalRemaining: totalRemaining,
        ),
        5,
        weights.neglect,
      ),
    ),
  ];
  final raw = components.fold<int>(0, (sum, component) => sum + component.points);
  final total = raw < 0 ? 0 : (raw > 100 ? 100 : raw);
  return ScoreExplanation(total: total, components: components);
}

int _boost(int points, int weight) {
  final boosted = (points * 1.5).round();
  return boosted > weight ? weight : boosted;
}
