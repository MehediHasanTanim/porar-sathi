import 'package:porar_sathi/app/router/app_routes.dart';

/// Decides the next location from startup and onboarding state.
///
/// Returns null when the current location should stay.
String? resolveAppRedirect({
  required bool isSettingsLoading,
  required bool hasSettingsError,
  required bool onboardingComplete,
  required String location,
}) {
  if (isSettingsLoading || hasSettingsError) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  if (!onboardingComplete) {
    return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
  }

  const entryLocations = {
    AppRoutes.splash,
    AppRoutes.onboarding,
    AppRoutes.home,
    '/',
  };
  if (entryLocations.contains(location)) {
    return AppRoutes.today;
  }
  return null;
}
