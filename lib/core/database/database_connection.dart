import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:porar_sathi/core/database/app_database.dart';

Future<AppDatabase> openAppDatabase() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File(p.join(directory.path, 'porar_sathi.sqlite'));
  return AppDatabase(
    NativeDatabase.createInBackground(
      file,
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON;');
      },
    ),
  );
}
