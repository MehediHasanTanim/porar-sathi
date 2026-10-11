import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Loads the timezone database and picks a local zone from the device offset.
/// Bangladesh (+06:00) falls back to Asia/Dhaka when no match is found.
void configureLocalTimeZone() {
  tz_data.initializeTimeZones();
  final offset = DateTime.now().timeZoneOffset;
  tz.Location? match;
  for (final location in tz.timeZoneDatabase.locations.values) {
    if (location.currentTimeZone.offset == offset) {
      match = location;
      break;
    }
  }
  tz.setLocalLocation(match ?? tz.getLocation('Asia/Dhaka'));
}
