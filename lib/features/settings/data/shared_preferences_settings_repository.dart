import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:porar_sathi/features/settings/domain/settings_repository.dart';

final class SharedPreferencesSettingsRepository implements SettingsRepository {
  SharedPreferencesSettingsRepository(
    this._preferences, {
    this.deviceLocale,
  });

  final SharedPreferences _preferences;
  final Locale? deviceLocale;

  static const languageKey = 'language';
  static const themeKey = 'theme';
  static const onboardingCompleteKey = 'onboarding_complete';
  static const firstDayOfWeekKey = 'first_day_of_week';
  static const currentStudyPlanIdKey = 'current_study_plan_id';
  static const defaultSessionDurationKey = 'default_session_duration';
  static const planningBufferKey = 'planning_buffer';
  static const autoReplanEnabledKey = 'auto_replan_enabled';
  static const maxDailyMinutesKey = 'max_daily_minutes';
  static const revisionPolicyKey = 'revision_policy';
  static const defaultPlanningModeKey = 'default_planning_mode';
  static const defaultDailyIntensityKey = 'default_daily_intensity';
  static const reducedMotionKey = 'reduced_motion';
  static const onboardingStepKey = 'onboarding_step';

  @override
  Future<AppSettings> load() async {
    final storedLanguage = _preferences.getString(languageKey);
    final language = storedLanguage == null
        ? AppLanguage.fromDevice(deviceLocale)
        : AppLanguage.fromCode(storedLanguage);

    return AppSettings(
      language: language,
      theme: AppThemePreference.fromCode(_preferences.getString(themeKey)),
      onboardingComplete: _preferences.getBool(onboardingCompleteKey) ?? false,
      firstDayOfWeek: FirstDayOfWeek.fromCode(
        _preferences.getString(firstDayOfWeekKey),
      ),
      currentStudyPlanId: _preferences.getString(currentStudyPlanIdKey),
      defaultSessionDuration:
          _preferences.getInt(defaultSessionDurationKey) ??
          SettingsDefaults.sessionMinutes,
      planningBuffer:
          _preferences.getInt(planningBufferKey) ??
          SettingsDefaults.planningBufferPercent,
      autoReplanEnabled:
          _preferences.getBool(autoReplanEnabledKey) ??
          SettingsDefaults.autoReplan,
      maxDailyMinutes:
          _preferences.getInt(maxDailyMinutesKey) ??
          SettingsDefaults.maxDailyMinutes,
      revisionPolicy: RevisionPolicy.fromStored(
        _preferences.getString(revisionPolicyKey),
      ),
      defaultPlanningMode: _storedOr(
        PlanningMode.values,
        _preferences.getString(defaultPlanningModeKey),
        (value) => value.code,
        PlanningMode.balanced,
      ),
      defaultDailyIntensity: _storedOr(
        DailyIntensity.values,
        _preferences.getString(defaultDailyIntensityKey),
        (value) => value.code,
        DailyIntensity.normal,
      ),
      reducedMotion: _preferences.getBool(reducedMotionKey) ?? false,
      onboardingStep: _preferences.getString(onboardingStepKey) ?? 'language',
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    await _preferences.setString(languageKey, settings.language.code);
    await _preferences.setString(themeKey, settings.theme.name);
    await _preferences.setBool(
      onboardingCompleteKey,
      settings.onboardingComplete,
    );
    await _preferences.setString(
      firstDayOfWeekKey,
      settings.firstDayOfWeek.name,
    );
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      await _preferences.remove(currentStudyPlanIdKey);
    } else {
      await _preferences.setString(currentStudyPlanIdKey, planId);
    }
    await _preferences.setInt(
      defaultSessionDurationKey,
      settings.defaultSessionDuration,
    );
    await _preferences.setInt(planningBufferKey, settings.planningBuffer);
    await _preferences.setBool(autoReplanEnabledKey, settings.autoReplanEnabled);
    await _preferences.setInt(maxDailyMinutesKey, settings.maxDailyMinutes);
    await _preferences.setString(
      revisionPolicyKey,
      settings.revisionPolicy.code,
    );
    await _preferences.setString(
      defaultPlanningModeKey,
      settings.defaultPlanningMode.code,
    );
    await _preferences.setString(
      defaultDailyIntensityKey,
      settings.defaultDailyIntensity.code,
    );
    await _preferences.setBool(reducedMotionKey, settings.reducedMotion);
    await _preferences.setString(onboardingStepKey, settings.onboardingStep);
  }
}

T _storedOr<T>(
  List<T> values,
  String? code,
  String Function(T value) read,
  T fallback,
) {
  for (final value in values) {
    if (read(value) == code) {
      return value;
    }
  }
  return fallback;
}
