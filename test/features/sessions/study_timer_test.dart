import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/fake_clock.dart';
import 'package:porar_sathi/features/sessions/domain/study_completion.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/sessions/domain/study_timer.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

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

  test('process death restores the running timer', () {
    final clock = FakeClock(DateTime(2026, 10, 11, 21));
    final running = ActiveStudyTimer(
      id: 'session',
      subjectId: 'physics',
      subjectName: 'Physics',
      title: 'Motion',
      plannedMinutes: 45,
      startedAt: clock.now(),
      elapsedBeforeResume: 120,
      phase: TimerPhase.running,
    );
    clock.elapse(const Duration(minutes: 4));
    final stored = jsonEncode(running.pause(clock.now()).toJson());
    clock.elapse(const Duration(hours: 2));
    final recovered = ActiveStudyTimer.fromJson(stored);
    expect(recovered!.phase, TimerPhase.paused);
    expect(recovered.elapsedSeconds(clock.now()), 360);
  });

  test('elapsed time continues across midnight', () {
    final start = DateTime(2026, 10, 11, 23, 50);
    final timer = ActiveStudyTimer(
      id: 'session',
      subjectId: 'physics',
      subjectName: 'Physics',
      title: 'Motion',
      plannedMinutes: 45,
      startedAt: start,
      elapsedBeforeResume: 0,
      phase: TimerPhase.running,
    );
    expect(timer.elapsedSeconds(DateTime(2026, 10, 12, 0, 10)), 20 * 60);
  });

  test('a long accidental run keeps the full elapsed time', () {
    final start = DateTime(2026, 10, 11, 9);
    final timer = ActiveStudyTimer(
      id: 'session',
      subjectId: 'physics',
      subjectName: 'Physics',
      title: 'Motion',
      plannedMinutes: 45,
      startedAt: start,
      elapsedBeforeResume: 0,
      phase: TimerPhase.running,
    );
    final later = start.add(const Duration(hours: 8));
    expect(timer.elapsedSeconds(later), 8 * 60 * 60);
    expect(timer.elapsedMinutes(later), 480);
  });

  test('a manual correction stores the edited minutes', () {
    final now = DateTime(2026, 10, 11, 18);
    final chapter = Chapter(
      id: 'chapter',
      subjectId: 'physics',
      title: 'Motion',
      estimatedMinutes: 90,
      completedMinutes: 0,
      difficulty: Difficulty.moderate,
      confidence: Confidence.medium,
      priority: Priority.normal,
      examImportance: Priority.normal,
      status: ChapterStatus.notStarted,
      sortOrder: 0,
      createdAt: now,
      updatedAt: now,
    );
    final completion = applyStudyCompletion(
      session: StudySession(
        id: 'session',
        subjectId: 'physics',
        chapterId: chapter.id,
        startedAt: now.subtract(const Duration(hours: 8)),
        endedAt: now,
        plannedMinutes: 45,
        actualMinutes: 25,
        completionPercent: 30,
        result: SessionResult.partiallyCompleted,
        createdAt: now,
      ),
      chapter: chapter,
      needsRevision: false,
      replanRemaining: false,
      now: now,
      studyPlanId: 'plan',
      followUpTaskId: 'follow',
      revisionId: 'revision',
    );
    expect(completion.session.actualMinutes, 25);
    expect(completion.chapter!.completedMinutes, 25);
  });
}
