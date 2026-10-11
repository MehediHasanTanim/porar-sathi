import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/notifications/application/reconcile_reminders.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/application/study_timer_controller.dart';
import 'package:porar_sathi/features/sessions/domain/study_timer.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

enum RevisionBucket { dueToday, overdue, upcoming }

RevisionBucket revisionBucket(RevisionSchedule schedule, DateTime today) {
  final due = calendarDate(schedule.dueDate);
  final day = calendarDate(today);
  if (schedule.status == RevisionStatus.overdue || due.isBefore(day)) {
    return RevisionBucket.overdue;
  }
  if (due == day) {
    return RevisionBucket.dueToday;
  }
  return RevisionBucket.upcoming;
}

class RevisionQueueScreen extends ConsumerStatefulWidget {
  const RevisionQueueScreen({super.key});

  @override
  ConsumerState<RevisionQueueScreen> createState() =>
      _RevisionQueueScreenState();
}

class _RevisionQueueScreenState extends ConsumerState<RevisionQueueScreen> {
  List<RevisionSchedule> _revisions = [];
  Map<String, Chapter> _chapters = {};
  Map<String, Subject> _subjects = {};
  var _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final settings = await ref.read(settingsControllerProvider.future);
    final planId = settings.currentStudyPlanId;
    if (planId == null) {
      if (mounted) {
        setState(() => _loading = false);
      }
      return;
    }
    final revisions = await ref
        .read(revisionRepositoryProvider)
        .listByPlan(planId);
    final subjects = await ref
        .read(subjectRepositoryProvider)
        .watchByPlan(planId, includeArchived: true)
        .first;
    final chapters = await ref
        .read(chapterRepositoryProvider)
        .listByPlan(planId);
    if (mounted) {
      setState(() {
        _revisions = [
          for (final revision in revisions)
            if (revision.status != RevisionStatus.completed &&
                revision.status != RevisionStatus.skipped)
              revision,
        ];
        _subjects = {for (final subject in subjects) subject.id: subject};
        _chapters = {for (final chapter in chapters) chapter.id: chapter};
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final today = ref.watch(clockProvider).today();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.revisionQueue),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.dueToday),
              Tab(text: l10n.overdue),
              Tab(text: l10n.upcoming),
            ],
          ),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  for (final bucket in RevisionBucket.values)
                    _RevisionList(
                      revisions: [
                        for (final revision in _revisions)
                          if (revisionBucket(revision, today) == bucket)
                            revision,
                      ],
                      chapters: _chapters,
                      subjects: _subjects,
                      onOpen: (id) async {
                        await context.push(AppRoutes.revision(id));
                        await _load();
                      },
                    ),
                ],
              ),
      ),
    );
  }
}

class _RevisionList extends StatelessWidget {
  const _RevisionList({
    required this.revisions,
    required this.chapters,
    required this.subjects,
    required this.onOpen,
  });

  final List<RevisionSchedule> revisions;
  final Map<String, Chapter> chapters;
  final Map<String, Subject> subjects;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (revisions.isEmpty) {
      return EmptyState(
        icon: Icons.replay_outlined,
        title: l10n.revisionQueue,
        body: l10n.revisionEmpty,
      );
    }
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        for (final revision in revisions) ...[
          AppCard(
            onTap: () => onOpen(revision.id),
            child: _RevisionSummary(
              revision: revision,
              chapter: chapters[revision.chapterId],
              subject: subjects[chapters[revision.chapterId]?.subjectId],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _RevisionSummary extends StatelessWidget {
  const _RevisionSummary({
    required this.revision,
    required this.chapter,
    required this.subject,
  });

  final RevisionSchedule revision;
  final Chapter? chapter;
  final Subject? subject;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subject?.name ?? l10n.revisionQueue,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(chapter?.title ?? revision.chapterId),
        Text(LocaleFormat.formatDuration(revision.estimatedMinutes, l10n)),
        if (chapter != null) Text(l10n.confidence),
        if (chapter != null) Text(_confidenceLabel(chapter!.confidence)),
      ],
    );
  }
}

class RevisionDetailScreen extends ConsumerStatefulWidget {
  const RevisionDetailScreen({required this.revisionId, super.key});

  final String revisionId;

  @override
  ConsumerState<RevisionDetailScreen> createState() =>
      _RevisionDetailScreenState();
}

class _RevisionDetailScreenState extends ConsumerState<RevisionDetailScreen> {
  RevisionSchedule? _revision;
  Chapter? _chapter;
  Subject? _subject;
  var _previous = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final revision = await ref
        .read(revisionRepositoryProvider)
        .findById(widget.revisionId);
    if (revision == null || !mounted) {
      return;
    }
    final chapter = await ref
        .read(chapterRepositoryProvider)
        .findById(revision.chapterId);
    final subject = chapter == null
        ? null
        : await ref.read(subjectRepositoryProvider).findById(chapter.subjectId);
    final history = await ref
        .read(revisionRepositoryProvider)
        .watchByChapter(revision.chapterId)
        .first;
    if (mounted) {
      setState(() {
        _revision = revision;
        _chapter = chapter;
        _subject = subject;
        _previous = history
            .where((item) => item.status == RevisionStatus.completed)
            .length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final revision = _revision;
    final chapter = _chapter;
    if (revision == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(_subject?.name ?? l10n.revisionQueue)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            chapter?.title ?? revision.chapterId,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(LocaleFormat.formatDate(revision.dueDate, locale)),
          Text(LocaleFormat.formatDuration(revision.estimatedMinutes, l10n)),
          if (chapter?.updatedAt != null)
            Text(
              l10n.lastStudied(
                LocaleFormat.formatDate(chapter!.updatedAt, locale),
              ),
            ),
          Text(l10n.previousRevisions(_previous)),
          if (chapter != null) Text(_confidenceLabel(chapter.confidence)),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: l10n.actionStartRevision, onPressed: _start),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: _reschedule,
            child: Text(l10n.actionReschedule),
          ),
          OutlinedButton(
            onPressed: () =>
                _update(revision.copyWith(status: RevisionStatus.skipped)),
            child: Text(l10n.actionSkip),
          ),
        ],
      ),
    );
  }

  Future<void> _start() async {
    final revision = _revision;
    final chapter = _chapter;
    final subject = _subject;
    if (revision == null || chapter == null || subject == null) {
      return;
    }
    final now = ref.read(clockProvider).now();
    final task = StudyTask(
      id: ref.read(idGeneratorProvider).next(),
      studyPlanId: revision.studyPlanId,
      subjectId: subject.id,
      chapterId: chapter.id,
      taskType: TaskType.revision,
      title: chapter.title,
      plannedDate: calendarDate(now),
      plannedMinutes: revision.estimatedMinutes,
      priorityScore: 0,
      isLocked: false,
      status: TaskStatus.planned,
      completionPercent: 0,
      source: TaskSource.revisionEngine,
      createdAt: now,
      updatedAt: now,
    );
    try {
      await ref.read(studyTaskRepositoryProvider).save(task);
      await ref
          .read(studyTimerControllerProvider.notifier)
          .start(
            ActiveStudyTimer(
              id: ref.read(idGeneratorProvider).next(),
              taskId: task.id,
              subjectId: subject.id,
              chapterId: chapter.id,
              subjectName: subject.name,
              title: chapter.title,
              plannedMinutes: revision.estimatedMinutes,
              startedAt: now,
              elapsedBeforeResume: 0,
              phase: TimerPhase.idle,
              revisionId: revision.id,
            ),
          );
      if (mounted) {
        await context.push(AppRoutes.session);
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }

  Future<void> _reschedule() async {
    final revision = _revision;
    if (revision == null) {
      return;
    }
    final today = ref.read(clockProvider).today();
    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (sheetContext) {
        return ListView(
          children: [
            for (var offset = 1; offset <= 14; offset++)
              ListTile(
                title: Text(
                  LocaleFormat.formatDate(
                    today.add(Duration(days: offset)),
                    Localizations.localeOf(sheetContext),
                  ),
                ),
                onTap: () => Navigator.pop(
                  sheetContext,
                  today.add(Duration(days: offset)),
                ),
              ),
          ],
        );
      },
    );
    if (picked == null) {
      return;
    }
    await _update(
      revision.copyWith(
        dueDate: calendarDate(picked),
        status: RevisionStatus.scheduled,
      ),
    );
  }

  Future<void> _update(RevisionSchedule revision) async {
    try {
      await ref.read(revisionRepositoryProvider).save(revision);
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

class RevisionCompleteScreen extends ConsumerStatefulWidget {
  const RevisionCompleteScreen({super.key});

  @override
  ConsumerState<RevisionCompleteScreen> createState() =>
      _RevisionCompleteScreenState();
}

class _RevisionCompleteScreenState
    extends ConsumerState<RevisionCompleteScreen> {
  var _confidence = 2;
  var _another = true;
  RevisionSchedule? _next;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final timer = ref.read(studyTimerControllerProvider).asData?.value;
    final revisionId = timer?.revisionId;
    if (revisionId == null) {
      return;
    }
    final current = await ref
        .read(revisionRepositoryProvider)
        .findById(revisionId);
    if (current == null) {
      return;
    }
    final history = await ref
        .read(revisionRepositoryProvider)
        .watchByChapter(current.chapterId)
        .first;
    RevisionSchedule? next;
    for (final item in history) {
      if (item.revisionNumber <= current.revisionNumber) {
        continue;
      }
      if (item.status == RevisionStatus.completed ||
          item.status == RevisionStatus.skipped) {
        continue;
      }
      next = item;
      break;
    }
    if (mounted) {
      setState(() => _next = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.revisionCompleteTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.confidenceNow),
          OptionChips(
            labels: const ['1', '2', '3', '4', '5'],
            selectedIndex: _confidence,
            onSelected: (index) => setState(() => _confidence = index),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.needAnotherRevision),
            value: _another,
            onChanged: (value) => setState(() => _another = value),
          ),
          if (_next != null)
            Text(
              l10n.nextRevision(
                LocaleFormat.formatDate(_next!.dueDate, locale),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: l10n.actionDone, onPressed: _save),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final timer = ref.read(studyTimerControllerProvider).asData?.value;
    final revisionId = timer?.revisionId;
    if (revisionId == null) {
      return;
    }
    try {
      final current = await ref
          .read(revisionRepositoryProvider)
          .findById(revisionId);
      if (current == null) {
        return;
      }
      final now = ref.read(clockProvider).now();
      await ref
          .read(revisionRepositoryProvider)
          .save(
            current.copyWith(
              status: RevisionStatus.completed,
              completedAt: now,
            ),
          );
      final chapter = await ref
          .read(chapterRepositoryProvider)
          .findById(current.chapterId);
      if (chapter != null) {
        await ref
            .read(chapterRepositoryProvider)
            .save(
              chapter.copyWith(
                confidence: Confidence.values[_confidence],
                updatedAt: now,
              ),
            );
      }
      if (!_another) {
        final history = await ref
            .read(revisionRepositoryProvider)
            .watchByChapter(current.chapterId)
            .first;
        final later = [
          for (final item in history)
            if (item.revisionNumber > current.revisionNumber &&
                item.status != RevisionStatus.completed &&
                item.status != RevisionStatus.skipped)
              item.copyWith(status: RevisionStatus.skipped),
        ];
        if (later.isNotEmpty) {
          await ref.read(revisionRepositoryProvider).saveAll(later);
        }
      }
      await reconcileReminders(ref);
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

String _confidenceLabel(Confidence confidence) {
  return switch (confidence) {
    Confidence.veryLow => '1',
    Confidence.low => '2',
    Confidence.medium => '3',
    Confidence.high => '4',
    Confidence.veryHigh => '5',
  };
}
