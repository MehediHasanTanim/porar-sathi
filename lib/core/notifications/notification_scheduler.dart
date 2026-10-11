import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:porar_sathi/core/logging/app_logger.dart';

/// Local notification boundary. Scheduling rules arrive in Phase 8.
/// Permission is not requested during startup.
abstract interface class NotificationScheduler {
  Future<void> initialize();
}

final class LocalNotificationScheduler implements NotificationScheduler {
  LocalNotificationScheduler({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(settings: settings);
  }
}

Future<void> initializeNotifications() async {
  try {
    await LocalNotificationScheduler().initialize();
  } on Object catch (error, stackTrace) {
    AppLogger.error(
      'Notification plugin failed to initialize',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
