import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/planner/domain/planning_days.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/planner/domain/priority_score.dart';
import 'package:porar_sathi/features/planner/domain/remaining_work.dart';
import 'package:porar_sathi/features/planner/domain/session_splitter.dart';

final class ScoredWork {
  const ScoredWork({required this.work, required this.score});

  final RemainingChapter work;
  final ScoreExplanation score;
}

final class Placement {
  const Placement({
    required this.work,
    required this.score,
    required this.date,
    required this.minutes,
    required this.order,
  });

  final RemainingChapter work;
  final ScoreExplanation score;
  final DateTime date;
  final int minutes;
  final int order;
}

final class UnscheduledSlice {
  const UnscheduledSlice({
    required this.work,
    required this.minutes,
  });

  final RemainingChapter work;
  final int minutes;
}

final class Allocation {
  const Allocation({required this.placements, required this.unscheduled});

  final List<Placement> placements;
  final List<UnscheduledSlice> unscheduled;
}

final class _Piece {
  const _Piece({required this.work, required this.score, required this.minutes});

  final ScoredWork work;
  final ScoreExplanation score;
  final int minutes;

  _Piece copy(int minutes) => _Piece(work: work, score: score, minutes: minutes);
}

/// Places higher scores first. Balance limits yield when no other subject
/// can use the day, or when exam crunch / a very near exam overrides them.
Allocation allocateTasks({
  required PlanningInput input,
  required List<PlanningDay> days,
  required List<ScoredWork> scored,
}) {
  final ordered = [...scored]..sort(_byScore);
  final pieces = <_Piece>[];
  for (final item in ordered) {
    final sessions = splitSessions(
      minutes: item.work.remainingMinutes,
      maxSession: input.plan.maxSessionMinutes,
      minSession: input.config.minSessionMinutes,
    );
    for (final minutes in sessions) {
      pieces.add(_Piece(work: item, score: item.score, minutes: minutes));
    }
  }

  final placements = <Placement>[];
  var order = 0;
  final deferred = <_Piece>[];
  for (var index = 0; index < pieces.length; index++) {
    final piece = pieces[index];
    final later = [...pieces.skip(index + 1), ...deferred];
    final placed = _place(
      input: input,
      days: days,
      piece: piece,
      strict: true,
      alternatives: _hasAlternative(later, piece),
    );
    if (placed == null) {
      deferred.add(piece);
      continue;
    }
    placements.add(placed.copyOrder(order));
    order += 1;
    if (placed.minutes < piece.minutes) {
      deferred.add(piece.copy(piece.minutes - placed.minutes));
    }
  }

  final unscheduled = <UnscheduledSlice>[];
  var open = deferred;
  while (open.isNotEmpty) {
    final next = <_Piece>[];
    var progress = false;
    for (final piece in open) {
      final placed = _place(
        input: input,
        days: days,
        piece: piece,
        strict: false,
        alternatives: false,
      );
      if (placed == null) {
        next.add(piece);
        continue;
      }
      progress = true;
      placements.add(placed.copyOrder(order));
      order += 1;
      if (placed.minutes < piece.minutes) {
        next.add(piece.copy(piece.minutes - placed.minutes));
      }
    }
    if (!progress) {
      for (final piece in next) {
        unscheduled.add(UnscheduledSlice(work: piece.work.work, minutes: piece.minutes));
      }
      break;
    }
    open = next;
  }

  return Allocation(placements: placements, unscheduled: unscheduled);
}

int _byScore(ScoredWork a, ScoredWork b) {
  final score = b.score.total.compareTo(a.score.total);
  if (score != 0) {
    return score;
  }
  final subject = a.work.subject.sortOrder.compareTo(b.work.subject.sortOrder);
  if (subject != 0) {
    return subject;
  }
  final chapter = a.work.chapter.sortOrder.compareTo(b.work.chapter.sortOrder);
  if (chapter != 0) {
    return chapter;
  }
  return a.work.chapter.id.compareTo(b.work.chapter.id);
}

bool _hasAlternative(List<_Piece> later, _Piece current) {
  final subjectId = current.work.work.subject.id;
  for (final piece in later) {
    if (piece.work.work.subject.id != subjectId) {
      return true;
    }
  }
  return false;
}

Placement? _place({
  required PlanningInput input,
  required List<PlanningDay> days,
  required _Piece piece,
  required bool strict,
  required bool alternatives,
}) {
  final preferred = _earliest(
    input: input,
    days: days,
    piece: piece,
    strict: strict,
    alternatives: alternatives,
    onlyBeforeBuffer: true,
  );
  final chosen = preferred ??
      _earliest(
        input: input,
        days: days,
        piece: piece,
        strict: strict,
        alternatives: alternatives,
        onlyBeforeBuffer: false,
      );
  if (chosen == null) {
    return null;
  }
  final day = chosen.$1;
  final minutes = chosen.$2;
  final subjectId = piece.work.work.subject.id;
  day.used += minutes;
  day.subjectMinutes[subjectId] = (day.subjectMinutes[subjectId] ?? 0) + minutes;
  if (day.lastSubjectId == subjectId) {
    day.consecutiveSame += 1;
  } else {
    day.lastSubjectId = subjectId;
    day.consecutiveSame = 1;
  }
  return Placement(
    work: piece.work.work,
    score: piece.score,
    date: day.capacity.date,
    minutes: minutes,
    order: 0,
  );
}

(PlanningDay, int)? _earliest({
  required PlanningInput input,
  required List<PlanningDay> days,
  required _Piece piece,
  required bool strict,
  required bool alternatives,
  required bool onlyBeforeBuffer,
}) {
  final work = piece.work.work;
  final deadline = work.deadline;
  final bufferCut = deadline?.subtract(
    Duration(days: input.plan.revisionBufferDays),
  );
  final share = _sharePercent(input, work);
  final enforceShare = strict && alternatives && share < 100;
  for (final day in days) {
    final date = day.capacity.date;
    if (deadline != null && !date.isBefore(deadline)) {
      continue;
    }
    if (onlyBeforeBuffer && bufferCut != null && !date.isBefore(bufferCut)) {
      continue;
    }
    if (day.remaining <= 0) {
      continue;
    }
    if (strict &&
        alternatives &&
        day.lastSubjectId == work.subject.id &&
        day.consecutiveSame >= 2) {
      continue;
    }
    var room = day.remaining;
    if (enforceShare) {
      final cap = (day.usableMinutes * share / 100).floor();
      final used = day.subjectMinutes[work.subject.id] ?? 0;
      final shareLeft = cap - used;
      if (shareLeft < room) {
        room = shareLeft;
      }
    }
    if (room <= 0) {
      continue;
    }
    final take = piece.minutes <= room ? piece.minutes : room;
    final partial = take < piece.minutes;
    if (partial && take < input.config.minSessionMinutes) {
      continue;
    }
    return (day, take);
  }
  return null;
}

int _sharePercent(PlanningInput input, RemainingChapter work) {
  final exam = work.exam;
  if (exam != null) {
    final days = exam.startDate.difference(input.today).inDays;
    if (days <= input.config.urgencyOverrideDays) {
      return 100;
    }
  }
  return switch (input.plan.planningMode) {
    PlanningMode.examCrunch => 100,
    PlanningMode.weakSubjectFocus => 80,
    _ => input.config.maxDailySharePercent,
  };
}

extension on Placement {
  Placement copyOrder(int order) {
    return Placement(
      work: work,
      score: score,
      date: date,
      minutes: minutes,
      order: order,
    );
  }
}
