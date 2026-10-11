import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'revision_schedule.freezed.dart';

@freezed
abstract class RevisionSchedule with _$RevisionSchedule {
  const factory RevisionSchedule({
    required String id,
    required String studyPlanId,
    required String chapterId,
    String? topicId,
    String? sourceStudySessionId,
    required int revisionNumber,
    required DateTime dueDate,
    required int estimatedMinutes,
    required RevisionStatus status,
    DateTime? completedAt,
    required DateTime createdAt,
  }) = _RevisionSchedule;
}

RevisionSchedule normalizeRevisionSchedule(RevisionSchedule schedule) {
  if (schedule.revisionNumber < 1) {
    throw const ValidationException(ValidationIssue.revisionBuffer);
  }
  final estimatedMinutes = requireValid(
    Validators.availabilityMinutes(schedule.estimatedMinutes),
  );
  if (estimatedMinutes == 0) {
    throw const ValidationException(ValidationIssue.availabilityMinutes);
  }
  if (schedule.status == RevisionStatus.completed &&
      schedule.completedAt == null) {
    throw const ValidationException(ValidationIssue.statusTimestamp);
  }
  final topicId = schedule.topicId?.trim();
  return schedule.copyWith(
    dueDate: calendarDate(schedule.dueDate),
    estimatedMinutes: estimatedMinutes,
    topicId: topicId == null || topicId.isEmpty ? null : topicId,
    completedAt: schedule.status == RevisionStatus.completed
        ? schedule.completedAt
        : null,
  );
}
