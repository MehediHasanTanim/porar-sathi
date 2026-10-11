import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/time/fake_clock.dart';
import 'package:porar_sathi/features/sessions/domain/study_timer.dart';

void main() {
  test('pause and resume keep elapsed time across a restart', () {
    final clock = FakeClock(DateTime(2026, 10, 11, 9));
    var timer = ActiveStudyTimer(
      id: 'session',
      subjectId: 'physics',
      subjectName: 'Physics',
      title: 'Motion',
      plannedMinutes: 45,
      startedAt: clock.now(),
      elapsedBeforeResume: 0,
      phase: TimerPhase.running,
    );

    clock.elapse(const Duration(minutes: 10, seconds: 5));
    expect(timer.elapsedSeconds(clock.now()), 605);

    timer = timer.pause(clock.now());
    clock.elapse(const Duration(minutes: 3));
    expect(timer.phase, TimerPhase.paused);
    expect(timer.elapsedSeconds(clock.now()), 605);

    timer = timer.resume(clock.now());
    clock.elapse(const Duration(seconds: 55));
    expect(timer.elapsedSeconds(clock.now()), 660);
    expect(timer.elapsedMinutes(clock.now()), 11);

    final recovered = ActiveStudyTimer.fromJson(jsonEncode(timer.toJson()));
    expect(recovered, isNotNull);
    expect(recovered!.elapsedSeconds(clock.now()), 660);
    expect(recovered.phase, TimerPhase.running);
    expect(recovered.subjectName, 'Physics');
  });

  test('corrupt timer json is ignored', () {
    expect(ActiveStudyTimer.fromJson('not-json'), isNull);
  });
}
