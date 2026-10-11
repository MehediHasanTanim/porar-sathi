import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/validation/validators.dart';

part 'planner_run.freezed.dart';

@freezed
abstract class PlannerRun with _$PlannerRun {
  const factory PlannerRun({
    required String id,
    required String studyPlanId,
    required PlannerTrigger trigger,
    required DateTime startedAt,
    DateTime? completedAt,
    required int inputTaskCount,
    required int outputTaskCount,
    required PlannerRiskLevel riskLevel,
    DateTime? expectedFinishDate,
    required String algorithmVersion,
  }) = _PlannerRun;
}

PlannerRun normalizePlannerRun(PlannerRun run) {
  if (run.inputTaskCount < 0 || run.outputTaskCount < 0) {
    throw const ValidationException(ValidationIssue.estimatedMinutes);
  }
  if (run.completedAt != null && run.completedAt!.isBefore(run.startedAt)) {
    throw const ValidationException(ValidationIssue.dateRange);
  }
  return run.copyWith(
    algorithmVersion: requireValid(
      Validators.requiredText(run.algorithmVersion, maxLength: 40),
    ),
    expectedFinishDate: run.expectedFinishDate == null
        ? null
        : calendarDate(run.expectedFinishDate!),
  );
}
