import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/features/sessions/domain/study_timer.dart';

abstract interface class ActiveSessionStore {
  Future<ActiveStudyTimer?> load();

  Future<void> save(ActiveStudyTimer timer);

  Future<void> clear();
}

final class SharedPreferencesActiveSessionStore implements ActiveSessionStore {
  SharedPreferencesActiveSessionStore(this._preferences);

  final SharedPreferences _preferences;

  static const key = 'active_study_timer';

  @override
  Future<ActiveStudyTimer?> load() async {
    final raw = _preferences.getString(key);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      return ActiveStudyTimer.fromJson(raw);
    } on Object {
      return null;
    }
  }

  @override
  Future<void> save(ActiveStudyTimer timer) {
    return _preferences.setString(key, jsonEncode(timer.toJson()));
  }

  @override
  Future<void> clear() {
    return _preferences.remove(key);
  }
}
