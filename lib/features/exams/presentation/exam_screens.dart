import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/result/result.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/core/validation/validators.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class ExamListScreen extends ConsumerStatefulWidget {
  const ExamListScreen({super.key});

  @override
  ConsumerState<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends ConsumerState<ExamListScreen> {
  List<Exam> _exams = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final settings = await ref.read(settingsControllerProvider.future);
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      return;
    }
    final exams = await ref.read(examRepositoryProvider).watchByPlan(planId).first;
    if (mounted) {
      setState(() => _exams = exams);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final today = ref.watch(clockProvider).today();
    final upcoming = _exams.where((exam) => !calendarDate(exam.startDate).isBefore(today)).toList();
    final completed = _exams.where((exam) => calendarDate(exam.startDate).isBefore(today)).toList();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.examsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/exams/new');
          await _load();
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addExam),
      ),
      body: _exams.isEmpty
          ? EmptyState(icon: Icons.event_outlined, title: l10n.noExamsTitle, body: l10n.noExamsBody)
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (upcoming.isNotEmpty) Text(l10n.upcomingExams, style: Theme.of(context).textTheme.titleMedium),
                for (final exam in upcoming) _ExamTile(exam: exam, today: today, onChanged: _load),
                if (completed.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(l10n.completedExams, style: Theme.of(context).textTheme.titleMedium),
                  for (final exam in completed) _ExamTile(exam: exam, today: today, onChanged: _load),
                ],
              ],
            ),
    );
  }
}

class _ExamTile extends StatelessWidget {
  const _ExamTile({required this.exam, required this.today, required this.onChanged});

  final Exam exam;
  final DateTime today;
  final Future<void> Function() onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = calendarDate(exam.startDate).difference(today).inDays;
    return AppCard(
      onTap: () async {
        await context.push('/exams/${exam.id}');
        await onChanged();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(exam.name, style: Theme.of(context).textTheme.titleMedium),
          Text(DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(exam.startDate)),
          Text(days >= 0 ? l10n.daysRemaining(days) : l10n.completed),
        ],
      ),
    );
  }
}

class ExamFormScreen extends ConsumerStatefulWidget {
  const ExamFormScreen({this.examId, super.key});

  final String? examId;

  @override
  ConsumerState<ExamFormScreen> createState() => _ExamFormScreenState();
}

class _ExamFormScreenState extends ConsumerState<ExamFormScreen> {
  final _name = TextEditingController();
  final _notes = TextEditingController();
  var _type = ExamType.board;
  var _importance = Priority.high;
  DateTime? _date;
  DateTime? _end;
  Exam? _existing;
  var _loaded = false;

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final today = ref.watch(clockProvider).today();
    if (!_loaded) {
      _loaded = true;
      _load();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.examId == null ? l10n.addExam : l10n.editExam),
        actions: [TextButton(onPressed: _save, child: Text(l10n.actionSave))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          if (widget.examId != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(l10n.examDateChangeWarning),
            ),
          LabeledField(label: l10n.examName, child: TextField(controller: _name)),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.examType),
          OptionChips(
            labels: [l10n.examTypeBoard, l10n.examTypeMidterm, l10n.examTypeFinal, l10n.examTypeAdmission, l10n.examTypeCustom],
            selectedIndex: [ExamType.board, ExamType.midterm, ExamType.finalExam, ExamType.admission, ExamType.custom].indexOf(_type).clamp(0, 4),
            onSelected: (index) => setState(() {
              _type = [ExamType.board, ExamType.midterm, ExamType.finalExam, ExamType.admission, ExamType.custom][index];
            }),
          ),
          const SizedBox(height: AppSpacing.md),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.examDate),
            subtitle: Text(_date == null ? l10n.examDate : DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(_date!)),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date ?? today,
                firstDate: today,
                lastDate: DateTime(today.year + 8),
              );
              if (picked != null) {
                setState(() => _date = picked);
              }
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.examEnd),
            subtitle: Text(_end == null ? l10n.optionalHint : DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(_end!)),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _end ?? _date ?? today,
                firstDate: _date ?? today,
                lastDate: DateTime(today.year + 8),
              );
              if (picked != null) {
                setState(() => _end = picked);
              }
            },
          ),
          Text(l10n.examImportance),
          OptionChips(
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
          const SizedBox(height: AppSpacing.md),
          LabeledField(label: l10n.notes, child: TextField(controller: _notes, maxLines: 3)),
        ],
      ),
    );
  }

  Future<void> _load() async {
    final id = widget.examId;
    if (id == null) {
      return;
    }
    final exam = await ref.read(examRepositoryProvider).findById(id);
    if (exam == null || !mounted) {
      return;
    }
    setState(() {
      _existing = exam;
      _name.text = exam.name;
      _notes.text = exam.notes ?? '';
      _type = exam.examType;
      _importance = exam.importance;
      _date = exam.startDate;
      _end = exam.endDate;
    });
  }

  Future<void> _save() async {
    final date = _date;
    if (date == null) {
      return;
    }
    try {
      final today = ref.read(clockProvider).today();
      final valid = Validators.futureExamDate(examDate: date, today: today);
      if (valid is Failure<DateTime>) {
        throw valid.error;
      }
      final settings = await ref.read(settingsControllerProvider.future);
      final planId = _existing?.studyPlanId ?? settings.currentStudyPlanId;
      if (planId == null) {
        throw const DatabaseException(message: 'Study plan was not found.');
      }
      final clock = ref.read(clockProvider);
      await ref.read(examRepositoryProvider).save(
        Exam(
          id: _existing?.id ?? ref.read(idGeneratorProvider).next(),
          studyPlanId: planId,
          name: _name.text,
          examType: _type,
          startDate: date,
          endDate: _end,
          importance: _importance,
          notes: _notes.text,
          createdAt: _existing?.createdAt ?? clock.now(),
          updatedAt: clock.now(),
        ),
      );
      if (mounted) {
        context.pop();
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}

class ExamDetailsScreen extends ConsumerStatefulWidget {
  const ExamDetailsScreen({required this.examId, super.key});

  final String examId;

  @override
  ConsumerState<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends ConsumerState<ExamDetailsScreen> {
  Exam? _exam;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final exam = await ref.read(examRepositoryProvider).findById(widget.examId);
    if (mounted) {
      setState(() => _exam = exam);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exam = _exam;
    if (exam == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final days = calendarDate(exam.startDate).difference(ref.watch(clockProvider).today()).inDays;
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.name),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push('/exams/${exam.id}/edit');
              await _load();
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            days >= 0 ? l10n.daysRemaining(days) : l10n.completed,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(DateFormat.yMMMMd(Localizations.localeOf(context).toString()).format(exam.startDate)),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: () => context.push('/exams/${exam.id}/syllabus'),
            child: Text(l10n.linkSyllabus),
          ),
        ],
      ),
    );
  }
}

class ExamSyllabusScreen extends ConsumerStatefulWidget {
  const ExamSyllabusScreen({required this.examId, super.key});

  final String examId;

  @override
  ConsumerState<ExamSyllabusScreen> createState() => _ExamSyllabusScreenState();
}

class _ExamSyllabusScreenState extends ConsumerState<ExamSyllabusScreen> {
  final _selected = <String>{};
  List<Chapter> _chapters = [];
  String? _planId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final exam = await ref.read(examRepositoryProvider).findById(widget.examId);
    if (exam == null) {
      return;
    }
    final subjects = await ref.read(subjectRepositoryProvider).watchByPlan(exam.studyPlanId).first;
    final chapters = <Chapter>[];
    for (final subject in subjects) {
      chapters.addAll(await ref.read(chapterRepositoryProvider).watchBySubject(subject.id).first);
    }
    final linked = await ref.read(examRepositoryProvider).watchSyllabus(widget.examId).first;
    if (mounted) {
      setState(() {
        _planId = exam.studyPlanId;
        _chapters = chapters;
        _selected
          ..clear()
          ..addAll(linked.map((item) => item.chapterId).whereType<String>());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.syllabusMappingTitle),
        actions: [TextButton(onPressed: _save, child: Text(l10n.actionSave))],
      ),
      body: ListView(
        children: [
          for (final chapter in _chapters)
            CheckboxListTile(
              value: _selected.contains(chapter.id),
              title: Text(chapter.title),
              onChanged: (value) => setState(() {
                if (value ?? false) {
                  _selected.add(chapter.id);
                } else {
                  _selected.remove(chapter.id);
                }
              }),
            ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final planId = _planId;
    if (planId == null) {
      return;
    }
    try {
      final ids = ref.read(idGeneratorProvider);
      final items = [
        for (final chapter in _chapters.where((chapter) => _selected.contains(chapter.id)))
          ExamSyllabusItem(
            id: ids.next(),
            examId: widget.examId,
            subjectId: chapter.subjectId,
            chapterId: chapter.id,
            weight: 1,
            isRequired: true,
          ),
      ];
      await ref.read(examRepositoryProvider).replaceSyllabus(widget.examId, items);
      if (mounted) {
        context.pop();
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}
