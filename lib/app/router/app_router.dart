import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/router/app_shell.dart';
import 'package:porar_sathi/app/router/redirect.dart';
import 'package:porar_sathi/features/exams/presentation/exam_screens.dart';
import 'package:porar_sathi/features/onboarding/presentation/language_selection_screen.dart';
import 'package:porar_sathi/features/onboarding/presentation/schedule_screens.dart';
import 'package:porar_sathi/features/onboarding/presentation/setup_screens.dart';
import 'package:porar_sathi/features/onboarding/presentation/splash_screen.dart';
import 'package:porar_sathi/features/planner/presentation/backlog_screens.dart';
import 'package:porar_sathi/features/planner/presentation/exception_screen.dart';
import 'package:porar_sathi/features/planner/presentation/plan_screen.dart';
import 'package:porar_sathi/features/planner/presentation/replan_preview_screen.dart';
import 'package:porar_sathi/features/revision/presentation/revision_screens.dart';
import 'package:porar_sathi/features/subjects/presentation/subject_screens.dart';
import 'package:porar_sathi/features/syllabus/presentation/chapter_screens.dart';
import 'package:porar_sathi/features/progress/presentation/progress_detail_screens.dart';
import 'package:porar_sathi/features/progress/presentation/progress_screen.dart';
import 'package:porar_sathi/features/sessions/presentation/study_flow_screens.dart';
import 'package:porar_sathi/features/sessions/presentation/today_screen.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/backup_restore/presentation/data_backup_screen.dart';
import 'package:porar_sathi/features/backup_restore/presentation/export_backup_screen.dart';
import 'package:porar_sathi/features/backup_restore/presentation/import_backup_screen.dart';
import 'package:porar_sathi/features/notifications/presentation/notification_settings_screen.dart';
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
      final value = settings.asData?.value;
      return resolveAppRedirect(
        isSettingsLoading: settings.isLoading,
        hasSettingsError: settings.hasError,
        onboardingComplete: value?.onboardingComplete ?? false,
        onboardingStep: value?.onboardingStep ?? 'language',
        hasActivePlan: value?.currentStudyPlanId != null,
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding/language',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/onboarding/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/onboarding/study-type',
        builder: (context, state) => const StudyTypeScreen(),
      ),
      GoRoute(
        path: '/onboarding/profile',
        builder: (context, state) => const StudentProfileScreen(),
      ),
      GoRoute(
        path: '/onboarding/plan',
        builder: (context, state) => const CreatePlanScreen(),
      ),
      GoRoute(
        path: '/onboarding/exam',
        builder: (context, state) => const ExamSetupScreen(),
      ),
      GoRoute(
        path: '/onboarding/availability',
        builder: (context, state) => const WeeklyAvailabilityScreen(),
      ),
      GoRoute(
        path: '/onboarding/study-time',
        builder: (context, state) => const PreferredStudyTimeScreen(),
      ),
      GoRoute(
        path: '/onboarding/preferences',
        builder: (context, state) => const PlanningPreferencesScreen(),
      ),
      GoRoute(
        path: '/onboarding/summary',
        builder: (context, state) => const PlanSummaryScreen(),
      ),
      GoRoute(
        path: '/onboarding/notifications',
        builder: (context, state) => const NotificationEducationScreen(),
      ),
      GoRoute(
        path: '/onboarding/complete',
        builder: (context, state) => const SetupCompleteScreen(),
      ),
      GoRoute(
        path: AppRoutes.newSubject,
        builder: (context, state) => const SubjectFormScreen(),
      ),
      GoRoute(
        path: '/subjects/:subjectId/edit',
        builder: (context, state) =>
            SubjectFormScreen(subjectId: state.pathParameters['subjectId']),
      ),
      GoRoute(
        path: '/subjects/:subjectId/chapters/new',
        builder: (context, state) =>
            ChapterFormScreen(subjectId: state.pathParameters['subjectId']!),
      ),
      GoRoute(
        path: '/subjects/:subjectId/chapters/bulk',
        builder: (context, state) =>
            BulkChaptersScreen(subjectId: state.pathParameters['subjectId']!),
      ),
      GoRoute(
        path: '/subjects/:subjectId/chapters/:chapterId',
        builder: (context, state) => ChapterFormScreen(
          subjectId: state.pathParameters['subjectId']!,
          chapterId: state.pathParameters['chapterId'],
        ),
      ),
      GoRoute(
        path: '/subjects/:subjectId/chapters',
        builder: (context, state) =>
            ChapterListScreen(subjectId: state.pathParameters['subjectId']!),
      ),
      GoRoute(
        path: '/subjects/:subjectId',
        builder: (context, state) =>
            SubjectDetailsScreen(subjectId: state.pathParameters['subjectId']!),
      ),
      GoRoute(
        path: AppRoutes.exams,
        builder: (context, state) => const ExamListScreen(),
      ),
      GoRoute(
        path: AppRoutes.newExam,
        builder: (context, state) => const ExamFormScreen(),
      ),
      GoRoute(
        path: '/exams/:examId/edit',
        builder: (context, state) =>
            ExamFormScreen(examId: state.pathParameters['examId']),
      ),
      GoRoute(
        path: '/exams/:examId/syllabus',
        builder: (context, state) =>
            ExamSyllabusScreen(examId: state.pathParameters['examId']!),
      ),
      GoRoute(
        path: '/exams/:examId',
        builder: (context, state) =>
            ExamDetailsScreen(examId: state.pathParameters['examId']!),
      ),
      GoRoute(
        path: AppRoutes.availability,
        builder: (context, state) =>
            const WeeklyAvailabilityScreen(onboarding: false),
      ),
      GoRoute(
        path: AppRoutes.newException,
        builder: (context, state) => const CalendarExceptionScreen(),
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
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.dataBackup,
        builder: (context, state) => const DataBackupScreen(),
      ),
      GoRoute(
        path: AppRoutes.exportBackup,
        builder: (context, state) => const ExportBackupScreen(),
      ),
      GoRoute(
        path: AppRoutes.importBackup,
        builder: (context, state) => const ImportBackupScreen(),
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
      GoRoute(
        path: AppRoutes.session,
        builder: (context, state) => const StudySessionScreen(),
      ),
      GoRoute(
        path: AppRoutes.finishSession,
        builder: (context, state) => const FinishSessionScreen(),
      ),
      GoRoute(
        path: AppRoutes.quickStudy,
        builder: (context, state) => const QuickStudyScreen(),
      ),
      GoRoute(
        path: '/tasks/:taskId/complete',
        builder: (context, state) =>
            FinishSessionScreen(taskId: state.pathParameters['taskId']),
      ),
      GoRoute(
        path: '/tasks/:taskId/partial',
        builder: (context, state) =>
            PartialCompletionScreen(taskId: state.pathParameters['taskId']!),
      ),
      GoRoute(
        path: '/tasks/:taskId/move',
        builder: (context, state) =>
            MoveTaskScreen(taskId: state.pathParameters['taskId']!),
      ),
      GoRoute(
        path: '/tasks/:taskId',
        builder: (context, state) =>
            TaskDetailScreen(taskId: state.pathParameters['taskId']!),
      ),
      GoRoute(
        path: AppRoutes.revisionComplete,
        builder: (context, state) => const RevisionCompleteScreen(),
      ),
      GoRoute(
        path: '/revisions/:revisionId',
        builder: (context, state) => RevisionDetailScreen(
          revisionId: state.pathParameters['revisionId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.revisions,
        builder: (context, state) => const RevisionQueueScreen(),
      ),
      GoRoute(
        path: '/backlog/:taskId',
        builder: (context, state) =>
            BacklogTaskScreen(taskId: state.pathParameters['taskId']!),
      ),
      GoRoute(
        path: AppRoutes.backlog,
        builder: (context, state) => const BacklogDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.catchUp,
        builder: (context, state) => const CatchUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.replan,
        builder: (context, state) => const ReplanPreviewScreen(),
      ),
      GoRoute(
        path: AppRoutes.progressConsistency,
        builder: (context, state) => const ConsistencyScreen(),
      ),
      GoRoute(
        path: AppRoutes.progressReadiness,
        builder: (context, state) => const ReadinessScreen(),
      ),
      GoRoute(
        path: AppRoutes.progressDaily,
        builder: (context, state) => const DailySummaryScreen(),
      ),
      GoRoute(
        path: AppRoutes.progressWeekly,
        builder: (context, state) => const WeeklySummaryScreen(),
      ),
      GoRoute(
        path: '/progress/subjects/:subjectId',
        builder: (context, state) => SubjectProgressScreen(
          subjectId: state.pathParameters['subjectId']!,
        ),
      ),
    ],
  );
}
