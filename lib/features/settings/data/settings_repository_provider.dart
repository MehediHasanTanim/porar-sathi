import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/features/settings/domain/settings_repository.dart';

part 'settings_repository_provider.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  throw StateError('Override settingsRepositoryProvider before the app starts.');
}
