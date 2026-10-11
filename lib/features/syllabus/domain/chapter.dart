import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'chapter.freezed.dart';

@freezed
abstract class Chapter with _$Chapter {
  const factory Chapter({
    required String id,
    required String subjectId,
    required String title,
    int? chapterNumber,
    required int estimatedMinutes,
    required int completedMinutes,
    required Difficulty difficulty,
    required Confidence confidence,
    required Priority priority,
    required Priority examImportance,
    required ChapterStatus status,
    String? notes,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
  }) = _Chapter;
}

Chapter normalizeChapter(Chapter chapter) {
  if (chapter.sortOrder < 0 || (chapter.chapterNumber ?? 0) < 0) {
    throw const ValidationException(ValidationIssue.requiredText);
  }
  final estimatedMinutes = requireValid(
    Validators.estimatedMinutes(chapter.estimatedMinutes),
  );
  final completedMinutes = requireValid(
    Validators.estimatedMinutes(chapter.completedMinutes),
  );
  final finished =
      chapter.status == ChapterStatus.completed ||
      chapter.status == ChapterStatus.revised;
  if (finished && chapter.completedAt == null) {
    throw const ValidationException(ValidationIssue.statusTimestamp);
  }
  return chapter.copyWith(
    title: requireValid(Validators.requiredText(chapter.title, maxLength: 120)),
    estimatedMinutes: estimatedMinutes,
    completedMinutes: completedMinutes,
    notes: _optional(chapter.notes),
    completedAt: finished ? chapter.completedAt : null,
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
