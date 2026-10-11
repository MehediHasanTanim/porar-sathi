enum ReminderKind {
  dailyPlan,
  revision,
  examCountdown,
  missedTask,
  eveningReview,
  studySession,
}

/// One future local notification. [id] is stable for [key] so a later
/// reconciliation replaces the same reminder instead of stacking another.
final class PlannedNotification {
  PlannedNotification({
    required this.key,
    required this.kind,
    required this.when,
    required this.title,
    required this.body,
    required this.payload,
  }) : id = notificationIdFor(key);

  final String key;
  final int id;
  final ReminderKind kind;
  final DateTime when;
  final String title;
  final String body;
  final String payload;

  @override
  bool operator ==(Object other) {
    return other is PlannedNotification &&
        other.key == key &&
        other.kind == kind &&
        other.when == when &&
        other.title == title &&
        other.body == body &&
        other.payload == payload;
  }

  @override
  int get hashCode => Object.hash(key, kind, when, title, body, payload);
}

/// Pending set after a reconciliation. Ids in [cancel] must not fire.
final class NotificationReconciliation {
  const NotificationReconciliation({
    required this.schedule,
    required this.cancel,
  });

  final List<PlannedNotification> schedule;
  final List<int> cancel;
}

NotificationReconciliation reconcileSchedule({
  required Set<int> previousIds,
  required List<PlannedNotification> next,
}) {
  final nextIds = next.map((item) => item.id).toSet();
  final cancel = [
    for (final id in previousIds)
      if (!nextIds.contains(id)) id,
  ]..sort();
  return NotificationReconciliation(schedule: next, cancel: cancel);
}

int notificationIdFor(String key) {
  var hash = 2166136261;
  for (final unit in key.codeUnits) {
    hash ^= unit;
    hash = (hash * 16777619) & 0x7fffffff;
  }
  if (hash == 0) {
    return 1;
  }
  return hash;
}
