import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/features/onboarding/domain/onboarding_draft.dart';

abstract interface class OnboardingDraftRepository {
  Future<OnboardingDraft> load();

  Future<void> save(OnboardingDraft draft);
}

final class SharedPreferencesOnboardingDraftRepository
    implements OnboardingDraftRepository {
  SharedPreferencesOnboardingDraftRepository(this._preferences);

  final SharedPreferences _preferences;

  static const key = 'onboarding_draft';

  @override
  Future<OnboardingDraft> load() async {
    final raw = _preferences.getString(key);
    if (raw == null || raw.isEmpty) {
      return const OnboardingDraft();
    }
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, Object?>) {
        return const OnboardingDraft();
      }
      return OnboardingDraft(
        step: json['step'] as String? ?? 'language',
        studyLevel: json['studyLevel'] as String?,
        displayName: json['displayName'] as String? ?? '',
        institution: json['institution'] as String?,
        academicYear: json['academicYear'] as String?,
        profileId: json['profileId'] as String?,
        planId: json['planId'] as String?,
        planName: json['planName'] as String? ?? '',
        planType: json['planType'] as String? ?? 'EXAM',
        startDate: json['startDate'] as String?,
        targetEndDate: json['targetEndDate'] as String?,
        examSkipped: json['examSkipped'] as bool? ?? false,
        examId: json['examId'] as String?,
        examName: json['examName'] as String? ?? '',
        examType: json['examType'] as String? ?? 'BOARD',
        examDate: json['examDate'] as String?,
        examEndDate: json['examEndDate'] as String?,
        examImportance: json['examImportance'] as String? ?? 'HIGH',
        weekdayMinutes: _minutes(json['weekdayMinutes']),
        planningMode: json['planningMode'] as String? ?? 'BALANCED',
        dailyIntensity: json['dailyIntensity'] as String? ?? 'NORMAL',
        maxSessionMinutes: json['maxSessionMinutes'] as int? ?? 45,
        planningBufferPercent: json['planningBufferPercent'] as int? ?? 15,
        revisionBufferDays: json['revisionBufferDays'] as int? ?? 7,
        preferredStartTime: json['preferredStartTime'] as int?,
        preferredEndTime: json['preferredEndTime'] as int?,
      );
    } on Object {
      return const OnboardingDraft();
    }
  }

  @override
  Future<void> save(OnboardingDraft draft) {
    return _preferences.setString(key, jsonEncode(_json(draft)));
  }

  List<int> _minutes(Object? value) {
    if (value is! List || value.length != OnboardingDraft.weekdays.length) {
      return const [120, 120, 120, 120, 120, 120, 0];
    }
    return [for (final item in value) item is int ? item : 0];
  }

  Map<String, Object?> _json(OnboardingDraft draft) {
    return {
      'step': draft.step,
      'studyLevel': draft.studyLevel,
      'displayName': draft.displayName,
      'institution': draft.institution,
      'academicYear': draft.academicYear,
      'profileId': draft.profileId,
      'planId': draft.planId,
      'planName': draft.planName,
      'planType': draft.planType,
      'startDate': draft.startDate,
      'targetEndDate': draft.targetEndDate,
      'examSkipped': draft.examSkipped,
      'examId': draft.examId,
      'examName': draft.examName,
      'examType': draft.examType,
      'examDate': draft.examDate,
      'examEndDate': draft.examEndDate,
      'examImportance': draft.examImportance,
      'weekdayMinutes': draft.weekdayMinutes,
      'planningMode': draft.planningMode,
      'dailyIntensity': draft.dailyIntensity,
      'maxSessionMinutes': draft.maxSessionMinutes,
      'planningBufferPercent': draft.planningBufferPercent,
      'revisionBufferDays': draft.revisionBufferDays,
      'preferredStartTime': draft.preferredStartTime,
      'preferredEndTime': draft.preferredEndTime,
    };
  }
}
