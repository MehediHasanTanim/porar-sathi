import 'package:porar_sathi/core/errors/app_exception.dart';

/// Outcome of a use case or validation check.
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final AppException error;
}

T requireValid<T>(Result<T> result) {
  return switch (result) {
    Success(:final value) => value,
    Failure(:final error) => throw error,
  };
}
