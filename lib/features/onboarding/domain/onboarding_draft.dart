import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_draft.freezed.dart';

/// Setup answers kept on device until each step is written to the database.
@freezed
abstract class OnboardingDraft with _$OnboardingDraft {
  const factory OnboardingDraft({
    @Default('language') String step,
    String? studyLevel,
    @Default('') String displayName,
    String? institution,
    String? academicYear,
    String? profileId,
    String? planId,
    @Default('') String planName,
    @Default('EXAM') String planType,
    String? startDate,
    String? targetEndDate,
    @Default(false) bool examSkipped,
    String? examId,
    @Default('') String examName,
    @Default('BOARD') String examType,
    String? examDate,
    String? examEndDate,
    @Default('HIGH') String examImportance,
    @Default([120, 120, 120, 120, 120, 120, 0]) List<int> weekdayMinutes,
    @Default('BALANCED') String planningMode,
    @Default('NORMAL') String dailyIntensity,
    @Default(45) int maxSessionMinutes,
    @Default(15) int planningBufferPercent,
    @Default(7) int revisionBufferDays,
    int? preferredStartTime,
    int? preferredEndTime,
  }) = _OnboardingDraft;

  const OnboardingDraft._();

  /// Saturday through Friday, matching the availability board.
  static const weekdays = [6, 7, 1, 2, 3, 4, 5];
}

DateTime? draftDate(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  final parsed = DateTime.tryParse(value);
  if (parsed == null) {
    return null;
  }
  return DateTime(parsed.year, parsed.month, parsed.day);
}

String storeDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}
