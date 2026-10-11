import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:cryptography/cryptography.dart';

import 'package:porar_sathi/features/backup_restore/domain/backup_document.dart';

const backupPbkdf2Iterations = 120000;
const _magic = 'PTENC1';

/// Builds a `.pockettutor` file. A password wraps the zip with AES-256-GCM.
/// The checksum covers `data.json` before compression.
Future<Uint8List> encodeBackup({
  required BackupPayload payload,
  required String appVersion,
  required DateTime createdAt,
  required String locale,
  required String devicePlatform,
  String? password,
  int iterations = backupPbkdf2Iterations,
  int schemaVersion = backupSchemaVersion,
}) async {
  final dataBytes = Uint8List.fromList(utf8.encode(_encodeData(payload)));
  final manifest = BackupManifest(
    schemaVersion: schemaVersion,
    appVersion: appVersion,
    createdAt: createdAt,
    locale: locale,
    checksum: await _hexSha256(dataBytes),
    devicePlatform: devicePlatform,
    contents: backupContentsLabel,
  );
  final archive = Archive();
  archive.addFile(ArchiveFile.string('README.txt', backupReadme));
  archive.addFile(
    ArchiveFile.string('manifest.json', jsonEncode(_manifestJson(manifest))),
  );
  archive.addFile(ArchiveFile.bytes('data.json', dataBytes));
  final zip = ZipEncoder().encodeBytes(archive);
  if (password == null || password.isEmpty) {
    return zip;
  }
  return _encrypt(zip, password, iterations);
}

/// Reads a backup without writing to the study database.
Future<BackupInspection> inspectBackup({
  required Uint8List bytes,
  required String fileName,
  String? password,
}) async {
  if (!fileName.toLowerCase().endsWith('.$backupFileExtension')) {
    return const BackupRejected(BackupProblem.fileType);
  }
  if (bytes.isEmpty) {
    return const BackupRejected(BackupProblem.partial);
  }
  final encrypted = _isEncrypted(bytes);
  Uint8List zipBytes;
  if (encrypted) {
    if (password == null || password.isEmpty) {
      return const BackupRejected(BackupProblem.wrongPassword);
    }
    final opened = await _decrypt(bytes, password);
    if (opened == null) {
      return const BackupRejected(BackupProblem.wrongPassword);
    }
    zipBytes = opened;
  } else if (bytes.length < 4 || bytes[0] != 0x50 || bytes[1] != 0x4b) {
    return const BackupRejected(BackupProblem.corrupt);
  } else {
    zipBytes = bytes;
  }

  Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(zipBytes);
  } on Object {
    return const BackupRejected(BackupProblem.partial);
  }
  final manifestFile = archive.findFile('manifest.json');
  final dataFile = archive.findFile('data.json');
  if (manifestFile == null || dataFile == null) {
    return const BackupRejected(BackupProblem.partial);
  }
  final dataBytes = dataFile.readBytes();
  if (dataBytes == null) {
    return const BackupRejected(BackupProblem.partial);
  }

  final Object? manifestRaw;
  final Object? dataRaw;
  try {
    manifestRaw = jsonDecode(utf8.decode(manifestFile.readBytes()!));
    dataRaw = jsonDecode(utf8.decode(dataBytes));
  } on Object {
    return const BackupRejected(BackupProblem.corrupt);
  }
  if (manifestRaw is! Map || dataRaw is! Map) {
    return const BackupRejected(BackupProblem.corrupt);
  }
  final manifest = _readManifest(manifestRaw);
  if (manifest == null) {
    return const BackupRejected(BackupProblem.corrupt);
  }
  if (manifest.schemaVersion < backupSchemaVersion) {
    return const BackupRejected(BackupProblem.olderSchema);
  }
  if (manifest.schemaVersion > backupSchemaVersion) {
    return const BackupRejected(BackupProblem.newerSchema);
  }
  if (manifest.contents != backupContentsLabel) {
    return const BackupRejected(BackupProblem.missingSection);
  }
  if (manifest.checksum != await _hexSha256(dataBytes)) {
    return const BackupRejected(BackupProblem.checksum);
  }

  final sections = <String, List<Map<String, dynamic>>>{};
  for (final name in backupSections) {
    if (!dataRaw.containsKey(name)) {
      return const BackupRejected(BackupProblem.missingSection);
    }
    final value = dataRaw[name];
    if (value is! List) {
      return const BackupRejected(BackupProblem.corrupt);
    }
    final rows = <Map<String, dynamic>>[];
    for (final row in value) {
      if (row is! Map) {
        return const BackupRejected(BackupProblem.corrupt);
      }
      rows.add(row.map((key, item) => MapEntry('$key', item)));
    }
    sections[name] = rows;
  }
  final payload = BackupPayload(sections);
  final problem = validatePayload(payload);
  if (problem != null) {
    return BackupRejected(problem);
  }
  return BackupAccepted(
    manifest: manifest,
    payload: payload,
    summary: BackupSummary(
      createdAt: manifest.createdAt,
      locale: manifest.locale,
      appVersion: manifest.appVersion,
      plans: payload.rows('studyPlans').length,
      subjects: payload.rows('subjects').length,
      sessions: payload.rows('studySessions').length,
      encrypted: encrypted,
    ),
  );
}

bool backupNeedsPassword(Uint8List bytes) => _isEncrypted(bytes);

String _encodeData(BackupPayload payload) {
  return jsonEncode({
    for (final section in backupSections) section: payload.rows(section),
  });
}

Map<String, Object> _manifestJson(BackupManifest manifest) {
  return {
    'schemaVersion': manifest.schemaVersion,
    'appVersion': manifest.appVersion,
    'createdAt': manifest.createdAt.toUtc().toIso8601String(),
    'locale': manifest.locale,
    'devicePlatform': manifest.devicePlatform,
    'contents': manifest.contents,
    'checksum': manifest.checksum,
  };
}

BackupManifest? _readManifest(Map<dynamic, dynamic> json) {
  final schema = json['schemaVersion'];
  final appVersion = json['appVersion'];
  final created = json['createdAt'];
  final locale = json['locale'];
  final checksum = json['checksum'];
  final platform = json['devicePlatform'];
  final contents = json['contents'];
  if (schema is! int ||
      appVersion is! String ||
      created is! String ||
      locale is! String ||
      locale.isEmpty ||
      checksum is! String ||
      platform is! String ||
      contents is! String) {
    return null;
  }
  final createdAt = DateTime.tryParse(created);
  if (createdAt == null) {
    return null;
  }
  return BackupManifest(
    schemaVersion: schema,
    appVersion: appVersion,
    createdAt: createdAt,
    locale: locale,
    checksum: checksum,
    devicePlatform: platform,
    contents: contents,
  );
}

Future<String> _hexSha256(List<int> bytes) async {
  final digest = await Sha256().hash(bytes);
  return digest.bytes
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join();
}

bool _isEncrypted(Uint8List bytes) {
  if (bytes.length < _magic.length) {
    return false;
  }
  return utf8.decode(bytes.sublist(0, _magic.length), allowMalformed: true) ==
      _magic;
}

Future<Uint8List> _encrypt(
  Uint8List clear,
  String password,
  int iterations,
) async {
  final random = Random.secure();
  final salt = Uint8List.fromList(
    List.generate(16, (_) => random.nextInt(256)),
  );
  final nonce = Uint8List.fromList(
    List.generate(12, (_) => random.nextInt(256)),
  );
  final key = await _key(password, salt, iterations);
  final box = await AesGcm.with256bits().encrypt(
    clear,
    secretKey: key,
    nonce: nonce,
  );
  final header = BytesBuilder()
    ..add(utf8.encode(_magic))
    ..addByte(1)
    ..add(_uint32(iterations))
    ..add(salt)
    ..add(nonce)
    ..add(box.mac.bytes);
  header.add(box.cipherText);
  return header.toBytes();
}

Future<Uint8List?> _decrypt(Uint8List bytes, String password) async {
  const header = 6 + 1 + 4 + 16 + 12 + 16;
  if (bytes.length < header) {
    return null;
  }
  final view = ByteData.sublistView(bytes);
  final iterations = view.getUint32(7);
  if (iterations < 1 || iterations > 5000000) {
    return null;
  }
  final salt = bytes.sublist(11, 27);
  final nonce = bytes.sublist(27, 39);
  final mac = Mac(bytes.sublist(39, 55));
  final cipherText = bytes.sublist(55);
  try {
    final key = await _key(password, salt, iterations);
    final clear = await AesGcm.with256bits().decrypt(
      SecretBox(cipherText, nonce: nonce, mac: mac),
      secretKey: key,
    );
    return Uint8List.fromList(clear);
  } on SecretBoxAuthenticationError {
    return null;
  } on Object {
    return null;
  }
}

Future<SecretKey> _key(String password, List<int> salt, int iterations) {
  return Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: iterations,
    bits: 256,
  ).deriveKeyFromPassword(password: password, nonce: salt);
}

Uint8List _uint32(int value) {
  final data = ByteData(4)..setUint32(0, value);
  return data.buffer.asUint8List();
}
