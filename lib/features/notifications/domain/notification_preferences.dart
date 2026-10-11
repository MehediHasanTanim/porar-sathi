/// Local reminder choices. Scheduling stays off until the student opts in
/// after a study plan exists.
final class NotificationPreferences {
  const NotificationPreferences({
    required this.remindersEnabled,
    required this.dailyPlan,
    required this.dailyMinutes,
    required this.revision,
    required this.revisionMinutes,
    required this.examCountdown,
    required this.examThresholds,
    required this.missedTask,
    required this.missedMinutes,
    required this.eveningReview,
    required this.eveningMinutes,
    required this.studySession,
  });

  static const examCountdownDays = [30, 14, 7, 3, 1];

  factory NotificationPreferences.defaults() {
    return const NotificationPreferences(
      remindersEnabled: false,
      dailyPlan: true,
      dailyMinutes: 8 * 60,
      revision: true,
      revisionMinutes: 9 * 60,
      examCountdown: true,
      examThresholds: {30, 14, 7, 3, 1},
      missedTask: false,
      missedMinutes: 18 * 60,
      eveningReview: false,
      eveningMinutes: 21 * 60,
      studySession: false,
    );
  }

  final bool remindersEnabled;
  final bool dailyPlan;
  final int dailyMinutes;
  final bool revision;
  final int revisionMinutes;
  final bool examCountdown;
  final Set<int> examThresholds;
  final bool missedTask;
  final int missedMinutes;
  final bool eveningReview;
  final int eveningMinutes;
  final bool studySession;

  NotificationPreferences normalized() {
    return NotificationPreferences(
      remindersEnabled: remindersEnabled,
      dailyPlan: dailyPlan,
      dailyMinutes: _minutes(dailyMinutes),
      revision: revision,
      revisionMinutes: _minutes(revisionMinutes),
      examCountdown: examCountdown,
      examThresholds: {
        for (final day in examThresholds)
          if (examCountdownDays.contains(day)) day,
      },
      missedTask: missedTask,
      missedMinutes: _minutes(missedMinutes),
      eveningReview: eveningReview,
      eveningMinutes: _minutes(eveningMinutes),
      studySession: studySession,
    );
  }

  NotificationPreferences copyWith({
    bool? remindersEnabled,
    bool? dailyPlan,
    int? dailyMinutes,
    bool? revision,
    int? revisionMinutes,
    bool? examCountdown,
    Set<int>? examThresholds,
    bool? missedTask,
    int? missedMinutes,
    bool? eveningReview,
    int? eveningMinutes,
    bool? studySession,
  }) {
    return NotificationPreferences(
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      dailyPlan: dailyPlan ?? this.dailyPlan,
      dailyMinutes: dailyMinutes ?? this.dailyMinutes,
      revision: revision ?? this.revision,
      revisionMinutes: revisionMinutes ?? this.revisionMinutes,
      examCountdown: examCountdown ?? this.examCountdown,
      examThresholds: examThresholds ?? this.examThresholds,
      missedTask: missedTask ?? this.missedTask,
      missedMinutes: missedMinutes ?? this.missedMinutes,
      eveningReview: eveningReview ?? this.eveningReview,
      eveningMinutes: eveningMinutes ?? this.eveningMinutes,
      studySession: studySession ?? this.studySession,
    );
  }

  static int _minutes(int value) => value.clamp(0, (24 * 60) - 1);
}
