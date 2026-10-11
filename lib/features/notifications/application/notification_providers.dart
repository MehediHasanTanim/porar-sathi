import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/core/notifications/notification_scheduler.dart';
import 'package:porar_sathi/features/notifications/data/notification_preferences_store.dart';
import 'package:porar_sathi/features/notifications/domain/notification_preferences.dart';

final notificationSchedulerProvider = Provider<NotificationScheduler>(
  (ref) => LocalNotificationScheduler(),
);

final notificationPreferencesProvider =
    AsyncNotifierProvider<
      NotificationPreferencesController,
      NotificationPreferences
    >(NotificationPreferencesController.new);

class NotificationPreferencesController
    extends AsyncNotifier<NotificationPreferences> {
  @override
  Future<NotificationPreferences> build() async {
    final preferences = await SharedPreferences.getInstance();
    return NotificationPreferencesStore(preferences).load();
  }

  Future<void> save(NotificationPreferences preferences) async {
    final store = NotificationPreferencesStore(
      await SharedPreferences.getInstance(),
    );
    final value = preferences.normalized();
    await store.save(value);
    state = AsyncData(value);
  }
}
