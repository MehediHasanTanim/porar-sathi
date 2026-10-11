import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/validation/validators.dart';

void main() {
  test('accepts a normal study session length', () {
    final result = Validators.sessionMinutes(45);
    expect(result, isA<Success<int>>());
  });

  test('rejects a session longer than four hours', () {
    final result = Validators.sessionMinutes(300);
    expect(result, isA<Failure<int>>());
    final error = (result as Failure<int>).error as ValidationException;
    expect(error.issue, ValidationIssue.sessionDuration);
  });

  test('rejects an exam date before today', () {
    final result = Validators.futureExamDate(
      examDate: DateTime(2026, 10, 1),
      today: DateTime(2026, 10, 9),
    );
    expect(result, isA<Failure<DateTime>>());
  });

  test('accepts an exam later today', () {
    final result = Validators.futureExamDate(
      examDate: DateTime(2026, 10, 9, 18),
      today: DateTime(2026, 10, 9),
    );
    expect(result, isA<Success<DateTime>>());
  });
}
