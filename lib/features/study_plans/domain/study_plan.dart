import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/validation/validators.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';

part 'study_plan.freezed.dart';

abstract final class StudyPlanDefaults {
  static const planType = PlanType.exam;
  static const planningMode = PlanningMode.balanced;
  static const dailyIntensity = DailyIntensity.normal;
  static const maxDailyMinutes = 180;
  static const revisionBufferDays = 7;
}

@freezed
abstract class StudyPlan with _$StudyPlan {
  const factory StudyPlan({
    required String id,
    required String name,
    String? description,
    required PlanType planType,
    required StudyPlanStatus status,
    required DateTime startDate,
    DateTime? targetEndDate,
    String? primaryExamId,
    required PlanningMode planningMode,
    required DailyIntensity dailyIntensity,
    required int maxDailyMinutes,
    required int maxSessionMinutes,
    required int planningBufferPercent,
    required int revisionBufferDays,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? archivedAt,
  }) = _StudyPlan;
}

StudyPlan normalizeStudyPlan(StudyPlan plan) {
  final name = requireValid(Validators.requiredText(plan.name, maxLength: 80));
  final description = _optional(plan.description, maxLength: 280);
  final startDate = calendarDate(plan.startDate);
  final targetEndDate = requireValid(
    Validators.endOnOrAfter(start: startDate, end: plan.targetEndDate),
  );
  final maxDailyMinutes = requireValid(
    Validators.availabilityMinutes(plan.maxDailyMinutes),
  );
  if (maxDailyMinutes == 0) {
    throw const ValidationException(ValidationIssue.availabilityMinutes);
  }
  final maxSessionMinutes = requireValid(
    Validators.sessionMinutes(plan.maxSessionMinutes),
  );
  final planningBufferPercent = requireValid(
    Validators.planningBufferPercent(plan.planningBufferPercent),
  );
  final revisionBufferDays = requireValid(
    Validators.revisionBufferDays(plan.revisionBufferDays),
  );
  final archivedAt = _statusTimestamp(
    isTerminal: plan.status == StudyPlanStatus.archived,
    timestamp: plan.archivedAt,
  );

  return plan.copyWith(
    name: name,
    description: description,
    startDate: startDate,
    targetEndDate: targetEndDate,
    maxDailyMinutes: maxDailyMinutes,
    maxSessionMinutes: maxSessionMinutes,
    planningBufferPercent: planningBufferPercent,
    revisionBufferDays: revisionBufferDays,
    archivedAt: archivedAt,
  );
}

StudyPlan newStudyPlan({
  required String id,
  required String name,
  required DateTime startDate,
  required DateTime createdAt,
  PlanType planType = StudyPlanDefaults.planType,
  PlanningMode planningMode = StudyPlanDefaults.planningMode,
  DailyIntensity dailyIntensity = StudyPlanDefaults.dailyIntensity,
  int maxDailyMinutes = StudyPlanDefaults.maxDailyMinutes,
  int maxSessionMinutes = SettingsDefaults.sessionMinutes,
  int planningBufferPercent = SettingsDefaults.planningBufferPercent,
  int revisionBufferDays = StudyPlanDefaults.revisionBufferDays,
}) {
  return StudyPlan(
    id: id,
    name: name,
    planType: planType,
    status: StudyPlanStatus.active,
    startDate: startDate,
    planningMode: planningMode,
    dailyIntensity: dailyIntensity,
    maxDailyMinutes: maxDailyMinutes,
    maxSessionMinutes: maxSessionMinutes,
    planningBufferPercent: planningBufferPercent,
    revisionBufferDays: revisionBufferDays,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}

String? _optional(String? value, {required int maxLength}) {
  if (value == null) {
    return null;
  }
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  if (trimmed.length > maxLength) {
    throw const ValidationException(ValidationIssue.requiredText);
  }
  return trimmed;
}

DateTime? _statusTimestamp({
  required bool isTerminal,
  required DateTime? timestamp,
}) {
  if (isTerminal && timestamp == null) {
    throw const ValidationException(ValidationIssue.statusTimestamp);
  }
  if (!isTerminal) {
    return null;
  }
  return timestamp;
}
