import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/notifications/application/reminder_copy.dart';
import 'package:porar_sathi/features/notifications/data/notification_preferences_store.dart';
import 'package:porar_sathi/features/notifications/domain/notification_preferences.dart';
import 'package:porar_sathi/features/notifications/domain/plan_reminders.dart';
import 'package:porar_sathi/features/notifications/domain/planned_notification.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final now = DateTime(2026, 10, 11, 7);
  final today = DateTime(2026, 10, 11);

  test('daily reminder uses the Bangla plan sentence', () async {
    final l10n = await AppLocalizations.delegate.load(const Locale('bn'));
    final messages = reminderMessages(l10n, const Locale('bn'));
    final planned = planReminders(
      now: now,
      preferences: _enabled(),
      permitted: true,
      tasks: [
        _task(id: 'a', minutes: 60),
        _task(id: 'b', minutes: 40),
        _task(id: 'c', minutes: 40),
      ],
      revisions: const [],
      exams: const [],
      messages: messages,
    );
    final daily = planned
        .where((item) => item.kind == ReminderKind.dailyPlan)
        .single;
    expect(daily.when, DateTime(2026, 10, 11, 8));
    expect(daily.body, 'আজ ৩টি পড়ার কাজ আছে — মোট ২ ঘণ্টা ২০ মিনিট।');
    expect(daily.payload, ReminderPayload.today);
  });

  test('a later clock drops today and keeps the next daily reminder', () {
    final tomorrow = _task(
      id: 'tomorrow',
      day: today.add(const Duration(days: 1)),
    );
    final before = _daily(
      now: now,
      tasks: [
        _task(id: 'today'),
        tomorrow,
      ],
    );
    final after = _daily(
      now: DateTime(2026, 10, 11, 8, 1),
      tasks: [
        _task(id: 'today'),
        tomorrow,
      ],
    );
    expect(before.map((item) => item.when.day).toList(), [11, 12]);
    expect(after.single.when, DateTime(2026, 10, 12, 8));
    expect(after.single.id, before.last.id);
  });

  test(
    'completing a revision cancels it and rescheduling keeps the same id',
    () {
      final open = _revision(
        id: 'rev-1',
        due: today.add(const Duration(days: 1)),
      );
      final scheduled = _revisions(now: now, revisions: [open]).single;
      final completed = _revisions(
        now: now,
        revisions: [
          open.copyWith(status: RevisionStatus.completed, completedAt: now),
        ],
      );
      final moved = _revisions(
        now: now,
        revisions: [open.copyWith(dueDate: today.add(const Duration(days: 5)))],
      ).single;
      expect(completed, isEmpty);
      expect(moved.id, scheduled.id);
      expect(moved.when, DateTime(2026, 10, 16, 9));
      final diff = reconcileSchedule(
        previousIds: {scheduled.id},
        next: completed,
      );
      expect(diff.cancel, [scheduled.id]);
      expect(diff.schedule, isEmpty);
    },
  );

  test('exam countdown keeps only future configured thresholds', () {
    final exam = _exam(start: today.add(const Duration(days: 10)));
    final all = _exams(now: now, exams: [exam], thresholds: {30, 14, 7, 3, 1});
    expect(all.map((item) => item.body).toList(), [
      'Physics is in 7 days.',
      'Physics is in 3 days.',
      'Physics is in 1 days.',
    ]);
    final onlySeven = _exams(now: now, exams: [exam], thresholds: {7});
    expect(onlySeven.single.when, DateTime(2026, 10, 14, 8));
    expect(onlySeven.single.payload, '/exams/exam-1');
  });

  test('missed work is one reminder and is not repeated after its time', () {
    final tasks = [
      _task(id: 'a'),
      _task(id: 'b', status: TaskStatus.inProgress),
      _task(id: 'c', status: TaskStatus.completed),
    ];
    final once =
        _with(
          now: DateTime(2026, 10, 11, 17),
          preferences: _enabled().copyWith(
            missedTask: true,
            eveningReview: true,
          ),
          tasks: tasks,
        ).where(
          (item) =>
              item.kind == ReminderKind.missedTask ||
              item.kind == ReminderKind.eveningReview,
        );
    expect(once.map((item) => item.kind).toList(), [
      ReminderKind.missedTask,
      ReminderKind.eveningReview,
    ]);
    expect(once.first.body, '2 tasks are still open today.');
    expect(once.last.body, '1 finished, 2 still open.');
    expect(once.last.payload, ReminderPayload.today);
    final later = _with(
      now: DateTime(2026, 10, 11, 21, 5),
      preferences: _enabled().copyWith(missedTask: true, eveningReview: true),
      tasks: tasks,
    );
    expect(
      later.where(
        (item) =>
            item.kind == ReminderKind.missedTask ||
            item.kind == ReminderKind.eveningReview,
      ),
      isEmpty,
    );
  });

  test('permission denied schedules nothing', () {
    expect(
      planReminders(
        now: now,
        preferences: _enabled(),
        permitted: false,
        tasks: [_task(id: 'a')],
        revisions: const [],
        exams: const [],
        messages: _english(),
      ),
      isEmpty,
    );
  });

  test('permission granted schedules the daily reminder', () {
    final planned = planReminders(
      now: now,
      preferences: _enabled(),
      permitted: true,
      tasks: [_task(id: 'a', minutes: 45)],
      revisions: const [],
      exams: const [],
      messages: _english(),
    );
    final daily = planned.where((item) => item.kind == ReminderKind.dailyPlan);
    expect(daily.single.when, DateTime(2026, 10, 11, 8));
    expect(daily.single.body, contains('45 minutes'));
  });

  test('changing the exam date moves the countdown', () {
    final thresholds = {30, 14, 7, 3, 1};
    final near = _exams(
      now: now,
      exams: [_exam(start: today.add(const Duration(days: 10)))],
      thresholds: thresholds,
    );
    final later = _exams(
      now: now,
      exams: [_exam(start: today.add(const Duration(days: 40)))],
      thresholds: thresholds,
    );
    expect(near.map((item) => item.body).toList(), [
      'Physics is in 7 days.',
      'Physics is in 3 days.',
      'Physics is in 1 days.',
    ]);
    expect(later.map((item) => item.when.day).toList(), [21, 6, 13, 17, 19]);
    expect(later.first.when, DateTime(2026, 10, 21, 8));
    expect(
      near.singleWhere((item) => item.body.contains('7 days')).when.day,
      14,
    );
  });

  test('a timezone shift follows the new local clock', () {
    final tasks = [
      _task(id: 'today'),
      _task(id: 'tomorrow', day: today.add(const Duration(days: 1))),
    ];
    final atHome = _daily(now: DateTime(2026, 10, 11, 7), tasks: tasks);
    final afterTheClockMoves = _daily(
      now: DateTime(2026, 10, 11, 9),
      tasks: tasks,
    );
    expect(atHome.first.when, DateTime(2026, 10, 11, 8));
    expect(afterTheClockMoves.single.when, DateTime(2026, 10, 12, 8));
    expect(afterTheClockMoves.single.id, atHome.last.id);
  });

  test('a changed plan replaces the daily reminder without a new id', () {
    final first = _daily(
      now: now,
      tasks: [
        _task(id: 'a', minutes: 60),
        _task(id: 'b', minutes: 80),
      ],
    ).single;
    final replanned = _daily(
      now: now,
      tasks: [_task(id: 'a', minutes: 30)],
    ).single;
    expect(replanned.id, first.id);
    expect(
      replanned.body,
      'You have 1 study tasks today — 30 minutes in total.',
    );
    expect(first.body, contains('2 study tasks'));
  });

  test(
    'a study session reminder follows the task and drops when it is done',
    () {
      final task = _task(id: 'session-1', start: 10 * 60);
      final open = _with(
        now: now,
        preferences: _enabled().copyWith(studySession: true),
        tasks: [task],
      ).where((item) => item.kind == ReminderKind.studySession).single;
      final done = _with(
        now: now,
        preferences: _enabled().copyWith(studySession: true),
        tasks: [task.copyWith(status: TaskStatus.completed, completedAt: now)],
      ).where((item) => item.kind == ReminderKind.studySession);
      final moved = _with(
        now: now,
        preferences: _enabled().copyWith(studySession: true),
        tasks: [task.copyWith(plannedDate: today.add(const Duration(days: 2)))],
      ).where((item) => item.kind == ReminderKind.studySession).single;
      expect(open.when, DateTime(2026, 10, 11, 10));
      expect(open.payload, '/tasks/session-1');
      expect(done, isEmpty);
      expect(moved.id, open.id);
      expect(moved.when, DateTime(2026, 10, 13, 10));
    },
  );

  test('notification ids stay stable and preferences round-trip', () async {
    expect(
      notificationIdFor('daily:2026-10-11'),
      notificationIdFor('daily:2026-10-11'),
    );
    expect(
      notificationIdFor('daily:2026-10-11'),
      isNot(notificationIdFor('revision:rev-1')),
    );
    SharedPreferences.setMockInitialValues({});
    final store = NotificationPreferencesStore(
      await SharedPreferences.getInstance(),
    );
    await store.save(
      NotificationPreferences.defaults().copyWith(
        remindersEnabled: true,
        dailyMinutes: (7 * 60) + 30,
        examThresholds: {7, 1, 99},
        missedTask: true,
      ),
    );
    final loaded = store.load();
    expect(loaded.remindersEnabled, isTrue);
    expect(loaded.dailyMinutes, 450);
    expect(loaded.examThresholds, {1, 7});
    expect(loaded.missedTask, isTrue);
    expect(loaded.eveningReview, isFalse);
  });
}

NotificationPreferences _enabled() {
  return NotificationPreferences.defaults().copyWith(remindersEnabled: true);
}

ReminderMessages _english() {
  return ReminderMessages(
    dailyTitle: "Today's study",
    dailyBody: (count, minutes) =>
        'You have $count study tasks today — ${_duration(minutes)} in total.',
    revisionTitle: 'Revision is due',
    revisionBody: 'A revision is due today.',
    examTitle: 'Exam coming up',
    examBody: (name, days) => '$name is in $days days.',
    missedTitle: 'Still some study left',
    missedBody: (count) => '$count tasks are still open today.',
    eveningTitle: 'Evening review',
    eveningBody: (completed, remaining) =>
        '$completed finished, $remaining still open.',
    sessionTitle: 'Time to study',
    sessionBody: (title) => title,
  );
}

String _duration(int minutes) {
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) {
    return '$rest minutes';
  }
  if (rest == 0) {
    return '$hours hours';
  }
  return '$hours hours $rest minutes';
}

List<PlannedNotification> _daily({
  required DateTime now,
  required List<StudyTask> tasks,
}) {
  return _with(
    now: now,
    preferences: _enabled(),
    tasks: tasks,
  ).where((item) => item.kind == ReminderKind.dailyPlan).toList();
}

List<PlannedNotification> _revisions({
  required DateTime now,
  required List<RevisionSchedule> revisions,
}) {
  return planReminders(
    now: now,
    preferences: _enabled(),
    permitted: true,
    tasks: const [],
    revisions: revisions,
    exams: const [],
    messages: _english(),
  );
}

List<PlannedNotification> _exams({
  required DateTime now,
  required List<Exam> exams,
  required Set<int> thresholds,
}) {
  return planReminders(
    now: now,
    preferences: _enabled().copyWith(examThresholds: thresholds),
    permitted: true,
    tasks: const [],
    revisions: const [],
    exams: exams,
    messages: _english(),
  );
}

List<PlannedNotification> _with({
  required DateTime now,
  required NotificationPreferences preferences,
  required List<StudyTask> tasks,
}) {
  return planReminders(
    now: now,
    preferences: preferences,
    permitted: true,
    tasks: tasks,
    revisions: const [],
    exams: const [],
    messages: _english(),
  );
}

StudyTask _task({
  required String id,
  int minutes = 45,
  DateTime? day,
  TaskStatus status = TaskStatus.planned,
  int? start,
}) {
  final at = day ?? DateTime(2026, 10, 11);
  return StudyTask(
    id: id,
    studyPlanId: 'plan',
    subjectId: 'physics',
    chapterId: 'motion',
    taskType: TaskType.newStudy,
    title: 'Motion',
    plannedDate: at,
    plannedStartTime: start,
    plannedMinutes: minutes,
    priorityScore: 0,
    isLocked: false,
    status: status,
    completionPercent: status == TaskStatus.completed ? 100 : 0,
    source: TaskSource.autoPlanner,
    createdAt: at,
    updatedAt: at,
    completedAt: status == TaskStatus.completed ? at : null,
  );
}

RevisionSchedule _revision({required String id, required DateTime due}) {
  return RevisionSchedule(
    id: id,
    studyPlanId: 'plan',
    chapterId: 'motion',
    revisionNumber: 1,
    dueDate: due,
    estimatedMinutes: 20,
    status: RevisionStatus.scheduled,
    createdAt: DateTime(2026, 10, 11),
  );
}

Exam _exam({required DateTime start}) {
  final at = DateTime(2026, 10, 11);
  return Exam(
    id: 'exam-1',
    studyPlanId: 'plan',
    name: 'Physics',
    examType: ExamType.board,
    startDate: start,
    importance: Priority.high,
    createdAt: at,
    updatedAt: at,
  );
}
