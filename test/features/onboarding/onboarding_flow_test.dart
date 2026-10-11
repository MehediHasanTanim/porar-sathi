import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_provider.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/onboarding/application/onboarding_controller.dart';
import 'package:porar_sathi/features/onboarding/data/onboarding_draft_repository.dart';
import 'package:porar_sathi/features/onboarding/data/onboarding_draft_repository_provider.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/settings/data/settings_repository_provider.dart';
import 'package:porar_sathi/features/settings/data/shared_preferences_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('setup progress survives and exceptions change capacity', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final database = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(
          SharedPreferencesSettingsRepository(
            preferences,
            deviceLocale: const Locale('en'),
          ),
        ),
        onboardingDraftRepositoryProvider.overrideWithValue(
          SharedPreferencesOnboardingDraftRepository(preferences),
        ),
        appDatabaseProvider.overrideWith((ref) {
          ref.onDispose(database.close);
          return database;
        }),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(onboardingControllerProvider.notifier);
    await controller.saveStudyLevel(StudyLevel.hsc);
    await controller.saveProfile(
      displayName: '',
      skippedName: 'Student',
    );
    await controller.savePlan(
      name: 'HSC Final',
      planType: PlanType.exam,
      startDate: DateTime(2026, 10, 11),
      targetEndDate: DateTime(2026, 12, 5),
    );
    await controller.saveAvailability([180, 0, 180, 180, 180, 180, 0]);

    final settings = await container.read(settingsControllerProvider.future);
    expect(settings.onboardingComplete, isFalse);
    expect(settings.currentStudyPlanId, isNotNull);
    expect(settings.onboardingStep, OnboardingStep.studyTime.code);

    final reloaded = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(
          SharedPreferencesSettingsRepository(
            preferences,
            deviceLocale: const Locale('en'),
          ),
        ),
        onboardingDraftRepositoryProvider.overrideWithValue(
          SharedPreferencesOnboardingDraftRepository(preferences),
        ),
        appDatabaseProvider.overrideWithValue(database),
      ],
    );
    addTearDown(reloaded.dispose);
    final draft = await reloaded.read(onboardingControllerProvider.future);
    expect(draft.planName, 'HSC Final');
    expect(draft.studyLevel, StudyLevel.hsc.code);

    final planId = settings.currentStudyPlanId!;
    final week = await reloaded.read(availabilityRepositoryProvider).watchWeek(planId).first;
    final saturday = capacityForDate(
      date: DateTime(2026, 10, 10),
      week: week,
      exceptions: const [],
      planningBufferPercent: 15,
    );
    expect(saturday.schedulableMinutes, 153);

    await reloaded.read(availabilityRepositoryProvider).saveException(
      CalendarException(
        id: 'holiday',
        studyPlanId: planId,
        date: DateTime(2026, 10, 10),
        exceptionType: CalendarExceptionType.holiday,
        isNoStudyDay: true,
        createdAt: DateTime(2026, 10, 11),
      ),
    );
    final exceptions = await reloaded
        .read(availabilityRepositoryProvider)
        .watchExceptions(planId)
        .first;
    final holiday = capacityForDate(
      date: DateTime(2026, 10, 10),
      week: week,
      exceptions: exceptions,
      planningBufferPercent: 15,
    );
    expect(holiday.schedulableMinutes, 0);
  });
}
