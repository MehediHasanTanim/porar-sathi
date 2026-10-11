import 'package:porar_sathi/features/backup_restore/domain/backup_document.dart';

/// Study-data access for backup. Validation never calls this.
abstract interface class BackupRepository {
  Future<BackupPayload> readPayload();

  Future<void> replaceAll(BackupPayload payload);

  Future<void> resetProgress();

  Future<void> deleteAll();

  Future<int> databaseSizeBytes();
}
