import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/app/app.dart';
import 'package:porar_sathi/app/flavor.dart';
import 'package:porar_sathi/app/flavor_provider.dart';
import 'package:porar_sathi/core/database/database_connection.dart';
import 'package:porar_sathi/core/database/database_provider.dart';
import 'package:porar_sathi/core/logging/app_logger.dart';
import 'package:porar_sathi/core/notifications/notification_scheduler.dart';
import 'package:porar_sathi/core/time/local_time_zone.dart';
import 'package:porar_sathi/features/onboarding/data/onboarding_draft_repository.dart';
import 'package:porar_sathi/features/onboarding/data/onboarding_draft_repository_provider.dart';
import 'package:porar_sathi/features/settings/data/settings_repository_provider.dart';
import 'package:porar_sathi/features/settings/data/shared_preferences_settings_repository.dart';

Future<void> bootstrap(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.info('Starting ${flavor.name} (${flavor.applicationId})');

  configureLocalTimeZone();
  await initializeDateFormatting();
  await initializeNotifications();

  final preferences = await SharedPreferences.getInstance();
  final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  final settingsRepository = SharedPreferencesSettingsRepository(
    preferences,
    deviceLocale: deviceLocale,
  );
  final onboardingDraftRepository = SharedPreferencesOnboardingDraftRepository(
    preferences,
  );
  final database = await openAppDatabase();

  runApp(
    ProviderScope(
      overrides: [
        appFlavorProvider.overrideWithValue(flavor),
        settingsRepositoryProvider.overrideWithValue(settingsRepository),
        onboardingDraftRepositoryProvider.overrideWithValue(
          onboardingDraftRepository,
        ),
        appDatabaseProvider.overrideWith((ref) {
          ref.onDispose(database.close);
          return database;
        }),
      ],
      child: const PorarSathiApp(),
    ),
  );
}
