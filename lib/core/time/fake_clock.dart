import 'package:porar_sathi/core/time/clock.dart';

/// Fixed clock for planner tests. Move it with [elapse] instead of waiting.
final class FakeClock implements Clock {
  FakeClock(DateTime now) : _now = now;

  DateTime _now;

  void elapse(Duration duration) {
    _now = _now.add(duration);
  }

  @override
  DateTime now() => _now;

  @override
  DateTime today() {
    final current = now();
    return DateTime(current.year, current.month, current.day);
  }
}
