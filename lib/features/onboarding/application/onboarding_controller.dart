import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/core/validation/validators.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/onboarding/data/onboarding_draft_repository_provider.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_draft.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';
import 'package:porar_sathi/features/onboarding/domain/student_profile.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';

part 'onboarding_controller.g.dart';

@Riverpod(keepAlive: true)
class OnboardingController extends _$OnboardingController {
  @override
  Future<OnboardingDraft> build() {
    return ref.watch(onboardingDraftRepositoryProvider).load();
  }

  Future<void> goTo(OnboardingStep step) {
    return _persist((draft) => draft.copyWith(step: step.code));
  }

  Future<void> saveStudyLevel(StudyLevel level) {
    return _persist(
      (draft) => draft.copyWith(
        studyLevel: level.code,
        planName: draft.planName.trim().isEmpty
            ? suggestedPlanName(level)
            : draft.planName,
      ),
    );
  }

  Future<void> saveProfile({
    required String displayName,
    required String skippedName,
    String? institution,
    String? academicYear,
  }) async {
    final draft = await future;
    final level = StudyLevel.fromCode(draft.studyLevel ?? StudyLevel.other.code);
    final clock = ref.read(clockProvider);
    final id = draft.profileId ?? ref.read(idGeneratorProvider).next();
    final name = displayName.trim().isEmpty ? skippedName : displayName.trim();
    final profile = normalizeStudentProfile(
      StudentProfile(
        id: id,
        displayName: name,
        studyLevel: level,
        institution: institution,
        academicYear: academicYear,
        preferredLanguage: (await ref.read(settingsControllerProvider.future)).language,
        createdAt: clock.now(),
        updatedAt: clock.now(),
      ),
    );
    await ref.read(studentProfileRepositoryProvider).save(profile);
    await _persist(
      (current) => current.copyWith(
        profileId: id,
        displayName: name,
        institution: profile.institution,
        academicYear: profile.academicYear,
        step: OnboardingStep.plan.code,
      ),
    );
  }

  Future<void> savePlan({
    required String name,
    required PlanType planType,
    required DateTime startDate,
    DateTime? targetEndDate,
  }) async {
    final draft = await future;
    final clock = ref.read(clockProvider);
    final id = draft.planId ?? ref.read(idGeneratorProvider).next();
    final existing = draft.planId == null
        ? null
        : await ref.read(studyPlanRepositoryProvider).findById(id);
    final createdAt = existing?.createdAt ?? clock.now();
    final plan = newStudyPlan(
      id: id,
      name: name,
      startDate: startDate,
      createdAt: createdAt,
      planType: planType,
      planningMode: PlanningMode.fromCode(draft.planningMode),
      dailyIntensity: DailyIntensity.fromCode(draft.dailyIntensity),
      maxSessionMinutes: draft.maxSessionMinutes,
      planningBufferPercent: draft.planningBufferPercent,
      revisionBufferDays: draft.revisionBufferDays,
    ).copyWith(
      targetEndDate: targetEndDate,
      primaryExamId: existing?.primaryExamId,
      updatedAt: clock.now(),
    );
    await ref.read(studyPlanRepositoryProvider).save(plan);
    await ref.read(settingsControllerProvider.notifier).setCurrentStudyPlanId(id);
    await _persist(
      (current) => current.copyWith(
        planId: id,
        planName: plan.name,
        planType: planType.code,
        startDate: storeDate(plan.startDate),
        targetEndDate: plan.targetEndDate == null
            ? null
            : storeDate(plan.targetEndDate!),
        step: OnboardingStep.exam.code,
      ),
    );
  }

  Future<void> skipExam() {
    return _persist(
      (draft) => draft.copyWith(
        examSkipped: true,
        step: OnboardingStep.availability.code,
      ),
    );
  }

  Future<void> saveExam({
    required String name,
    required ExamType examType,
    required DateTime startDate,
    DateTime? endDate,
    required Priority importance,
    bool addAnother = false,
  }) async {
    final draft = await future;
    final planId = draft.planId;
    if (planId == null) {
      throw const DatabaseException(message: 'Study plan was not found.');
    }
    final today = ref.read(clockProvider).today();
    final date = switch (Validators.futureExamDate(examDate: startDate, today: today)) {
      Success(:final value) => value,
      Failure(:final error) => throw error,
    };
    final clock = ref.read(clockProvider);
    final id = addAnother
        ? ref.read(idGeneratorProvider).next()
        : (draft.examId ?? ref.read(idGeneratorProvider).next());
    final exam = await ref.read(examRepositoryProvider).save(
      Exam(
        id: id,
        studyPlanId: planId,
        name: name,
        examType: examType,
        startDate: date,
        endDate: endDate,
        importance: importance,
        createdAt: clock.now(),
        updatedAt: clock.now(),
      ),
    );
    final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
    if (plan != null && plan.primaryExamId == null) {
      await ref.read(studyPlanRepositoryProvider).save(
        plan.copyWith(primaryExamId: exam.id, updatedAt: clock.now()),
      );
    }
    await _persist(
      (current) => current.copyWith(
        examSkipped: false,
        examId: addAnother ? null : exam.id,
        examName: addAnother ? '' : exam.name,
        examType: exam.examType.code,
        examDate: addAnother ? null : storeDate(exam.startDate),
        examEndDate: addAnother || exam.endDate == null
            ? null
            : storeDate(exam.endDate!),
        examImportance: importance.code,
        step: addAnother
            ? OnboardingStep.exam.code
            : OnboardingStep.availability.code,
      ),
    );
  }

  Future<void> saveAvailability(List<int> minutes) async {
    if (minutes.length != OnboardingDraft.weekdays.length) {
      throw const ValidationException(ValidationIssue.weekday);
    }
    if (minutes.every((value) => value <= 0)) {
      throw const ValidationException(ValidationIssue.availabilityMinutes);
    }
    final draft = await future;
    final planId = draft.planId;
    if (planId == null) {
      throw const DatabaseException(message: 'Study plan was not found.');
    }
    final clock = ref.read(clockProvider);
    final days = <WeeklyAvailability>[
      for (var index = 0; index < minutes.length; index++)
        WeeklyAvailability(
          id: '$planId-day-${OnboardingDraft.weekdays[index]}',
          studyPlanId: planId,
          weekday: OnboardingDraft.weekdays[index],
          totalAvailableMinutes: minutes[index] < 0 ? 0 : minutes[index],
          isStudyDay: minutes[index] > 0,
          preferredStartTime: draft.preferredStartTime,
          preferredEndTime: draft.preferredEndTime,
          createdAt: clock.now(),
          updatedAt: clock.now(),
        ),
    ];
    await ref.read(availabilityRepositoryProvider).replaceWeek(planId, days);
    final busiest = minutes.fold<int>(0, (max, value) => value > max ? value : max);
    final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
    if (plan != null) {
      await ref.read(studyPlanRepositoryProvider).save(
        plan.copyWith(maxDailyMinutes: busiest, updatedAt: clock.now()),
      );
    }
    await _persist(
      (current) => current.copyWith(
        weekdayMinutes: [for (final value in minutes) value < 0 ? 0 : value],
        step: OnboardingStep.studyTime.code,
      ),
    );
  }

  Future<void> saveStudyTime({int? startMinute, int? endMinute}) async {
    final draft = await future;
    final planId = draft.planId;
    if (planId == null) {
      throw const DatabaseException(message: 'Study plan was not found.');
    }
    if (startMinute != null && endMinute != null) {
      final clock = ref.read(clockProvider);
      final days = <WeeklyAvailability>[
        for (var index = 0; index < draft.weekdayMinutes.length; index++)
          WeeklyAvailability(
            id: '$planId-day-${OnboardingDraft.weekdays[index]}',
            studyPlanId: planId,
            weekday: OnboardingDraft.weekdays[index],
            totalAvailableMinutes: draft.weekdayMinutes[index],
            isStudyDay: draft.weekdayMinutes[index] > 0,
            preferredStartTime: startMinute,
            preferredEndTime: endMinute,
            createdAt: clock.now(),
            updatedAt: clock.now(),
          ),
      ];
      await ref.read(availabilityRepositoryProvider).replaceWeek(planId, days);
    }
    await _persist(
      (current) => current.copyWith(
        preferredStartTime: startMinute,
        preferredEndTime: endMinute,
        step: OnboardingStep.preferences.code,
      ),
    );
  }

  Future<void> savePreferences({
    required PlanningMode mode,
    required DailyIntensity intensity,
    required int maxSessionMinutes,
    required int planningBufferPercent,
    required int revisionBufferDays,
  }) async {
    final draft = await future;
    final planId = draft.planId;
    if (planId == null) {
      throw const DatabaseException(message: 'Study plan was not found.');
    }
    final plan = await ref.read(studyPlanRepositoryProvider).findById(planId);
    if (plan == null) {
      throw const DatabaseException(message: 'Study plan was not found.');
    }
    final clock = ref.read(clockProvider);
    final saved = await ref.read(studyPlanRepositoryProvider).save(
      plan.copyWith(
        planningMode: mode,
        dailyIntensity: intensity,
        maxSessionMinutes: maxSessionMinutes,
        planningBufferPercent: planningBufferPercent,
        revisionBufferDays: revisionBufferDays,
        updatedAt: clock.now(),
      ),
    );
    final settings = ref.read(settingsControllerProvider.notifier);
    await settings.setDefaultSessionDuration(saved.maxSessionMinutes);
    await settings.setPlanningBuffer(saved.planningBufferPercent);
    await _persist(
      (current) => current.copyWith(
        planningMode: mode.code,
        dailyIntensity: intensity.code,
        maxSessionMinutes: saved.maxSessionMinutes,
        planningBufferPercent: saved.planningBufferPercent,
        revisionBufferDays: saved.revisionBufferDays,
        step: OnboardingStep.summary.code,
      ),
    );
  }

  Future<void> _persist(OnboardingDraft Function(OnboardingDraft draft) update) async {
    final current = await future;
    final next = update(current);
    state = AsyncData(next);
    try {
      await ref.read(onboardingDraftRepositoryProvider).save(next);
      await ref.read(settingsControllerProvider.notifier).setOnboardingStep(next.step);
    } on Object {
      state = AsyncData(current);
      rethrow;
    }
  }
}

String suggestedPlanName(StudyLevel level) {
  return switch (level) {
    StudyLevel.ssc => 'SSC Final',
    StudyLevel.hsc => 'HSC Final',
    StudyLevel.university => 'Semester Final',
    StudyLevel.admission => 'Admission Test',
    StudyLevel.diploma => 'Diploma Final',
    StudyLevel.other => 'My Study Plan',
  };
}
