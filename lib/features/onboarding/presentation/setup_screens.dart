import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/app/widgets/selection_card.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/features/onboarding/application/onboarding_controller.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_draft.dart';
import 'package:porar_sathi/features/onboarding/domain/onboarding_step.dart';
import 'package:porar_sathi/features/onboarding/presentation/onboarding_scaffold.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return OnboardingScaffold(
      step: OnboardingStep.welcome,
      title: l10n.welcomeHeadline,
      body: ListView(
        children: [
          _Benefit(
            icon: Icons.calendar_month,
            title: l10n.welcomeBenefitPlanTitle,
            body: l10n.welcomeBenefitPlanBody,
          ),
          _Benefit(
            icon: Icons.menu_book_outlined,
            title: l10n.welcomeBenefitSyllabusTitle,
            body: l10n.welcomeBenefitSyllabusBody,
          ),
          _Benefit(
            icon: Icons.trending_up,
            title: l10n.welcomeBenefitTrackTitle,
            body: l10n.welcomeBenefitTrackBody,
          ),
        ],
      ),
      primaryLabel: l10n.actionSetUpPlan,
      onPrimary: () async {
        await ref.read(onboardingControllerProvider.notifier).goTo(OnboardingStep.studyType);
        if (context.mounted) {
          context.go(OnboardingStep.studyType.route);
        }
      },
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppPalette.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(body, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyTypeScreen extends ConsumerWidget {
  const StudyTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider).asData?.value;
    final selected = StudyLevel.fromCode(draft?.studyLevel ?? StudyLevel.hsc.code);
    final options = [
      (StudyLevel.ssc, l10n.studyTypeSsc, l10n.studyTypeSscBody, Icons.school_outlined),
      (StudyLevel.hsc, l10n.studyTypeHsc, l10n.studyTypeHscBody, Icons.history_edu_outlined),
      (StudyLevel.university, l10n.studyTypeUniversity, l10n.studyTypeUniversityBody, Icons.account_balance_outlined),
      (StudyLevel.admission, l10n.studyTypeAdmission, l10n.studyTypeAdmissionBody, Icons.emoji_events_outlined),
      (StudyLevel.diploma, l10n.studyTypeDiploma, l10n.studyTypeDiplomaBody, Icons.engineering_outlined),
      (StudyLevel.other, l10n.studyTypeOther, l10n.studyTypeOtherBody, Icons.tune),
    ];
    return OnboardingScaffold(
      step: OnboardingStep.studyType,
      title: l10n.studyTypeTitle,
      subtitle: l10n.studyTypeSubtitle,
      body: ListView(
        children: [
          for (final option in options) ...[
            SelectionCard(
              icon: option.$4,
              title: option.$2,
              subtitle: option.$3,
              selected: selected == option.$1,
              onTap: () => ref.read(onboardingControllerProvider.notifier).saveStudyLevel(option.$1),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          Text(l10n.studyTypeFootnote, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      primaryLabel: l10n.actionContinue,
      onPrimary: draft == null
          ? null
          : () async {
              final controller = ref.read(onboardingControllerProvider.notifier);
              await controller.saveStudyLevel(selected);
              await controller.goTo(OnboardingStep.profile);
              if (context.mounted) {
                context.go(OnboardingStep.profile.route);
              }
            },
    );
  }
}

class StudentProfileScreen extends ConsumerStatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  ConsumerState<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends ConsumerState<StudentProfileScreen> {
  final _name = TextEditingController();
  final _year = TextEditingController();
  final _institution = TextEditingController();
  var _ready = false;

  @override
  void dispose() {
    _name.dispose();
    _year.dispose();
    _institution.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider).asData?.value;
    if (draft != null && !_ready) {
      _name.text = draft.displayName;
      _year.text = draft.academicYear ?? '';
      _institution.text = draft.institution ?? '';
      _ready = true;
    }
    return OnboardingScaffold(
      step: OnboardingStep.profile,
      title: l10n.profileTitle,
      subtitle: l10n.profileSubtitle,
      body: ListView(
        children: [
          LabeledField(
            label: l10n.profileName,
            child: TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(hintText: l10n.optionalHint),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.profileYear,
            child: TextField(controller: _year),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.profileInstitution,
            child: TextField(controller: _institution),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.profilePrivacy, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      primaryLabel: l10n.actionContinue,
      onPrimary: draft == null ? null : () => _save(l10n.skippedStudentName),
      secondaryLabel: l10n.actionSkipForNow,
      onSecondary: draft == null ? null : () => _save(l10n.skippedStudentName, skip: true),
    );
  }

  Future<void> _save(String skippedName, {bool skip = false}) async {
    try {
      await ref.read(onboardingControllerProvider.notifier).saveProfile(
        displayName: skip ? '' : _name.text,
        skippedName: skippedName,
        institution: skip ? null : _institution.text,
        academicYear: skip ? null : _year.text,
      );
      if (mounted) {
        context.go(OnboardingStep.plan.route);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}

class CreatePlanScreen extends ConsumerStatefulWidget {
  const CreatePlanScreen({super.key});

  @override
  ConsumerState<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends ConsumerState<CreatePlanScreen> {
  final _name = TextEditingController();
  var _type = PlanType.exam;
  DateTime? _start;
  DateTime? _end;
  var _ready = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider).asData?.value;
    final today = ref.watch(clockProvider).today();
    if (draft != null && !_ready) {
      _name.text = draft.planName;
      _type = PlanType.fromCode(draft.planType);
      _start = draftDate(draft.startDate) ?? today;
      _end = draftDate(draft.targetEndDate);
      _ready = true;
    }
    final start = _start ?? today;
    return OnboardingScaffold(
      step: OnboardingStep.plan,
      title: l10n.planTitle,
      subtitle: l10n.planSubtitle,
      body: ListView(
        children: [
          LabeledField(
            label: l10n.planName,
            child: TextField(controller: _name),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.planType,
            child: OptionChips(
              labels: [
                l10n.planTypeBoard,
                l10n.planTypeSemester,
                l10n.planTypeAdmission,
                l10n.planTypeCustom,
              ],
              selectedIndex: [PlanType.exam, PlanType.semester, PlanType.admission, PlanType.custom].indexOf(_type),
              onSelected: (index) => setState(() {
                _type = [PlanType.exam, PlanType.semester, PlanType.admission, PlanType.custom][index];
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.planStart,
            child: _DateTile(
              label: _format(context, start),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: start,
                  firstDate: DateTime(today.year - 1),
                  lastDate: DateTime(today.year + 6),
                );
                if (picked != null) {
                  setState(() => _start = picked);
                }
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.planEnd,
            child: _DateTile(
              label: _end == null ? l10n.optionalHint : _format(context, _end!),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _end ?? start,
                  firstDate: start,
                  lastDate: DateTime(today.year + 8),
                );
                if (picked != null) {
                  setState(() => _end = picked);
                }
              },
            ),
          ),
        ],
      ),
      primaryLabel: l10n.actionContinue,
      onPrimary: draft == null
          ? null
          : () async {
              try {
                await ref.read(onboardingControllerProvider.notifier).savePlan(
                  name: _name.text,
                  planType: _type,
                  startDate: start,
                  targetEndDate: _end,
                );
                if (context.mounted) {
                  context.go(OnboardingStep.exam.route);
                }
              } on Object catch (error) {
                if (context.mounted) {
                  showAppError(context, error);
                }
              }
            },
    );
  }

  String _format(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(date);
  }
}

class ExamSetupScreen extends ConsumerStatefulWidget {
  const ExamSetupScreen({super.key});

  @override
  ConsumerState<ExamSetupScreen> createState() => _ExamSetupScreenState();
}

class _ExamSetupScreenState extends ConsumerState<ExamSetupScreen> {
  final _name = TextEditingController();
  var _type = ExamType.board;
  var _importance = Priority.high;
  DateTime? _date;
  DateTime? _end;
  var _ready = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider).asData?.value;
    final today = ref.watch(clockProvider).today();
    if (draft != null && !_ready) {
      _name.text = draft.examName.isEmpty ? draft.planName : draft.examName;
      _type = ExamType.fromCode(draft.examType);
      _importance = Priority.fromCode(draft.examImportance);
      _date = draftDate(draft.examDate);
      _end = draftDate(draft.examEndDate);
      _ready = true;
    }
    final date = _date;
    final days = date?.difference(today).inDays;
    return OnboardingScaffold(
      step: OnboardingStep.exam,
      title: l10n.examTitle,
      subtitle: l10n.examSubtitle,
      body: ListView(
        children: [
          LabeledField(
            label: l10n.examName,
            child: TextField(controller: _name),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.examType,
            child: OptionChips(
              labels: [
                l10n.examTypeBoard,
                l10n.examTypeMidterm,
                l10n.examTypeFinal,
                l10n.examTypeAdmission,
                l10n.examTypeCustom,
              ],
              selectedIndex: _typeIndex(_type),
              onSelected: (index) => setState(() => _type = _types[index]),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.examDate,
            child: _DateTile(
              label: date == null ? l10n.examDate : DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(date),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: date ?? today,
                  firstDate: today,
                  lastDate: DateTime(today.year + 8),
                );
                if (picked != null) {
                  setState(() => _date = picked);
                }
              },
            ),
          ),
          if (days != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(l10n.daysFromToday(days)),
            ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.examImportance,
            child: OptionChips(
              labels: [l10n.importanceNormal, l10n.importanceImportant, l10n.importanceVeryImportant],
              selectedIndex: switch (_importance) {
                Priority.critical => 2,
                Priority.high => 1,
                _ => 0,
              },
              onSelected: (index) => setState(() {
                _importance = [Priority.normal, Priority.high, Priority.critical][index];
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: date == null
                ? null
                : () => _save(addAnother: true),
            child: Text(l10n.actionAddAnotherExam),
          ),
        ],
      ),
      primaryLabel: l10n.actionContinue,
      onPrimary: date == null ? null : () => _save(addAnother: false),
      secondaryLabel: l10n.examNoDate,
      onSecondary: () async {
        await ref.read(onboardingControllerProvider.notifier).skipExam();
        if (context.mounted) {
          context.go(OnboardingStep.availability.route);
        }
      },
    );
  }

  static const _types = [
    ExamType.board,
    ExamType.midterm,
    ExamType.finalExam,
    ExamType.admission,
    ExamType.custom,
  ];

  int _typeIndex(ExamType type) {
    final index = _types.indexOf(type);
    return index < 0 ? 0 : index;
  }

  Future<void> _save({required bool addAnother}) async {
    final date = _date;
    if (date == null) {
      return;
    }
    try {
      await ref.read(onboardingControllerProvider.notifier).saveExam(
        name: _name.text,
        examType: _type,
        startDate: date,
        endDate: _end,
        importance: _importance,
        addAnother: addAnother,
      );
      if (!mounted) {
        return;
      }
      if (addAnother) {
        setState(() {
          _name.clear();
          _date = null;
          _end = null;
          _ready = true;
        });
      } else {
        context.go(OnboardingStep.availability.route);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          const Icon(Icons.calendar_today_outlined, color: AppPalette.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
