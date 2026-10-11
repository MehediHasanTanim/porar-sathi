import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:porar_sathi/core/logging/app_logger.dart';
import 'package:porar_sathi/features/notifications/domain/planned_notification.dart';

/// Local notification boundary. Widgets talk to this interface, not the plugin.
abstract interface class NotificationScheduler {
  set onSelected(void Function(String? payload)? value);

  String? takeLaunchPayload();

  Future<void> initialize();

  Future<bool> requestPermission();

  Future<bool> isPermitted();

  Future<void> openSystemSettings();

  Future<void> replaceScheduled(List<PlannedNotification> notifications);
}

final class LocalNotificationScheduler implements NotificationScheduler {
  LocalNotificationScheduler({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _idsKey = 'scheduled_notification_ids';

  final FlutterLocalNotificationsPlugin _plugin;
  void Function(String? payload)? _onSelected;
  String? _launchPayload;

  @override
  set onSelected(void Function(String? payload)? value) {
    _onSelected = value;
  }

  @override
  String? takeLaunchPayload() {
    final payload = _launchPayload;
    _launchPayload = null;
    return payload;
  }

  @override
  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
      macOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        _onSelected?.call(response.payload);
      },
    );
    final launch = await _plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      _launchPayload = launch?.notificationResponse?.payload;
    }
  }

  @override
  Future<bool> requestPermission() async {
    final android = await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    final ios = await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    final mac = await _plugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    if (android == false || ios == false || mac == false) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> isPermitted() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.areNotificationsEnabled() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return (await ios.checkPermissions())?.isEnabled ?? false;
    }
    final mac = _plugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >();
    if (mac != null) {
      return (await mac.checkPermissions())?.isEnabled ?? false;
    }
    return !kIsWeb;
  }

  @override
  Future<void> openSystemSettings() {
    return _plugin.openAppNotificationSettings();
  }

  @override
  Future<void> replaceScheduled(List<PlannedNotification> notifications) async {
    final preferences = await SharedPreferences.getInstance();
    final previous = preferences.getStringList(_idsKey) ?? const <String>[];
    for (final raw in previous) {
      final id = int.tryParse(raw);
      if (id != null) {
        await _plugin.cancel(id: id);
      }
    }
    final details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'study_reminders',
        'Study reminders',
        channelDescription: 'Daily plans, revision, exams, and evening review',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );
    final saved = <String>[];
    for (final notification in notifications) {
      final when = tz.TZDateTime.from(notification.when, tz.local);
      await _plugin.zonedSchedule(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        scheduledDate: when,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: notification.payload,
      );
      saved.add('${notification.id}');
    }
    await preferences.setStringList(_idsKey, saved);
  }
}

Future<void> initializeNotifications(NotificationScheduler scheduler) async {
  try {
    await scheduler.initialize();
  } on Object catch (error, stackTrace) {
    AppLogger.error(
      'Notification plugin failed to initialize',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
