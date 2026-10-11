import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'study_task.freezed.dart';

@freezed
abstract class StudyTask with _$StudyTask {
  const factory StudyTask({
    required String id,
    required String studyPlanId,
    required String subjectId,
    String? chapterId,
    String? topicId,
    String? examId,
    required TaskType taskType,
    required String title,
    required DateTime plannedDate,
    int? plannedStartTime,
    required int plannedMinutes,
    int? actualMinutes,
    required int priorityScore,
    required bool isLocked,
    required TaskStatus status,
    required int completionPercent,
    required TaskSource source,
    String? generationBatchId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
  }) = _StudyTask;
}

StudyTask normalizeStudyTask(StudyTask task) {
  final plannedMinutes = requireValid(
    Validators.availabilityMinutes(task.plannedMinutes),
  );
  if (plannedMinutes == 0) {
    throw const ValidationException(ValidationIssue.availabilityMinutes);
  }
  final actualMinutes = task.actualMinutes == null
      ? null
      : requireValid(Validators.estimatedMinutes(task.actualMinutes!));
  final priorityScore = requireValid(
    Validators.completionPercent(task.priorityScore),
  );
  final completionPercent = requireValid(
    Validators.completionPercent(task.completionPercent),
  );
  final plannedStartTime = task.plannedStartTime == null
      ? null
      : requireValid(Validators.timeOfDayMinutes(task.plannedStartTime!));
  final finished =
      task.status == TaskStatus.completed ||
      task.status == TaskStatus.partiallyCompleted;
  if (finished && task.completedAt == null) {
    throw const ValidationException(ValidationIssue.statusTimestamp);
  }
  final topicId = task.topicId?.trim();
  final batch = task.generationBatchId?.trim();
  return task.copyWith(
    title: requireValid(Validators.requiredText(task.title, maxLength: 120)),
    plannedDate: calendarDate(task.plannedDate),
    plannedStartTime: plannedStartTime,
    plannedMinutes: plannedMinutes,
    actualMinutes: actualMinutes,
    priorityScore: priorityScore,
    completionPercent: completionPercent,
    topicId: topicId == null || topicId.isEmpty ? null : topicId,
    generationBatchId: batch == null || batch.isEmpty ? null : batch,
    completedAt: finished ? task.completedAt : null,
  );
}
