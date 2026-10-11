import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/time/clock.dart';
import 'package:porar_sathi/core/time/fake_clock.dart';
import 'package:porar_sathi/features/planner/domain/study_planner.dart';

void main() {
  test('today drops the time of day', () {
    final clock = FakeClock(DateTime(2026, 10, 9, 22, 15));
    expect(clock.today(), DateTime(2026, 10, 9));
  });

  test('system clock today is midnight local', () {
    final today = const SystemClock().today();
    expect(today.hour, 0);
    expect(today.minute, 0);
    expect(today.second, 0);
  });

  test('planner today comes from the clock', () {
    final clock = FakeClock(DateTime(2026, 10, 11, 21, 5));
    final planner = PendingStudyPlanner(clock);
    expect(planner.today(), DateTime(2026, 10, 11));
    clock.elapse(const Duration(hours: 4));
    expect(planner.today(), DateTime(2026, 10, 12));
  });

  test('planner source does not call DateTime.now', () {
    final files = Directory('lib/features/planner')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    expect(files, isNotEmpty);
    for (final file in files) {
      expect(
        file.readAsStringSync(),
        isNot(contains('DateTime.now')),
        reason: file.path,
      );
    }
  });
}
