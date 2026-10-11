/// Splits [minutes] into sessions no longer than [maxSession].
///
/// A remainder shorter than [minSession] is merged into the previous session.
List<int> splitSessions({
  required int minutes,
  required int maxSession,
  required int minSession,
}) {
  if (minutes <= 0 || maxSession <= 0) {
    return const [];
  }
  if (minutes <= maxSession) {
    return [minutes];
  }
  final sessions = <int>[];
  var remaining = minutes;
  while (remaining > maxSession) {
    sessions.add(maxSession);
    remaining -= maxSession;
  }
  if (remaining <= 0) {
    return sessions;
  }
  if (remaining < minSession && sessions.isNotEmpty) {
    sessions[sessions.length - 1] = sessions.last + remaining;
    return sessions;
  }
  sessions.add(remaining);
  return sessions;
}
