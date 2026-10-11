import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/validation/validators.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';

part 'student_profile.freezed.dart';

@freezed
abstract class StudentProfile with _$StudentProfile {
  const factory StudentProfile({
    required String id,
    required String displayName,
    required StudyLevel studyLevel,
    String? institution,
    String? academicYear,
    required AppLanguage preferredLanguage,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudentProfile;
}

StudentProfile normalizeStudentProfile(StudentProfile profile) {
  final name = requireValid(
    Validators.requiredText(profile.displayName, maxLength: 80),
  );
  final institution = _optionalText(profile.institution, maxLength: 120);
  final academicYear = _optionalText(profile.academicYear, maxLength: 40);
  return profile.copyWith(
    displayName: name,
    institution: institution,
    academicYear: academicYear,
  );
}

String? _optionalText(String? value, {required int maxLength}) {
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
