import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

enum AppLanguage {
  english,
  bangla;

  String get code => switch (this) {
    AppLanguage.english => 'en',
    AppLanguage.bangla => 'bn',
  };

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String? code) {
    return switch (code) {
      'bn' => AppLanguage.bangla,
      _ => AppLanguage.english,
    };
  }

  static AppLanguage fromDevice(Locale? device) {
    if (device?.languageCode == 'bn') {
      return AppLanguage.bangla;
    }
    return AppLanguage.english;
  }
}

enum AppThemePreference {
  system,
  light,
  dark;

  ThemeMode get materialThemeMode => switch (this) {
    AppThemePreference.system => ThemeMode.system,
    AppThemePreference.light => ThemeMode.light,
    AppThemePreference.dark => ThemeMode.dark,
  };

  static AppThemePreference fromCode(String? code) {
    return switch (code) {
      'light' => AppThemePreference.light,
      'dark' => AppThemePreference.dark,
      _ => AppThemePreference.system,
    };
  }
}

/// Bangladesh weeks often start on Saturday. The student can change this.
enum FirstDayOfWeek {
  saturday,
  sunday,
  monday;

  static FirstDayOfWeek fromCode(String? code) {
    return switch (code) {
      'sunday' => FirstDayOfWeek.sunday,
      'monday' => FirstDayOfWeek.monday,
      _ => FirstDayOfWeek.saturday,
    };
  }
}

abstract final class SettingsDefaults {
  static const sessionMinutes = 45;
  static const planningBufferPercent = 15;
  static const autoReplan = true;
}

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    required AppLanguage language,
    required AppThemePreference theme,
    required bool onboardingComplete,
    required FirstDayOfWeek firstDayOfWeek,
    String? currentStudyPlanId,
    required int defaultSessionDuration,
    required int planningBuffer,
    required bool autoReplanEnabled,
  }) = _AppSettings;
}

AppSettings initialAppSettings(AppLanguage language) {
  return AppSettings(
    language: language,
    theme: AppThemePreference.system,
    onboardingComplete: false,
    firstDayOfWeek: FirstDayOfWeek.saturday,
    defaultSessionDuration: SettingsDefaults.sessionMinutes,
    planningBuffer: SettingsDefaults.planningBufferPercent,
    autoReplanEnabled: SettingsDefaults.autoReplan,
  );
}
