import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/core/backup/backup_manager.dart';
import 'package:porar_sathi/core/database/database_provider.dart';
import 'package:porar_sathi/features/backup_restore/data/drift_backup_repository.dart';
import 'package:porar_sathi/features/backup_restore/domain/backup_repository.dart';

final backupRepositoryProvider = Provider<BackupRepository>(
  (ref) => DriftBackupRepository(ref.watch(appDatabaseProvider)),
);

final backupManagerProvider = Provider<BackupManager>(
  (ref) => SystemBackupManager(),
);
