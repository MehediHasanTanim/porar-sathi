import 'package:sqlite3/sqlite3.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';

/// Runs [action] in one transaction and hides SQLite errors from the UI.
Future<T> runDatabaseTransaction<T>(
  AppDatabase database,
  Future<T> Function() action,
) async {
  try {
    return await database.transaction(action);
  } on AppException {
    rethrow;
  } on SqliteException catch (error) {
    throw DatabaseException(cause: error);
  }
}
