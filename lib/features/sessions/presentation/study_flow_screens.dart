import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/notifications/application/reconcile_reminders.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/sessions/application/study_timer_controller.dart';
import 'package:porar_sathi/features/sessions/domain/study_completion.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/sessions/domain/study_timer.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

Future<void> showSkipSheet({
  required BuildContext context,
  required WidgetRef ref,
  required StudyTask task,
}) async {
  final l10n = AppLocalizations.of(context);
  final choice = await showModalBottomSheet<String>(
    context: context,
    builder: (sheetContext) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.skipTitle,
              style: Theme.of(sheetContext).textTheme.titleMedium,
            ),
            ListTile(
              title: Text(l10n.skipToday),
              onTap: () => Navigator.pop(sheetContext, 'today'),
            ),
            ListTile(
              title: Text(l10n.skipRemove),
              onTap: () => Navigator.pop(sheetContext, 'remove'),
            ),
            ListTile(
              title: Text(l10n.skipReschedule),
              onTap: () => Navigator.pop(sheetContext, 'reschedule'),
            ),
          ],
        ),
      );
    },
  );
  if (choice == null || !context.mounted) {
    return;
  }
  final now = ref.read(clockProvider).now();
  final updated = switch (choice) {
    'remove' => task.copyWith(status: TaskStatus.cancelled, updatedAt: now),
    'reschedule' => task.copyWith(
      plannedDate: calendarDate(now).add(const Duration(days: 1)),
      status: TaskStatus.planned,
      updatedAt: now,
    ),
    _ => task.copyWith(status: TaskStatus.skipped, updatedAt: now),
  };
  await ref.read(studyTaskRepositoryProvider).save(updated);
  await reconcileReminders(ref);
}

Future<void> showStartSheet({
  required BuildContext context,
  required WidgetRef ref,
  required StudyTask task,
  required String subjectName,
  required String title,
  required String? examName,
}) {
  final l10n = AppLocalizations.of(context);
  return showModalBottomSheet<void>(
    context: context,
    builder: (sheetContext) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(sheetContext).textTheme.titleMedium),
            Text(LocaleFormat.formatDuration(task.plannedMinutes, l10n)),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: l10n.actionStartTimer,
              onPressed: () async {
                Navigator.of(sheetContext).pop();
                await ref
                    .read(studyTimerControllerProvider.notifier)
                    .start(
                      ActiveStudyTimer(
                        id: ref.read(idGeneratorProvider).next(),
                        taskId: task.id,
                        subjectId: task.subjectId,
                        chapterId: task.chapterId,
                        subjectName: subjectName,
                        title: title,
                        examName: examName,
                        plannedMinutes: task.plannedMinutes,
                        startedAt: ref.read(clockProvider).now(),
                        elapsedBeforeResume: 0,
                        phase: TimerPhase.idle,
                      ),
                    );
                if (context.mounted) {
                  await context.push(AppRoutes.session);
                }
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () {
                Navigator.of(sheetContext).pop();
                context.push(AppRoutes.completeTask(task.id));
              },
              child: Text(l10n.actionStudyWithoutTimer),
            ),
          ],
        ),
      );
    },
  );
}

class TaskDetailScreen extends ConsumerStatefulWidget {
  const TaskDetailScreen({required this.taskId, super.key});

  final String taskId;

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  StudyTask? _task;
  Subject? _subject;
  Chapter? _chapter;
  String? _examName;
  int? _days;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final task = await ref
        .read(studyTaskRepositoryProvider)
        .findById(widget.taskId);
    if (task == null || !mounted) {
      return;
    }
    final subject = await ref
        .read(subjectRepositoryProvider)
        .findById(task.subjectId);
    final chapter = task.chapterId == null
        ? null
        : await ref.read(chapterRepositoryProvider).findById(task.chapterId!);
    String? examName;
    int? days;
    if (task.examId != null) {
      final exam = await ref
          .read(examRepositoryProvider)
          .findById(task.examId!);
      examName = exam?.name;
      if (exam != null) {
        days = calendarDate(exam.startDate)
            .difference(ref.read(clockProvider).today())
            .inDays;
      }
    }
    if (mounted) {
      setState(() {
        _task = task;
        _subject = subject;
        _chapter = chapter;
        _examName = examName;
        _days = days;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final task = _task;
    if (task == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final chapter = _chapter;
    return Scaffold(
      appBar: AppBar(title: Text(_subject?.name ?? task.title)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            chapter?.title ?? task.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(LocaleFormat.formatDuration(task.plannedMinutes, l10n)),
          if (_examName != null) Text(_examName!),
          if (chapter != null)
            Text('${l10n.difficulty}: ${chapter.difficulty.code}'),
          if (chapter != null)
            Text('${l10n.confidence}: ${chapter.confidence.code}'),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.whyThisTask, style: Theme.of(context).textTheme.titleSmall),
          if (_days != null) Text(l10n.daysRemaining(_days!)),
          if (chapter != null &&
              (chapter.confidence == Confidence.low ||
                  chapter.confidence == Confidence.veryLow))
            Text(l10n.confidenceLowReason),
          if (chapter != null &&
              (chapter.priority == Priority.high ||
                  chapter.priority == Priority.critical))
            Text(l10n.highPriorityChapter),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.actionStart,
            onPressed: () => showStartSheet(
              context: context,
              ref: ref,
              task: task,
              subjectName: _subject?.name ?? task.title,
              title: chapter?.title ?? task.title,
              examName: _examName,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.completeTask(task.id)),
            child: Text(l10n.actionComplete),
          ),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.partialTask(task.id)),
            child: Text(l10n.actionPartial),
          ),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.moveTask(task.id)),
            child: Text(l10n.actionMove),
          ),
          OutlinedButton(
            onPressed: () async {
              try {
                await showSkipSheet(context: context, ref: ref, task: task);
                if (context.mounted) {
                  context.pop();
                }
              } on Object catch (error) {
                if (context.mounted) {
                  showAppError(context, error);
                }
              }
            },
            child: Text(l10n.actionSkip),
          ),
        ],
      ),
    );
  }
}

class StudySessionScreen extends ConsumerStatefulWidget {
  const StudySessionScreen({super.key});

  @override
  ConsumerState<StudySessionScreen> createState() => _StudySessionScreenState();
}

class _StudySessionScreenState extends ConsumerState<StudySessionScreen> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final timer = ref.watch(studyTimerControllerProvider).asData?.value;
    if (timer == null || timer.phase == TimerPhase.idle) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final now = ref.read(clockProvider).now();
    final seconds = timer.elapsedSeconds(now);
    final paused = timer.phase == TimerPhase.paused;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          timer.quickStudy ? l10n.quickStudyTitle : timer.subjectName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timer.subjectName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(timer.title),
            if (timer.examName != null) Text(timer.examName!),
            const Spacer(),
            Center(
              child: Text(
                _clock(seconds),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            if (paused)
              Center(
                child: Text(
                  l10n.sessionPaused,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            Center(
              child: Text(
                l10n.plannedLabel(
                  LocaleFormat.formatDuration(timer.plannedMinutes, l10n),
                ),
              ),
            ),
            const Spacer(),
            if (!paused)
              PrimaryButton(
                label: l10n.actionPause,
                onPressed: () =>
                    ref.read(studyTimerControllerProvider.notifier).pause(),
              )
            else
              PrimaryButton(
                label: l10n.actionResume,
                onPressed: () =>
                    ref.read(studyTimerControllerProvider.notifier).resume(),
              ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () async {
                final finished = await ref
                    .read(studyTimerControllerProvider.notifier)
                    .finish();
                if (context.mounted) {
                  context.pushReplacement(
                    finished?.revisionId == null
                        ? AppRoutes.finishSession
                        : AppRoutes.revisionComplete,
                  );
                }
              },
              child: Text(paused ? l10n.actionFinishNow : l10n.actionFinish),
            ),
          ],
        ),
      ),
    );
  }
}

class FinishSessionScreen extends ConsumerStatefulWidget {
  const FinishSessionScreen({this.taskId, super.key});

  /// Set when the student logs the session without a timer.
  final String? taskId;

  @override
  ConsumerState<FinishSessionScreen> createState() =>
      _FinishSessionScreenState();
}

class _FinishSessionScreenState extends ConsumerState<FinishSessionScreen> {
  var _result = SessionResult.fullyCompleted;
  var _percent = 100;
  var _minutes = 45;
  var _confidence = 2;
  var _revision = true;
  final _note = TextEditingController();
  StudyTask? _task;
  var _ready = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final timer = ref.read(studyTimerControllerProvider).asData?.value;
    final taskId = widget.taskId ?? timer?.taskId;
    StudyTask? task;
    if (taskId != null) {
      task = await ref.read(studyTaskRepositoryProvider).findById(taskId);
    }
    final planned = task?.plannedMinutes ?? timer?.plannedMinutes ?? 45;
    final actual = timer != null && timer.phase == TimerPhase.completed
        ? timer.elapsedMinutes(ref.read(clockProvider).now())
        : planned;
    if (mounted) {
      setState(() {
        _task = task;
        _minutes = actual < 0 ? 0 : actual;
        _ready = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.finishTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          OptionChips(
            labels: [
              l10n.resultFully,
              l10n.resultMostly,
              l10n.resultPartial,
              l10n.resultCouldNot,
            ],
            selectedIndex: _resultIndex,
            onSelected: (index) => setState(() {
              _result = SessionResult.values[index];
              _percent = switch (index) {
                0 => 100,
                1 => 80,
                2 => 50,
                _ => 0,
              };
            }),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.actualTime),
          Text('$_minutes'),
          Slider(
            value: _minutes.clamp(0, 240).toDouble(),
            max: 240,
            divisions: 48,
            label: '$_minutes',
            onChanged: (value) => setState(() => _minutes = value.round()),
          ),
          Text(l10n.confidenceNow),
          OptionChips(
            labels: const ['1', '2', '3', '4', '5'],
            selectedIndex: _confidence,
            onSelected: (index) => setState(() => _confidence = index),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.wantRevision),
            value: _revision,
            onChanged: (value) => setState(() => _revision = value),
          ),
          TextField(
            controller: _note,
            decoration: InputDecoration(labelText: l10n.notes),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: l10n.actionSaveSession, onPressed: _save),
        ],
      ),
    );
  }

  int get _resultIndex => SessionResult.values.indexOf(_result);

  Future<void> _save() async {
    final timer = ref.read(studyTimerControllerProvider).asData?.value;
    var task = _task;
    try {
      if (task == null && timer != null) {
        final subject = await ref
            .read(subjectRepositoryProvider)
            .findById(timer.subjectId);
        if (subject == null) {
          throw StateError('Subject is missing.');
        }
        final now = ref.read(clockProvider).now();
        task = StudyTask(
          id: ref.read(idGeneratorProvider).next(),
          studyPlanId: subject.studyPlanId,
          subjectId: subject.id,
          chapterId: timer.chapterId,
          taskType: TaskType.newStudy,
          title: timer.title,
          plannedDate: calendarDate(now),
          plannedMinutes: timer.plannedMinutes,
          priorityScore: 0,
          isLocked: false,
          status: TaskStatus.planned,
          completionPercent: 0,
          source: TaskSource.quickStudy,
          createdAt: now,
          updatedAt: now,
        );
      }
      final missed = _result == SessionResult.couldNotStudy;
      await _commit(
        ref: ref,
        task: task,
        plannedMinutes: task?.plannedMinutes ?? timer?.plannedMinutes ?? 1,
        actualMinutes: _minutes,
        completionPercent: _percent,
        result: _result,
        note: _note.text,
        confidenceAfter: missed ? null : Confidence.values[_confidence],
        needsRevision: _revision && !missed,
        replanRemaining: _result == SessionResult.partiallyCompleted,
        startedAt: timer?.startedAt ?? ref.read(clockProvider).now(),
        sessionId: timer?.id,
      );
      await ref.read(studyTimerControllerProvider.notifier).clear();
      if (mounted) {
        context.go(AppRoutes.today);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}

class PartialCompletionScreen extends ConsumerStatefulWidget {
  const PartialCompletionScreen({required this.taskId, super.key});

  final String taskId;

  @override
  ConsumerState<PartialCompletionScreen> createState() =>
      _PartialCompletionScreenState();
}

class _PartialCompletionScreenState
    extends ConsumerState<PartialCompletionScreen> {
  StudyTask? _task;
  var _percent = 50;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final task = await ref
          .read(studyTaskRepositoryProvider)
          .findById(widget.taskId);
      if (mounted) {
        setState(() => _task = task);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final task = _task;
    if (task == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final remain = (task.plannedMinutes * (100 - _percent) / 100).round();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.partialTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('$_percent%'),
          Slider(
            value: _percent.toDouble(),
            max: 100,
            divisions: 20,
            label: '$_percent%',
            onChanged: (value) => setState(() => _percent = value.round()),
          ),
          OptionChips(
            labels: const ['25%', '50%', '75%'],
            selectedIndex: const [25, 50, 75].indexOf(_percent),
            onSelected: (index) =>
                setState(() => _percent = [25, 50, 75][index]),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.aboutRemain(
              LocaleFormat.formatDuration(remain < 0 ? 0 : remain, l10n),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.actionSaveReplan,
            onPressed: () => _save(replan: true),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: () => _save(replan: false),
            child: Text(l10n.actionSaveWithoutReplan),
          ),
        ],
      ),
    );
  }

  Future<void> _save({required bool replan}) async {
    final task = _task;
    if (task == null) {
      return;
    }
    final actual = (task.plannedMinutes * _percent / 100).round();
    try {
      await _commit(
        ref: ref,
        task: task,
        plannedMinutes: task.plannedMinutes,
        actualMinutes: actual < 1 ? 1 : actual,
        completionPercent: _percent,
        result: SessionResult.partiallyCompleted,
        note: '',
        confidenceAfter: null,
        needsRevision: false,
        replanRemaining: replan,
        startedAt: ref.read(clockProvider).now(),
      );
      if (mounted) {
        context.go(AppRoutes.today);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }
}

class MoveTaskScreen extends ConsumerStatefulWidget {
  const MoveTaskScreen({required this.taskId, super.key});

  final String taskId;

  @override
  ConsumerState<MoveTaskScreen> createState() => _MoveTaskScreenState();
}

class _MoveTaskScreenState extends ConsumerState<MoveTaskScreen> {
  StudyTask? _task;
  var _buffer = 15;
  var _week = <WeeklyAvailability>[];
  var _exceptions = <CalendarException>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final task = await ref
        .read(studyTaskRepositoryProvider)
        .findById(widget.taskId);
    if (task == null) {
      return;
    }
    final plan = await ref
        .read(studyPlanRepositoryProvider)
        .findById(task.studyPlanId);
    final week = await ref
        .read(availabilityRepositoryProvider)
        .watchWeek(task.studyPlanId)
        .first;
    final exceptions = await ref
        .read(availabilityRepositoryProvider)
        .watchExceptions(task.studyPlanId)
        .first;
    if (mounted) {
      setState(() {
        _task = task;
        _buffer = plan?.planningBufferPercent ?? 15;
        _week = week;
        _exceptions = exceptions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final task = _task;
    if (task == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final today = ref.watch(clockProvider).today();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.moveTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          for (var offset = 1; offset <= 7; offset++)
            _MoveDay(
              date: today.add(Duration(days: offset)),
              taskMinutes: task.plannedMinutes,
              week: _week,
              exceptions: _exceptions,
              buffer: _buffer,
              onPick: (date) => _move(task, date),
            ),
        ],
      ),
    );
  }

  Future<void> _move(StudyTask task, DateTime date) async {
    try {
      await ref
          .read(studyTaskRepositoryProvider)
          .save(
            task.copyWith(
              plannedDate: calendarDate(date),
              isLocked: true,
              updatedAt: ref.read(clockProvider).now(),
            ),
          );
      await reconcileReminders(ref);
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

class _MoveDay extends StatelessWidget {
  const _MoveDay({
    required this.date,
    required this.taskMinutes,
    required this.week,
    required this.exceptions,
    required this.buffer,
    required this.onPick,
  });

  final DateTime date;
  final int taskMinutes;
  final List<WeeklyAvailability> week;
  final List<CalendarException> exceptions;
  final int buffer;
  final ValueChanged<DateTime> onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final capacity = capacityForDate(
      date: date,
      week: week,
      exceptions: exceptions,
      planningBufferPercent: buffer,
    );
    final tight = taskMinutes > capacity.usableMinutes;
    return AppCard(
      onTap: () => onPick(date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleFormat.formatDate(date, Localizations.localeOf(context))),
          Text(
            l10n.capacityFree(
              LocaleFormat.formatDuration(capacity.usableMinutes, l10n),
            ),
          ),
          if (tight) Text(l10n.capacityTight),
        ],
      ),
    );
  }
}

class QuickStudyScreen extends ConsumerStatefulWidget {
  const QuickStudyScreen({super.key});

  @override
  ConsumerState<QuickStudyScreen> createState() => _QuickStudyScreenState();
}

class _QuickStudyScreenState extends ConsumerState<QuickStudyScreen> {
  List<Subject> _subjects = [];
  List<Chapter> _chapters = [];
  String? _subjectId;
  String? _chapterId;
  var _minutes = 45;

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
    final subjects = await ref
        .read(subjectRepositoryProvider)
        .watchByPlan(planId)
        .first;
    if (mounted) {
      setState(() => _subjects = subjects);
    }
  }

  Future<void> _selectSubject(String id) async {
    final chapters = await ref
        .read(chapterRepositoryProvider)
        .watchBySubject(id)
        .first;
    if (mounted) {
      setState(() {
        _subjectId = id;
        _chapters = chapters;
        _chapterId = chapters.isEmpty ? null : chapters.first.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subject = _subjects
        .where((item) => item.id == _subjectId)
        .firstOrNull;
    final chapter = _chapters
        .where((item) => item.id == _chapterId)
        .firstOrNull;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.quickStudyTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.addSubject, style: Theme.of(context).textTheme.titleSmall),
          for (final item in _subjects)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.name),
              trailing: item.id == _subjectId ? const Icon(Icons.check) : null,
              onTap: () => _selectSubject(item.id),
            ),
          if (_chapters.isNotEmpty) ...[
            Text(
              l10n.chaptersTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            for (final item in _chapters)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.title),
                trailing: item.id == _chapterId
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => setState(() => _chapterId = item.id),
              ),
          ],
          Text(l10n.estimatedTime),
          Slider(
            value: _minutes.toDouble(),
            min: 15,
            max: 180,
            divisions: 11,
            label: '$_minutes',
            onChanged: (value) => setState(() => _minutes = value.round()),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.actionStartTimer,
            onPressed: subject == null
                ? null
                : () async {
                    await ref
                        .read(studyTimerControllerProvider.notifier)
                        .start(
                          ActiveStudyTimer(
                            id: ref.read(idGeneratorProvider).next(),
                            subjectId: subject.id,
                            chapterId: chapter?.id,
                            subjectName: subject.name,
                            title: chapter?.title ?? subject.name,
                            plannedMinutes: _minutes,
                            startedAt: ref.read(clockProvider).now(),
                            elapsedBeforeResume: 0,
                            phase: TimerPhase.idle,
                            quickStudy: true,
                          ),
                        );
                    if (context.mounted) {
                      await context.push(AppRoutes.session);
                    }
                  },
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: subject == null
                ? null
                : () async {
                    final now = ref.read(clockProvider).now();
                    final task = StudyTask(
                      id: ref.read(idGeneratorProvider).next(),
                      studyPlanId: subject.studyPlanId,
                      subjectId: subject.id,
                      chapterId: chapter?.id,
                      taskType: TaskType.newStudy,
                      title: chapter?.title ?? subject.name,
                      plannedDate: calendarDate(now),
                      plannedMinutes: _minutes,
                      priorityScore: 0,
                      isLocked: false,
                      status: TaskStatus.planned,
                      completionPercent: 0,
                      source: TaskSource.quickStudy,
                      createdAt: now,
                      updatedAt: now,
                    );
                    try {
                      await ref.read(studyTaskRepositoryProvider).save(task);
                      if (context.mounted) {
                        await context.push(AppRoutes.completeTask(task.id));
                      }
                    } on Object catch (error) {
                      if (context.mounted) {
                        showAppError(context, error);
                      }
                    }
                  },
            child: Text(l10n.actionLogCompleted),
          ),
        ],
      ),
    );
  }
}

Future<void> _commit({
  required WidgetRef ref,
  required StudyTask? task,
  required int plannedMinutes,
  required int actualMinutes,
  required int completionPercent,
  required SessionResult result,
  required String note,
  required Confidence? confidenceAfter,
  required bool needsRevision,
  required bool replanRemaining,
  required DateTime startedAt,
  String? sessionId,
}) async {
  final now = ref.read(clockProvider).now();
  final ids = ref.read(idGeneratorProvider);
  Chapter? chapter;
  Subject? subject;
  if (task != null) {
    subject = await ref
        .read(subjectRepositoryProvider)
        .findById(task.subjectId);
    if (task.chapterId != null) {
      chapter = await ref
          .read(chapterRepositoryProvider)
          .findById(task.chapterId!);
    }
  }
  final session = StudySession(
    id: sessionId ?? ids.next(),
    studyTaskId: task?.id,
    subjectId: task?.subjectId ?? subject?.id ?? '',
    chapterId: task?.chapterId,
    startedAt: startedAt,
    endedAt: now,
    plannedMinutes: plannedMinutes < 1 ? 1 : plannedMinutes,
    actualMinutes: actualMinutes < 0 ? 0 : actualMinutes,
    completionPercent: completionPercent.clamp(0, 100),
    result: result,
    confidenceBefore: chapter?.confidence,
    confidenceAfter: confidenceAfter,
    note: note,
    createdAt: now,
  );
  final plan = applyStudyCompletion(
    session: session,
    task: task,
    chapter: chapter,
    subject: subject,
    needsRevision: needsRevision,
    replanRemaining: replanRemaining,
    now: now,
    studyPlanId: task?.studyPlanId ?? subject?.studyPlanId ?? '',
    followUpTaskId: ids.next(),
    revisionId: ids.next(),
    moreRevisionIds: [ids.next(), ids.next()],
    existingRevisions: chapter == null
        ? const []
        : await ref
              .read(revisionRepositoryProvider)
              .watchByChapter(chapter.id)
              .first,
    examDate: task?.examId == null
        ? null
        : (await ref.read(examRepositoryProvider).findById(task!.examId!))
              ?.startDate,
  );
  await ref.read(studySessionRepositoryProvider).commitCompletion(plan);
  await reconcileReminders(ref);
}

String _clock(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  final rest = (seconds % 60).toString().padLeft(2, '0');
  return '$minutes:$rest';
}
