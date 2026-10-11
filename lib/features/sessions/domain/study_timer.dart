import 'dart:convert';

/// Idle, running, paused, or completed. Elapsed time is derived from timestamps
/// so a killed process can resume the same session.
enum TimerPhase { idle, running, paused, completed }

final class ActiveStudyTimer {
  const ActiveStudyTimer({
    required this.id,
    required this.subjectId,
    required this.subjectName,
    required this.title,
    required this.plannedMinutes,
    required this.startedAt,
    required this.elapsedBeforeResume,
    required this.phase,
    this.taskId,
    this.chapterId,
    this.examName,
    this.quickStudy = false,
    this.revisionId,
  });

  final String id;
  final String? taskId;
  final String subjectId;
  final String? chapterId;
  final String subjectName;
  final String title;
  final String? examName;
  final int plannedMinutes;
  final DateTime startedAt;
  final int elapsedBeforeResume;
  final TimerPhase phase;
  final bool quickStudy;
  final String? revisionId;

  int elapsedSeconds(DateTime now) {
    if (phase != TimerPhase.running) {
      return elapsedBeforeResume < 0 ? 0 : elapsedBeforeResume;
    }
    final extra = now.difference(startedAt).inSeconds;
    final total = elapsedBeforeResume + (extra < 0 ? 0 : extra);
    return total < 0 ? 0 : total;
  }

  int elapsedMinutes(DateTime now) {
    final seconds = elapsedSeconds(now);
    if (seconds <= 0) {
      return 0;
    }
    final minutes = (seconds / 60).round();
    return minutes < 1 ? 1 : minutes;
  }

  ActiveStudyTimer pause(DateTime now) {
    if (phase != TimerPhase.running) {
      return this;
    }
    return ActiveStudyTimer(
      id: id,
      taskId: taskId,
      subjectId: subjectId,
      chapterId: chapterId,
      subjectName: subjectName,
      title: title,
      examName: examName,
      plannedMinutes: plannedMinutes,
      startedAt: now,
      elapsedBeforeResume: elapsedSeconds(now),
      phase: TimerPhase.paused,
      quickStudy: quickStudy,
      revisionId: revisionId,
    );
  }

  ActiveStudyTimer resume(DateTime now) {
    if (phase != TimerPhase.paused) {
      return this;
    }
    return ActiveStudyTimer(
      id: id,
      taskId: taskId,
      subjectId: subjectId,
      chapterId: chapterId,
      subjectName: subjectName,
      title: title,
      examName: examName,
      plannedMinutes: plannedMinutes,
      startedAt: now,
      elapsedBeforeResume: elapsedBeforeResume,
      phase: TimerPhase.running,
      quickStudy: quickStudy,
      revisionId: revisionId,
    );
  }

  ActiveStudyTimer finish(DateTime now) {
    final elapsed = elapsedSeconds(now);
    return ActiveStudyTimer(
      id: id,
      taskId: taskId,
      subjectId: subjectId,
      chapterId: chapterId,
      subjectName: subjectName,
      title: title,
      examName: examName,
      plannedMinutes: plannedMinutes,
      startedAt: now,
      elapsedBeforeResume: elapsed,
      phase: TimerPhase.completed,
      quickStudy: quickStudy,
      revisionId: revisionId,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'subjectId': subjectId,
      'chapterId': chapterId,
      'subjectName': subjectName,
      'title': title,
      'examName': examName,
      'plannedMinutes': plannedMinutes,
      'startedAt': startedAt.toIso8601String(),
      'elapsedBeforeResume': elapsedBeforeResume,
      'phase': phase.name,
      'quickStudy': quickStudy,
      'revisionId': revisionId,
    };
  }

  static ActiveStudyTimer? fromJson(String raw) {
    Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException {
      return null;
    }
    if (decoded is! Map) {
      return null;
    }
    final json = decoded.cast<String, Object?>();
    final phaseName = json['phase'];
    final phase = TimerPhase.values.where((value) => value.name == phaseName);
    if (phase.isEmpty) {
      return null;
    }
    return ActiveStudyTimer(
      id: json['id']! as String,
      taskId: json['taskId'] as String?,
      subjectId: json['subjectId']! as String,
      chapterId: json['chapterId'] as String?,
      subjectName: json['subjectName']! as String,
      title: json['title']! as String,
      examName: json['examName'] as String?,
      plannedMinutes: json['plannedMinutes']! as int,
      startedAt: DateTime.parse(json['startedAt']! as String),
      elapsedBeforeResume: json['elapsedBeforeResume']! as int,
      phase: phase.first,
      quickStudy: json['quickStudy'] as bool? ?? false,
      revisionId: json['revisionId'] as String?,
    );
  }
}
