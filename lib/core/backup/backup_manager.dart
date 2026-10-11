import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

import 'package:porar_sathi/core/errors/app_exception.dart';

final class PickedBackup {
  const PickedBackup({required this.name, required this.bytes});

  final String name;
  final Uint8List bytes;
}

/// System file picker and share sheet. Nothing is uploaded.
abstract interface class BackupManager {
  Future<bool> save({required String fileName, required Uint8List bytes});

  Future<PickedBackup?> pick();

  Future<void> share({required String fileName, required Uint8List bytes});
}

final class SystemBackupManager implements BackupManager {
  @override
  Future<bool> save({
    required String fileName,
    required Uint8List bytes,
  }) async {
    try {
      final saved = await FilePicker.saveFile(
        fileName: fileName,
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: const ['pockettutor'],
      );
      return saved != null;
    } on Object catch (error) {
      throw BackupException(
        message: 'Backup could not be saved.',
        cause: error,
      );
    }
  }

  @override
  Future<PickedBackup?> pick() async {
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pockettutor'],
      );
      if (files.isEmpty) {
        return null;
      }
      final file = files.single;
      final bytes = await file.readAsBytes();
      return PickedBackup(name: file.name, bytes: bytes);
    } on BackupException {
      rethrow;
    } on Object catch (error) {
      throw BackupException(
        message: 'Backup file could not be read.',
        cause: error,
      );
    }
  }

  @override
  Future<void> share({
    required String fileName,
    required Uint8List bytes,
  }) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              bytes,
              name: fileName,
              mimeType: 'application/octet-stream',
            ),
          ],
        ),
      );
    } on Object catch (error) {
      throw BackupException(
        message: 'Backup could not be shared.',
        cause: error,
      );
    }
  }
}
