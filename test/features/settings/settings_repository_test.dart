import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/settings/data/shared_preferences_settings_repository.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('uses Bangla when the device language is Bangla and nothing is saved', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesSettingsRepository(
      preferences,
      deviceLocale: const Locale('bn'),
    );

    final settings = await repository.load();

    expect(settings.language, AppLanguage.bangla);
    expect(settings.theme, AppThemePreference.system);
    expect(settings.onboardingComplete, isFalse);
    expect(settings.firstDayOfWeek, FirstDayOfWeek.saturday);
    expect(settings.defaultSessionDuration, 45);
    expect(settings.planningBuffer, 15);
    expect(settings.autoReplanEnabled, isTrue);
    expect(settings.currentStudyPlanId, isNull);
  });

  test('round-trips every settings field', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesSettingsRepository(preferences);
    const saved = AppSettings(
      language: AppLanguage.bangla,
      theme: AppThemePreference.dark,
      onboardingComplete: true,
      firstDayOfWeek: FirstDayOfWeek.monday,
      currentStudyPlanId: 'plan-1',
      defaultSessionDuration: 60,
      planningBuffer: 20,
      autoReplanEnabled: false,
      maxDailyMinutes: 120,
      revisionPolicy: RevisionPolicy.frequent,
      defaultPlanningMode: PlanningMode.light,
      defaultDailyIntensity: DailyIntensity.focused,
      reducedMotion: true,
      onboardingStep: 'plan',
    );

    await repository.save(saved);
    final loaded = await repository.load();

    expect(loaded, saved);
  });
}
