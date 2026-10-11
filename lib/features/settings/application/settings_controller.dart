import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/validation/validators.dart';
import 'package:porar_sathi/features/settings/data/settings_repository_provider.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';

part 'settings_controller.g.dart';

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  Future<AppSettings> build() {
    return ref.watch(settingsRepositoryProvider).load();
  }

  Future<void> setLanguage(AppLanguage language) {
    return _update((settings) => settings.copyWith(language: language));
  }

  Future<void> setTheme(AppThemePreference theme) {
    return _update((settings) => settings.copyWith(theme: theme));
  }

  Future<void> setFirstDayOfWeek(FirstDayOfWeek day) {
    return _update((settings) => settings.copyWith(firstDayOfWeek: day));
  }

  Future<void> setCurrentStudyPlanId(String? id) {
    return _update((settings) => settings.copyWith(currentStudyPlanId: id));
  }

  Future<void> setDefaultSessionDuration(int minutes) async {
    final result = Validators.sessionMinutes(minutes);
    switch (result) {
      case Success(:final value):
        await _update(
          (settings) => settings.copyWith(defaultSessionDuration: value),
        );
      case Failure(:final error):
        throw error;
    }
  }

  Future<void> setPlanningBuffer(int percent) async {
    final result = Validators.planningBufferPercent(percent);
    switch (result) {
      case Success(:final value):
        await _update((settings) => settings.copyWith(planningBuffer: value));
      case Failure(:final error):
        throw error;
    }
  }

  Future<void> setAutoReplanEnabled({required bool enabled}) {
    return _update(
      (settings) => settings.copyWith(autoReplanEnabled: enabled),
    );
  }

  /// Language selection is the foundation gate. Phase 3 inserts the rest of
  /// onboarding before this flag is set.
  Future<void> completeOnboarding() {
    return _update(
      (settings) => settings.copyWith(onboardingComplete: true),
    );
  }

  Future<void> reload() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> _update(AppSettings Function(AppSettings current) transform) async {
    final current = await future;
    final updated = transform(current);
    state = AsyncData(updated);
    try {
      await ref.read(settingsRepositoryProvider).save(updated);
    } on Object {
      state = AsyncData(current);
      rethrow;
    }
  }
}
