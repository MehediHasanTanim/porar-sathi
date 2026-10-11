import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'study_session.freezed.dart';

@freezed
abstract class StudySession with _$StudySession {
  const factory StudySession({
    required String id,
    String? studyTaskId,
    required String subjectId,
    String? chapterId,
    String? topicId,
    required DateTime startedAt,
    DateTime? endedAt,
    required int plannedMinutes,
    required int actualMinutes,
    required int completionPercent,
    required SessionResult result,
    Confidence? confidenceBefore,
    Confidence? confidenceAfter,
    String? note,
    required DateTime createdAt,
  }) = _StudySession;
}

StudySession normalizeStudySession(StudySession session) {
  final plannedMinutes = requireValid(
    Validators.sessionMinutes(session.plannedMinutes),
  );
  final actualMinutes = requireValid(
    Validators.estimatedMinutes(session.actualMinutes),
  );
  final completionPercent = requireValid(
    Validators.completionPercent(session.completionPercent),
  );
  if (session.endedAt != null && session.endedAt!.isBefore(session.startedAt)) {
    throw const ValidationException(ValidationIssue.dateRange);
  }
  final topicId = session.topicId?.trim();
  return session.copyWith(
    plannedMinutes: plannedMinutes,
    actualMinutes: actualMinutes,
    completionPercent: completionPercent,
    topicId: topicId == null || topicId.isEmpty ? null : topicId,
    note: _optional(session.note),
  );
}

String? _optional(String? value) {
  if (value == null) {
    return null;
  }
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  if (trimmed.length > 500) {
    throw const ValidationException(ValidationIssue.requiredText);
  }
  return trimmed;
}
