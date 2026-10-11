import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/errors/app_exception.dart';

part 'exam_syllabus_item.freezed.dart';

@freezed
abstract class ExamSyllabusItem with _$ExamSyllabusItem {
  const factory ExamSyllabusItem({
    required String id,
    required String examId,
    required String subjectId,
    String? chapterId,
    String? topicId,
    required int weight,
    required bool isRequired,
  }) = _ExamSyllabusItem;
}

ExamSyllabusItem normalizeExamSyllabusItem(ExamSyllabusItem item) {
  if (item.weight < 1 || item.weight > 100) {
    throw const ValidationException(ValidationIssue.estimatedMinutes);
  }
  final topicId = item.topicId?.trim();
  return item.copyWith(
    topicId: topicId == null || topicId.isEmpty ? null : topicId,
  );
}
