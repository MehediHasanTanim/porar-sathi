import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';

/// Decides the next location from startup and onboarding state.
///
/// Returns null when the current location should stay.
String? resolveAppRedirect({
  required bool isSettingsLoading,
  required bool hasSettingsError,
  required bool onboardingComplete,
  required String onboardingStep,
  required bool hasActivePlan,
  required String location,
}) {
  if (isSettingsLoading || hasSettingsError) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  if (!onboardingComplete) {
    final resume = resumeOnboardingStep(
      stepCode: onboardingStep,
      hasActivePlan: hasActivePlan,
    );
    final current = OnboardingStep.fromLocation(location);
    if (current != null) {
      if (current.requiresPlan && !hasActivePlan) {
        return OnboardingStep.plan.route;
      }
      return null;
    }
    return resume.route;
  }

  final leavingSetup =
      location == AppRoutes.splash ||
      location == AppRoutes.home ||
      location == '/' ||
      location == AppRoutes.onboarding ||
      location.startsWith('${AppRoutes.onboarding}/');
  if (leavingSetup) {
    return AppRoutes.today;
  }
  return null;
}
