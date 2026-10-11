import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/router/app_shell.dart';
import 'package:porar_sathi/app/router/redirect.dart';
import 'package:porar_sathi/features/onboarding/presentation/language_selection_screen.dart';
import 'package:porar_sathi/features/onboarding/presentation/splash_screen.dart';
import 'package:porar_sathi/features/planner/presentation/plan_screen.dart';
import 'package:porar_sathi/features/progress/presentation/progress_screen.dart';
import 'package:porar_sathi/features/sessions/presentation/today_screen.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/settings/presentation/appearance_screen.dart';
import 'package:porar_sathi/features/settings/presentation/more_screen.dart';
import 'package:porar_sathi/features/settings/presentation/study_settings_screen.dart';
import 'package:porar_sathi/features/syllabus/presentation/syllabus_screen.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(settingsControllerProvider, (_, _) {
    refresh.value++;
  });
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final settings = ref.read(settingsControllerProvider);
      return resolveAppRedirect(
        isSettingsLoading: settings.isLoading,
        hasSettingsError: settings.hasError,
        onboardingComplete: settings.asData?.value.onboardingComplete ?? false,
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        redirect: (context, state) => AppRoutes.today,
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.today,
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.plan,
                builder: (context, state) => const PlanScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.syllabus,
                builder: (context, state) => const SyllabusScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.progress,
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.more,
                builder: (context, state) => const MoreScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const StudySettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.appearance,
        builder: (context, state) => const AppearanceScreen(),
      ),
      GoRoute(
        path: AppRoutes.language,
        builder: (context, state) =>
            const LanguageSelectionScreen(showContinue: false),
      ),
    ],
  );
}
