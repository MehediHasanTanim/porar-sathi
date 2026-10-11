import 'package:drift/drift.dart';

import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/database/database_guard.dart';
import 'package:porar_sathi/core/database/reference_checks.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/planner/domain/availability_repository.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';

final class DriftAvailabilityRepository implements AvailabilityRepository {
  DriftAvailabilityRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<WeeklyAvailability>> watchWeek(String studyPlanId) {
    final query = _database.select(_database.weeklyAvailabilities)
      ..where((day) => day.studyPlanId.equals(studyPlanId))
      ..orderBy([(day) => OrderingTerm.asc(day.weekday)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<WeeklyAvailability> saveDay(WeeklyAvailability day) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeWeeklyAvailability(day);
      await ReferenceChecks(_database).studyPlanExists(normalized.studyPlanId);
      await _deleteOtherWeekday(normalized);
      await _database
          .into(_database.weeklyAvailabilities)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await _findDay(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Availability was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<void> replaceWeek(String studyPlanId, List<WeeklyAvailability> days) {
    return runDatabaseTransaction(_database, () async {
      final normalized = [
        for (final day in days) normalizeWeeklyAvailability(day),
      ];
      final weekdays = normalized.map((day) => day.weekday).toSet();
      if (weekdays.length != normalized.length) {
        throw const ValidationException(ValidationIssue.weekday);
      }
      await ReferenceChecks(_database).studyPlanExists(studyPlanId);
      for (final day in normalized) {
        if (day.studyPlanId != studyPlanId) {
          throw const DatabaseException(
            message: 'Availability does not match the study plan.',
          );
        }
      }
      await (_database.delete(_database.weeklyAvailabilities)
            ..where((day) => day.studyPlanId.equals(studyPlanId)))
          .go();
      if (normalized.isEmpty) {
        return;
      }
      await _database.batch((batch) {
        batch.insertAll(_database.weeklyAvailabilities, [
          for (final day in normalized) day.toCompanion(),
        ]);
      });
    });
  }

  @override
  Future<void> deleteDay(String id) {
    return runDatabaseTransaction(_database, () async {
      final removed = await (_database.delete(_database.weeklyAvailabilities)
            ..where((day) => day.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(message: 'Availability was not found.');
      }
    });
  }

  @override
  Stream<List<CalendarException>> watchExceptions(String studyPlanId) {
    final query = _database.select(_database.calendarExceptions)
      ..where((exception) => exception.studyPlanId.equals(studyPlanId))
      ..orderBy([(exception) => OrderingTerm.asc(exception.exceptionDate)]);
    return query.watch().map((rows) => [for (final row in rows) row.toDomain()]);
  }

  @override
  Future<CalendarException> saveException(CalendarException exception) {
    return runDatabaseTransaction(_database, () async {
      final normalized = normalizeCalendarException(exception);
      await ReferenceChecks(_database).studyPlanExists(normalized.studyPlanId);
      await (_database.delete(_database.calendarExceptions)..where(
        (row) =>
            row.studyPlanId.equals(normalized.studyPlanId) &
            row.exceptionDate.equals(normalized.date) &
            row.id.equals(normalized.id).not(),
      )).go();
      await _database
          .into(_database.calendarExceptions)
          .insertOnConflictUpdate(normalized.toCompanion());
      final stored = await _findException(normalized.id);
      if (stored == null) {
        throw const DatabaseException(message: 'Calendar exception was not saved.');
      }
      return stored;
    });
  }

  @override
  Future<void> deleteException(String id) {
    return runDatabaseTransaction(_database, () async {
      final removed = await (_database.delete(_database.calendarExceptions)
            ..where((exception) => exception.id.equals(id)))
          .go();
      if (removed == 0) {
        throw const DatabaseException(
          message: 'Calendar exception was not found.',
        );
      }
    });
  }

  Future<void> _deleteOtherWeekday(WeeklyAvailability day) {
    return (_database.delete(_database.weeklyAvailabilities)..where(
      (row) =>
          row.studyPlanId.equals(day.studyPlanId) &
          row.weekday.equals(day.weekday) &
          row.id.equals(day.id).not(),
    )).go();
  }

  Future<WeeklyAvailability?> _findDay(String id) async {
    final row = await (_database.select(_database.weeklyAvailabilities)
          ..where((day) => day.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  Future<CalendarException?> _findException(String id) async {
    final row = await (_database.select(_database.calendarExceptions)
          ..where((exception) => exception.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }
}

extension on WeeklyAvailabilityRow {
  WeeklyAvailability toDomain() {
    return WeeklyAvailability(
      id: id,
      studyPlanId: studyPlanId,
      weekday: weekday,
      totalAvailableMinutes: totalAvailableMinutes,
      isStudyDay: isStudyDay,
      preferredStartTime: preferredStartTime,
      preferredEndTime: preferredEndTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on WeeklyAvailability {
  WeeklyAvailabilitiesCompanion toCompanion() {
    return WeeklyAvailabilitiesCompanion.insert(
      id: id,
      studyPlanId: studyPlanId,
      weekday: weekday,
      totalAvailableMinutes: totalAvailableMinutes,
      isStudyDay: isStudyDay,
      preferredStartTime: Value(preferredStartTime),
      preferredEndTime: Value(preferredEndTime),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on CalendarExceptionRow {
  CalendarException toDomain() {
    return CalendarException(
      id: id,
      studyPlanId: studyPlanId,
      date: calendarDate(exceptionDate),
      exceptionType: CalendarExceptionType.fromCode(exceptionType),
      availableMinutesOverride: availableMinutesOverride,
      reason: reason,
      isNoStudyDay: isNoStudyDay,
      createdAt: createdAt,
    );
  }
}

extension on CalendarException {
  CalendarExceptionsCompanion toCompanion() {
    return CalendarExceptionsCompanion.insert(
      id: id,
      studyPlanId: studyPlanId,
      exceptionDate: date,
      exceptionType: exceptionType.code,
      availableMinutesOverride: Value(availableMinutesOverride),
      reason: Value(reason),
      isNoStudyDay: isNoStudyDay,
      createdAt: createdAt,
    );
  }
}
