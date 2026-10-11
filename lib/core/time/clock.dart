/// Time source for planning and tests. Domain code must not call
/// [DateTime.now] directly.
abstract interface class Clock {
  DateTime now();

  /// Local calendar date at midnight.
  DateTime today();
}

final class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();

  @override
  DateTime today() {
    final current = now();
    return DateTime(current.year, current.month, current.day);
  }
}
