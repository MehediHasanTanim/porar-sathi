import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/router/redirect.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';

void main() {
  test('stays on splash while settings load', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: true,
        hasSettingsError: false,
        onboardingComplete: false,
        onboardingStep: 'language',
        hasActivePlan: false,
        location: AppRoutes.splash,
      ),
      isNull,
    );
  });

  test('sends a first launch to language selection', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: false,
        onboardingStep: 'language',
        hasActivePlan: false,
        location: AppRoutes.splash,
      ),
      OnboardingStep.language.route,
    );
  });

  test('resumes the saved step and keeps later onboarding screens', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: false,
        onboardingStep: 'availability',
        hasActivePlan: true,
        location: AppRoutes.today,
      ),
      OnboardingStep.availability.route,
    );
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: false,
        onboardingStep: 'availability',
        hasActivePlan: true,
        location: OnboardingStep.exam.route,
      ),
      isNull,
    );
  });

  test('does not open a later step when the plan is missing', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: false,
        onboardingStep: 'summary',
        hasActivePlan: false,
        location: AppRoutes.splash,
      ),
      OnboardingStep.plan.route,
    );
  });

  test('opens today after onboarding', () {
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: true,
        onboardingStep: 'complete',
        hasActivePlan: true,
        location: AppRoutes.splash,
      ),
      AppRoutes.today,
    );
    expect(
      resolveAppRedirect(
        isSettingsLoading: false,
        hasSettingsError: false,
        onboardingComplete: true,
        onboardingStep: 'complete',
        hasActivePlan: true,
        location: OnboardingStep.language.route,
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
        onboardingStep: 'complete',
        hasActivePlan: true,
        location: AppRoutes.plan,
      ),
      isNull,
    );
  });
}
