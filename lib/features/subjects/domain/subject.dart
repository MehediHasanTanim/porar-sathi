import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'subject.freezed.dart';

@freezed
abstract class Subject with _$Subject {
  const factory Subject({
    required String id,
    required String studyPlanId,
    required String name,
    String? code,
    String? paperName,
    required String colorToken,
    required String iconToken,
    required Priority priority,
    required Difficulty difficulty,
    required Confidence confidence,
    required SubjectStatus status,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Subject;
}

Subject normalizeSubject(Subject subject) {
  if (subject.sortOrder < 0) {
    throw const ValidationException(ValidationIssue.requiredText);
  }
  return subject.copyWith(
    name: requireValid(Validators.requiredText(subject.name, maxLength: 80)),
    code: _optional(subject.code, maxLength: 20),
    paperName: _optional(subject.paperName, maxLength: 80),
    colorToken: requireValid(
      Validators.requiredText(subject.colorToken, maxLength: 40),
    ),
    iconToken: requireValid(
      Validators.requiredText(subject.iconToken, maxLength: 40),
    ),
  );
}

String? _optional(String? value, {required int maxLength}) {
  if (value == null) {
    return null;
  }
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  if (trimmed.length > maxLength) {
    throw const ValidationException(ValidationIssue.requiredText);
  }
  return trimmed;
}
