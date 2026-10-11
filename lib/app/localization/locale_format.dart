import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:porar_sathi/l10n/app_localizations.dart';

abstract final class LocaleFormat {
  static String formatDate(DateTime date, Locale locale) {
    return DateFormat('EEEE, d MMMM', locale.toString()).format(date);
  }

  static String formatNumber(num value, Locale locale) {
    return NumberFormat.decimalPattern(locale.toString()).format(value);
  }

  static String formatDuration(int minutes, AppLocalizations l10n) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours == 0) {
      return l10n.durationMinutes(remainder);
    }
    if (remainder == 0) {
      return l10n.durationHours(hours);
    }
    return l10n.durationHoursMinutes(hours, remainder);
  }

  static String greeting(DateTime now, AppLocalizations l10n) {
    final hour = now.hour;
    if (hour < 12) {
      return l10n.goodMorning;
    }
    if (hour < 17) {
      return l10n.goodAfternoon;
    }
    if (hour < 21) {
      return l10n.goodEvening;
    }
    return l10n.goodNight;
  }
}
