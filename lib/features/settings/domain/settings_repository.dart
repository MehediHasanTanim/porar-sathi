import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';

abstract interface class SettingsRepository implements Repository {
  Future<AppSettings> load();

  Future<void> save(AppSettings settings);
}
