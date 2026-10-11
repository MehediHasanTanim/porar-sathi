import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/router/redirect.dart';

void main() {
  test('stays on splash while settings load', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: true,
        hasSettingsError: false,
        onboardingComplete: false,
        location: AppRoutes.splash,
      ),
      isNull,
    );
  });

  test('sends a first launch to onboarding', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: false,
        location: AppRoutes.splash,
      ),
      AppRoutes.onboarding,
    );
  });

  test('keeps the student on onboarding until it is complete', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: false,
        location: AppRoutes.today,
      ),
      AppRoutes.onboarding,
    );
  });

  test('opens today after onboarding', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: true,
        location: AppRoutes.splash,
      ),
      AppRoutes.today,
    );
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: true,
        location: AppRoutes.home,
      ),
      AppRoutes.today,
    );
  });

  test('preserves the current tab after onboarding', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: true,
        location: AppRoutes.plan,
      ),
      isNull,
    );
  });
}
