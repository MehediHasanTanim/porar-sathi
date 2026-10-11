import 'dart:developer' as developer;

/// Local diagnostic log. Do not pass notes, institution names, or secrets.
abstract final class AppLogger {
  static void info(String message) {
    developer.log(message, name: 'porar_sathi');
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: 'porar_sathi',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
