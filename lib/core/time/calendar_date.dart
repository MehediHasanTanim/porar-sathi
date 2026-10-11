/// Local calendar date at midnight. Planner dates are stored this way so a
/// timestamp never shifts the day.
DateTime calendarDate(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}
