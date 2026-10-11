import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/notifications/domain/notification_preferences.dart';
import 'package:porar_sathi/features/notifications/domain/planned_notification.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';

/// Copy is injected so this planner stays free of widgets and of `DateTime.now`.
final class ReminderMessages {
  const ReminderMessages({
    required this.dailyTitle,
    required this.dailyBody,
    required this.revisionTitle,
    required this.revisionBody,
    required this.examTitle,
    required this.examBody,
    required this.missedTitle,
    required this.missedBody,
    required this.eveningTitle,
    required this.eveningBody,
    required this.sessionTitle,
    required this.sessionBody,
  });

  final String dailyTitle;
  final String Function(int count, int minutes) dailyBody;
  final String revisionTitle;
  final String revisionBody;
  final String examTitle;
  final String Function(String name, int days) examBody;
  final String missedTitle;
  final String Function(int count) missedBody;
  final String eveningTitle;
  final String Function(int completed, int remaining) eveningBody;
  final String sessionTitle;
  final String Function(String title) sessionBody;
}

const dailyReminderHorizon = 7;

/// Routes match `AppRoutes`. Kept here so the planner does not import the router.
abstract final class ReminderPayload {
  static const today = '/today';

  static String revision(String id) => '/revisions/$id';

  static String exam(String id) => '/exams/$id';

  static String task(String id) => '/tasks/$id';
}

List<PlannedNotification> planReminders({
  required DateTime now,
  required NotificationPreferences preferences,
  required bool permitted,
  required List<StudyTask> tasks,
  required List<RevisionSchedule> revisions,
  required List<Exam> exams,
  required ReminderMessages messages,
}) {
  if (!permitted || !preferences.remindersEnabled) {
    return const [];
  }
  final settings = preferences.normalized();
  final planned =
      <PlannedNotification>[
        if (settings.dailyPlan)
          ..._dailyPlans(
            now: now,
            tasks: tasks,
            minutes: settings.dailyMinutes,
            messages: messages,
          ),
        if (settings.revision)
          ..._revisions(
            now: now,
            revisions: revisions,
            minutes: settings.revisionMinutes,
            messages: messages,
          ),
        if (settings.examCountdown)
          ..._exams(
            now: now,
            exams: exams,
            minutes: settings.dailyMinutes,
            thresholds: settings.examThresholds,
            messages: messages,
          ),
        if (settings.missedTask)
          ..._missed(
            now: now,
            tasks: tasks,
            minutes: settings.missedMinutes,
            messages: messages,
          ),
        if (settings.eveningReview)
          ..._evening(
            now: now,
            tasks: tasks,
            minutes: settings.eveningMinutes,
            messages: messages,
          ),
        if (settings.studySession)
          ..._sessions(now: now, tasks: tasks, messages: messages),
      ]..sort((a, b) {
        final byTime = a.when.compareTo(b.when);
        if (byTime != 0) {
          return byTime;
        }
        return a.key.compareTo(b.key);
      });
  return planned;
}

List<PlannedNotification> _dailyPlans({
  required DateTime now,
  required List<StudyTask> tasks,
  required int minutes,
  required ReminderMessages messages,
}) {
  final today = calendarDate(now);
  final planned = <PlannedNotification>[];
  for (var offset = 0; offset < dailyReminderHorizon; offset++) {
    final day = today.add(Duration(days: offset));
    final dayTasks = [
      for (final task in tasks)
        if (_sameDay(task.plannedDate, day) && _countsTowardPlan(task)) task,
    ];
    if (dayTasks.isEmpty) {
      continue;
    }
    final when = _atMinutes(day, minutes);
    if (!when.isAfter(now)) {
      continue;
    }
    final total = dayTasks.fold<int>(
      0,
      (sum, task) => sum + task.plannedMinutes,
    );
    final key = 'daily:${_dayKey(day)}';
    planned.add(
      PlannedNotification(
        key: key,
        kind: ReminderKind.dailyPlan,
        when: when,
        title: messages.dailyTitle,
        body: messages.dailyBody(dayTasks.length, total),
        payload: ReminderPayload.today,
      ),
    );
  }
  return planned;
}

List<PlannedNotification> _revisions({
  required DateTime now,
  required List<RevisionSchedule> revisions,
  required int minutes,
  required ReminderMessages messages,
}) {
  final planned = <PlannedNotification>[];
  for (final revision in revisions) {
    if (!_revisionOpen(revision.status)) {
      continue;
    }
    final when = _atMinutes(revision.dueDate, minutes);
    if (!when.isAfter(now)) {
      continue;
    }
    planned.add(
      PlannedNotification(
        key: 'revision:${revision.id}',
        kind: ReminderKind.revision,
        when: when,
        title: messages.revisionTitle,
        body: messages.revisionBody,
        payload: ReminderPayload.revision(revision.id),
      ),
    );
  }
  return planned;
}

List<PlannedNotification> _exams({
  required DateTime now,
  required List<Exam> exams,
  required int minutes,
  required Set<int> thresholds,
  required ReminderMessages messages,
}) {
  final planned = <PlannedNotification>[];
  final days = [...thresholds]..sort((a, b) => b.compareTo(a));
  for (final exam in exams) {
    for (final threshold in days) {
      if (!NotificationPreferences.examCountdownDays.contains(threshold)) {
        continue;
      }
      final day = calendarDate(exam.startDate)
          .subtract(Duration(days: threshold));
      final when = _atMinutes(day, minutes);
      if (!when.isAfter(now)) {
        continue;
      }
      planned.add(
        PlannedNotification(
          key: 'exam:${exam.id}:$threshold',
          kind: ReminderKind.examCountdown,
          when: when,
          title: messages.examTitle,
          body: messages.examBody(exam.name, threshold),
          payload: ReminderPayload.exam(exam.id),
        ),
      );
    }
  }
  return planned;
}

List<PlannedNotification> _missed({
  required DateTime now,
  required List<StudyTask> tasks,
  required int minutes,
  required ReminderMessages messages,
}) {
  final today = calendarDate(now);
  final open = [
    for (final task in tasks)
      if (_sameDay(task.plannedDate, today) && _incomplete(task.status)) task,
  ];
  if (open.isEmpty) {
    return const [];
  }
  final when = _atMinutes(today, minutes);
  if (!when.isAfter(now)) {
    return const [];
  }
  return [
    PlannedNotification(
      key: 'missed:${_dayKey(today)}',
      kind: ReminderKind.missedTask,
      when: when,
      title: messages.missedTitle,
      body: messages.missedBody(open.length),
      payload: ReminderPayload.today,
    ),
  ];
}

List<PlannedNotification> _evening({
  required DateTime now,
  required List<StudyTask> tasks,
  required int minutes,
  required ReminderMessages messages,
}) {
  final today = calendarDate(now);
  final when = _atMinutes(today, minutes);
  if (!when.isAfter(now)) {
    return const [];
  }
  final todays = [
    for (final task in tasks)
      if (_sameDay(task.plannedDate, today) && _countsTowardPlan(task)) task,
  ];
  final completed = todays
      .where((task) => task.status == TaskStatus.completed)
      .length;
  final remaining = todays.where((task) => _incomplete(task.status)).length;
  return [
    PlannedNotification(
      key: 'evening:${_dayKey(today)}',
      kind: ReminderKind.eveningReview,
      when: when,
      title: messages.eveningTitle,
      body: messages.eveningBody(completed, remaining),
      payload: ReminderPayload.today,
    ),
  ];
}

List<PlannedNotification> _sessions({
  required DateTime now,
  required List<StudyTask> tasks,
  required ReminderMessages messages,
}) {
  final today = calendarDate(now);
  final horizon = today.add(const Duration(days: dailyReminderHorizon));
  final planned = <PlannedNotification>[];
  for (final task in tasks) {
    final start = task.plannedStartTime;
    if (start == null || !_incomplete(task.status)) {
      continue;
    }
    final day = calendarDate(task.plannedDate);
    if (day.isBefore(today) || !day.isBefore(horizon)) {
      continue;
    }
    final when = _atMinutes(day, start);
    if (!when.isAfter(now)) {
      continue;
    }
    planned.add(
      PlannedNotification(
        key: 'session:${task.id}',
        kind: ReminderKind.studySession,
        when: when,
        title: messages.sessionTitle,
        body: messages.sessionBody(task.title),
        payload: ReminderPayload.task(task.id),
      ),
    );
  }
  return planned;
}

bool _countsTowardPlan(StudyTask task) {
  return task.status != TaskStatus.cancelled &&
      task.status != TaskStatus.skipped;
}

bool _incomplete(TaskStatus status) {
  return status == TaskStatus.planned ||
      status == TaskStatus.inProgress ||
      status == TaskStatus.partiallyCompleted ||
      status == TaskStatus.missed;
}

bool _revisionOpen(RevisionStatus status) {
  return status == RevisionStatus.pending ||
      status == RevisionStatus.scheduled ||
      status == RevisionStatus.overdue;
}

bool _sameDay(DateTime a, DateTime b) {
  final left = calendarDate(a);
  final right = calendarDate(b);
  return left == right;
}

DateTime _atMinutes(DateTime day, int minutes) {
  final date = calendarDate(day);
  final clamped = minutes.clamp(0, (24 * 60) - 1);
  return DateTime(date.year, date.month, date.day, clamped ~/ 60, clamped % 60);
}

String _dayKey(DateTime day) {
  final date = calendarDate(day);
  final month = date.month.toString().padLeft(2, '0');
  final value = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$value';
}
