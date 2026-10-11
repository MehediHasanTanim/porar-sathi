import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:porar_sathi/features/sessions/data/active_session_store.dart';

part 'active_session_store_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ActiveSessionStore> activeSessionStore(Ref ref) async {
  return SharedPreferencesActiveSessionStore(await SharedPreferences.getInstance());
}
