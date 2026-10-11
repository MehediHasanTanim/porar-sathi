import 'package:porar_sathi/core/errors/app_exception.dart';

/// Reads an enum that was stored as its stable code.
abstract final class StoredEnum {
  static T byCode<T extends Enum>(
    List<T> values,
    String code,
    String Function(T value) read,
  ) {
    for (final value in values) {
      if (read(value) == code) {
        return value;
      }
    }
    throw DatabaseException(message: 'Unknown stored value: $code');
  }
}
