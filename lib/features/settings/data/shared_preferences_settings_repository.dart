import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }
}
