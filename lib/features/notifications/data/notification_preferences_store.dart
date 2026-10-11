import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/features/notifications/domain/notification_preferences.dart';

final class NotificationPreferencesStore {
  NotificationPreferencesStore(this._preferences);

  final SharedPreferences _preferences;

  static const remindersEnabledKey = 'reminders_enabled';
  static const dailyPlanKey = 'reminder_daily_plan';
  static const dailyMinutesKey = 'reminder_daily_minutes';
  static const revisionKey = 'reminder_revision';
  static const revisionMinutesKey = 'reminder_revision_minutes';
  static const examCountdownKey = 'reminder_exam_countdown';
  static const examThresholdsKey = 'reminder_exam_thresholds';
  static const missedTaskKey = 'reminder_missed_task';
  static const missedMinutesKey = 'reminder_missed_minutes';
  static const eveningReviewKey = 'reminder_evening_review';
  static const eveningMinutesKey = 'reminder_evening_minutes';
  static const studySessionKey = 'reminder_study_session';

  NotificationPreferences load() {
    final defaults = NotificationPreferences.defaults();
    final storedThresholds = _preferences.getString(examThresholdsKey);
    return NotificationPreferences(
      remindersEnabled:
          _preferences.getBool(remindersEnabledKey) ??
          defaults.remindersEnabled,
      dailyPlan: _preferences.getBool(dailyPlanKey) ?? defaults.dailyPlan,
      dailyMinutes:
          _preferences.getInt(dailyMinutesKey) ?? defaults.dailyMinutes,
      revision: _preferences.getBool(revisionKey) ?? defaults.revision,
      revisionMinutes:
          _preferences.getInt(revisionMinutesKey) ?? defaults.revisionMinutes,
      examCountdown:
          _preferences.getBool(examCountdownKey) ?? defaults.examCountdown,
      examThresholds: storedThresholds == null
          ? defaults.examThresholds
          : _decodeThresholds(storedThresholds),
      missedTask: _preferences.getBool(missedTaskKey) ?? defaults.missedTask,
      missedMinutes:
          _preferences.getInt(missedMinutesKey) ?? defaults.missedMinutes,
      eveningReview:
          _preferences.getBool(eveningReviewKey) ?? defaults.eveningReview,
      eveningMinutes:
          _preferences.getInt(eveningMinutesKey) ?? defaults.eveningMinutes,
      studySession:
          _preferences.getBool(studySessionKey) ?? defaults.studySession,
    ).normalized();
  }

  Future<void> save(NotificationPreferences preferences) async {
    final value = preferences.normalized();
    await _preferences.setBool(remindersEnabledKey, value.remindersEnabled);
    await _preferences.setBool(dailyPlanKey, value.dailyPlan);
    await _preferences.setInt(dailyMinutesKey, value.dailyMinutes);
    await _preferences.setBool(revisionKey, value.revision);
    await _preferences.setInt(revisionMinutesKey, value.revisionMinutes);
    await _preferences.setBool(examCountdownKey, value.examCountdown);
    final days = value.examThresholds.toList()..sort();
    await _preferences.setString(examThresholdsKey, days.join(','));
    await _preferences.setBool(missedTaskKey, value.missedTask);
    await _preferences.setInt(missedMinutesKey, value.missedMinutes);
    await _preferences.setBool(eveningReviewKey, value.eveningReview);
    await _preferences.setInt(eveningMinutesKey, value.eveningMinutes);
    await _preferences.setBool(studySessionKey, value.studySession);
  }

  static Set<int> _decodeThresholds(String raw) {
    return {
      for (final part in raw.split(','))
        if (int.tryParse(part.trim()) != null) int.parse(part.trim()),
    };
  }
}
