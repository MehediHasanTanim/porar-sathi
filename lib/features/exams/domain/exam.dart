import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'exam.freezed.dart';

@freezed
abstract class Exam with _$Exam {
  const factory Exam({
    required String id,
    required String studyPlanId,
    required String name,
    required ExamType examType,
    required DateTime startDate,
    DateTime? endDate,
    int? timeOfDay,
    required Priority importance,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Exam;
}

Exam normalizeExam(Exam exam) {
  final startDate = calendarDate(exam.startDate);
  final endDate = requireValid(
    Validators.endOnOrAfter(start: startDate, end: exam.endDate),
  );
  final timeOfDay = exam.timeOfDay == null
      ? null
      : requireValid(Validators.timeOfDayMinutes(exam.timeOfDay!));
  return exam.copyWith(
    name: requireValid(Validators.requiredText(exam.name, maxLength: 80)),
    startDate: startDate,
    endDate: endDate,
    timeOfDay: timeOfDay,
    notes: _optional(exam.notes),
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
