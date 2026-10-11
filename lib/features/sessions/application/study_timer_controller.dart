import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/sessions/data/active_session_store_provider.dart';
import 'package:porar_sathi/features/sessions/domain/study_timer.dart';

part 'study_timer_controller.g.dart';

@Riverpod(keepAlive: true)
class StudyTimerController extends _$StudyTimerController {
  @override
  Future<ActiveStudyTimer?> build() async {
    return (await ref.watch(activeSessionStoreProvider.future)).load();
  }

  Future<ActiveStudyTimer> start(ActiveStudyTimer timer) {
    final running = ActiveStudyTimer(
      id: timer.id,
      taskId: timer.taskId,
      subjectId: timer.subjectId,
      chapterId: timer.chapterId,
      subjectName: timer.subjectName,
      title: timer.title,
      examName: timer.examName,
      plannedMinutes: timer.plannedMinutes,
      startedAt: ref.read(clockProvider).now(),
      elapsedBeforeResume: 0,
      phase: TimerPhase.running,
      quickStudy: timer.quickStudy,
    );
    return _save(running);
  }

  Future<void> pause() async {
    final current = await future;
    if (current == null) {
      return;
    }
    await _save(current.pause(ref.read(clockProvider).now()));
  }

  Future<void> resume() async {
    final current = await future;
    if (current == null) {
      return;
    }
    await _save(current.resume(ref.read(clockProvider).now()));
  }

  Future<ActiveStudyTimer?> finish() async {
    final current = await future;
    if (current == null) {
      return null;
    }
    return _save(current.finish(ref.read(clockProvider).now()));
  }

  Future<void> clear() async {
    await (await ref.read(activeSessionStoreProvider.future)).clear();
    state = const AsyncData(null);
  }

  Future<ActiveStudyTimer> _save(ActiveStudyTimer timer) async {
    final store = await ref.read(activeSessionStoreProvider.future);
    await store.save(timer);
    state = AsyncData(timer);
    return timer;
  }
}
