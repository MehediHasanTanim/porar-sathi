import 'package:flutter/widgets.dart';

import 'package:porar_sathi/features/notifications/domain/plan_reminders.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

ReminderMessages reminderMessages(AppLocalizations l10n, Locale locale) {
  String digits(int value) => reminderDigits(value, locale);
  String duration(int minutes) => reminderDuration(minutes, l10n, locale);
  return ReminderMessages(
    dailyTitle: l10n.dailyReminderTitle,
    dailyBody: (count, minutes) =>
        l10n.dailyReminderBody(digits(count), duration(minutes)),
    revisionTitle: l10n.revisionReminderTitle,
    revisionBody: l10n.revisionReminderBody,
    examTitle: l10n.examReminderTitle,
    examBody: (name, days) => l10n.examReminderBody(name, digits(days)),
    missedTitle: l10n.missedReminderTitle,
    missedBody: (count) => l10n.missedReminderBody(digits(count)),
    eveningTitle: l10n.eveningReminderTitle,
    eveningBody: (completed, remaining) =>
        l10n.eveningReminderBody(digits(completed), digits(remaining)),
    sessionTitle: l10n.sessionReminderTitle,
    sessionBody: l10n.sessionReminderBody,
  );
}

String reminderDigits(int value, Locale locale) {
  final text = '$value';
  if (locale.languageCode != 'bn') {
    return text;
  }
  const digits = '০১২৩৪৫৬৭৮৯';
  return text.split('').map((char) => digits[int.parse(char)]).join();
}

String reminderDuration(int minutes, AppLocalizations l10n, Locale locale) {
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  String digits(int value) => reminderDigits(value, locale);
  if (hours == 0) {
    return l10n.reminderDurationMinutes(digits(rest));
  }
  if (rest == 0) {
    return l10n.reminderDurationHours(digits(hours));
  }
  return l10n.reminderDurationHoursMinutes(digits(hours), digits(rest));
}
