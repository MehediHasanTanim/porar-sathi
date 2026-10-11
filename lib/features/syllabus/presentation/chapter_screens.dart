import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/app_states.dart';
import 'package:porar_sathi/app/widgets/confirm_dialog.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/features/syllabus/domain/syllabus_query.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class ChapterListScreen extends ConsumerStatefulWidget {
  const ChapterListScreen({required this.subjectId, super.key});

  final String subjectId;

  @override
  ConsumerState<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends ConsumerState<ChapterListScreen> {
  List<Chapter> _chapters = [];
  ChapterStatus? _filter;
  final _search = TextEditingController();
  var _loading = true;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final chapters = await ref
        .read(chapterRepositoryProvider)
        .watchBySubject(widget.subjectId)
        .first;
    if (mounted) {
      setState(() {
        _chapters = chapters;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final visible = filterChapters(
      _chapters,
      SyllabusQuery(text: _search.text, status: _filter),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chaptersTitle),
        actions: [
          IconButton(
            tooltip: l10n.bulkAddChapters,
            onPressed: () async {
              await context.push('/subjects/${widget.subjectId}/chapters/bulk');
              await _load();
            },
            icon: const Icon(Icons.playlist_add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.addChapter,
        onPressed: () async {
          await context.push('/subjects/${widget.subjectId}/chapters/new');
          await _load();
        },
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const LoadingState()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    0,
                  ),
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      labelText: l10n.searchChapters,
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    children: [
                      FilterChip(
                        label: Text(l10n.filterAll),
                        selected: _filter == null,
                        onSelected: (_) => setState(() => _filter = null),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      FilterChip(
                        label: Text(l10n.notStarted),
                        selected: _filter == ChapterStatus.notStarted,
                        onSelected: (_) =>
                            setState(() => _filter = ChapterStatus.notStarted),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      FilterChip(
                        label: Text(l10n.inProgress),
                        selected: _filter == ChapterStatus.inProgress,
                        onSelected: (_) =>
                            setState(() => _filter = ChapterStatus.inProgress),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      FilterChip(
                        label: Text(l10n.completed),
                        selected: _filter == ChapterStatus.completed,
                        onSelected: (_) =>
                            setState(() => _filter = ChapterStatus.completed),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: visible.isEmpty
                      ? _search.text.trim().isEmpty && _filter == null
                            ? EmptyState(
                                icon: Icons.list_alt,
                                title: l10n.noChaptersTitle,
                                body: l10n.noChaptersBody,
                                primaryLabel: l10n.addChapter,
                                onPrimary: () async {
                                  await context.push(
                                    '/subjects/${widget.subjectId}/chapters/new',
                                  );
                                  await _load();
                                },
                              )
                            : NoSearchResults(
                                query: _search.text.trim().isEmpty
                                    ? l10n.filters
                                    : _search.text.trim(),
                                onClear: () {
                                  _search.clear();
                                  setState(() => _filter = null);
                                },
                              )
                      : ReorderableListView.builder(
                          itemCount: visible.length,
                          onReorderItem: (oldIndex, newIndex) =>
                              _reorder(visible, oldIndex, newIndex),
                          itemBuilder: (context, index) {
                            final chapter = visible[index];
                            return ListTile(
                              key: ValueKey(chapter.id),
                              title: Text(chapter.title),
                              subtitle: Text(
                                LocaleFormat.formatDuration(
                                  chapter.estimatedMinutes,
                                  l10n,
                                ),
                              ),
                              trailing: Icon(
                                Icons.drag_handle,
                                semanticLabel: l10n.chapterStatus,
                              ),
                              onTap: () async {
                                await context.push(
                                  '/subjects/${widget.subjectId}/chapters/${chapter.id}',
                                );
                                await _load();
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Future<void> _reorder(
    List<Chapter> visible,
    int oldIndex,
    int newIndex,
  ) async {
    final reordered = [...visible];
    final moving = reordered.removeAt(oldIndex);
    reordered.insert(newIndex.clamp(0, reordered.length), moving);
    final visibleIds = {for (final chapter in visible) chapter.id};
    var visibleIndex = 0;
    final next = [
      for (final chapter in _chapters)
        if (visibleIds.contains(chapter.id))
          reordered[visibleIndex++]
        else
          chapter,
    ];
    final clock = ref.read(clockProvider).now();
    final sorted = [
      for (var index = 0; index < next.length; index++)
        next[index].copyWith(sortOrder: index, updatedAt: clock),
    ];
    await ref.read(chapterRepositoryProvider).saveAll(sorted);
    await _load();
  }
}

class ChapterFormScreen extends ConsumerStatefulWidget {
  const ChapterFormScreen({required this.subjectId, this.chapterId, super.key});

  final String subjectId;
  final String? chapterId;

  @override
  ConsumerState<ChapterFormScreen> createState() => _ChapterFormScreenState();
}

class _ChapterFormScreenState extends ConsumerState<ChapterFormScreen> {
  final _title = TextEditingController();
  final _number = TextEditingController();
  final _notes = TextEditingController();
  var _minutes = 60;
  var _difficulty = Difficulty.moderate;
  var _confidence = Confidence.medium;
  var _priority = Priority.normal;
  var _importance = Priority.normal;
  var _status = ChapterStatus.notStarted;
  Chapter? _existing;
  var _loaded = false;
  var _dirty = false;
  var _ready = false;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _title.addListener(_markDirty);
    _number.addListener(_markDirty);
    _notes.addListener(_markDirty);
    if (widget.chapterId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _ready = true);
    }
  }

  void _markDirty() {
    if (!_ready || _dirty || !mounted) {
      return;
    }
    setState(() => _dirty = true);
  }

  @override
  void dispose() {
    _title.dispose();
    _number.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!_loaded) {
      _loaded = true;
      _load();
    }
    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop || !context.mounted) {
          return;
        }
        final discard = await confirmDiscard(context);
        if (discard && context.mounted) {
          setState(() => _dirty = false);
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.chapterId == null ? l10n.addChapter : l10n.editChapter,
          ),
          actions: [
            TextButton(
              onPressed: _saving ? null : _save,
              child: Text(_saving ? l10n.stateSaving : l10n.actionSave),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            LabeledField(
              label: l10n.chapterTitleLabel,
              child: TextField(controller: _title),
            ),
            const SizedBox(height: AppSpacing.md),
            LabeledField(
              label: l10n.chapterNumber,
              child: TextField(
                controller: _number,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.estimatedTime),
            OptionChips(
              labels: const ['30', '60', '120', '180', '240'],
              selectedIndex: [30, 60, 120, 180, 240].contains(_minutes)
                  ? [30, 60, 120, 180, 240].indexOf(_minutes)
                  : 1,
              onSelected: (index) => setState(() {
                _minutes = [30, 60, 120, 180, 240][index];
                _dirty = true;
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.difficulty),
            OptionChips(
              labels: [
                l10n.difficultyEasy,
                l10n.difficultyModerate,
                l10n.difficultyHard,
              ],
              selectedIndex: switch (_difficulty) {
                Difficulty.veryEasy || Difficulty.easy => 0,
                Difficulty.difficult || Difficulty.veryDifficult => 2,
                _ => 1,
              },
              onSelected: (index) => setState(() {
                _difficulty = [
                  Difficulty.easy,
                  Difficulty.moderate,
                  Difficulty.difficult,
                ][index];
                _dirty = true;
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.confidence),
            OptionChips(
              labels: [
                l10n.confidenceLow,
                l10n.confidenceMedium,
                l10n.confidenceHigh,
              ],
              selectedIndex: switch (_confidence) {
                Confidence.veryLow || Confidence.low => 0,
                Confidence.high || Confidence.veryHigh => 2,
                _ => 1,
              },
              onSelected: (index) => setState(() {
                _confidence = [
                  Confidence.low,
                  Confidence.medium,
                  Confidence.high,
                ][index];
                _dirty = true;
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.priority),
            OptionChips(
              labels: [
                l10n.priorityLow,
                l10n.priorityNormal,
                l10n.priorityHigh,
                l10n.priorityCritical,
              ],
              selectedIndex: Priority.values.indexOf(_priority),
              onSelected: (index) => setState(() {
                _priority = Priority.values[index];
                _dirty = true;
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.examImportance),
            OptionChips(
              labels: [
                l10n.priorityLow,
                l10n.priorityNormal,
                l10n.priorityHigh,
                l10n.priorityCritical,
              ],
              selectedIndex: Priority.values.indexOf(_importance),
              onSelected: (index) => setState(() {
                _importance = Priority.values[index];
                _dirty = true;
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.chapterStatus),
            OptionChips(
              labels: [
                l10n.notStarted,
                l10n.inProgress,
                l10n.completed,
                l10n.revisionDue,
                l10n.skipped,
              ],
              selectedIndex: switch (_status) {
                ChapterStatus.inProgress || ChapterStatus.planned => 1,
                ChapterStatus.completed || ChapterStatus.revised => 2,
                ChapterStatus.revisionDue => 3,
                ChapterStatus.skipped => 4,
                _ => 0,
              },
              onSelected: (index) => setState(() {
                _status = [
                  ChapterStatus.notStarted,
                  ChapterStatus.inProgress,
                  ChapterStatus.completed,
                  ChapterStatus.revisionDue,
                  ChapterStatus.skipped,
                ][index];
                _dirty = true;
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            LabeledField(
              label: l10n.notes,
              child: TextField(controller: _notes, maxLines: 3),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _load() async {
    final id = widget.chapterId;
    if (id == null) {
      return;
    }
    final chapter = await ref.read(chapterRepositoryProvider).findById(id);
    if (chapter == null || !mounted) {
      return;
    }
    setState(() {
      _existing = chapter;
      _title.text = chapter.title;
      _number.text = chapter.chapterNumber?.toString() ?? '';
      _notes.text = chapter.notes ?? '';
      _minutes = chapter.estimatedMinutes;
      _difficulty = chapter.difficulty;
      _confidence = chapter.confidence;
      _priority = chapter.priority;
      _importance = chapter.examImportance;
      _status = chapter.status;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _ready = true);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final clock = ref.read(clockProvider);
      final existing = _existing;
      final finished =
          _status == ChapterStatus.completed ||
          _status == ChapterStatus.revised;
      final chapter = Chapter(
        id: existing?.id ?? ref.read(idGeneratorProvider).next(),
        subjectId: widget.subjectId,
        title: _title.text,
        chapterNumber: int.tryParse(_number.text),
        estimatedMinutes: _minutes,
        completedMinutes: existing?.completedMinutes ?? 0,
        difficulty: _difficulty,
        confidence: _confidence,
        priority: _priority,
        examImportance: _importance,
        status: _status,
        notes: _notes.text,
        sortOrder: existing?.sortOrder ?? 0,
        createdAt: existing?.createdAt ?? clock.now(),
        updatedAt: clock.now(),
        completedAt: finished ? (existing?.completedAt ?? clock.now()) : null,
      );
      await ref.read(chapterRepositoryProvider).save(chapter);
      if (mounted) {
        setState(() {
          _dirty = false;
          _saving = false;
        });
        showSaveSuccess(context);
        context.pop();
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
        await showSaveFailed(context, onRetry: _save);
      }
    }
  }
}

class BulkChaptersScreen extends ConsumerStatefulWidget {
  const BulkChaptersScreen({required this.subjectId, super.key});

  final String subjectId;

  @override
  ConsumerState<BulkChaptersScreen> createState() => _BulkChaptersScreenState();
}

class _BulkChaptersScreenState extends ConsumerState<BulkChaptersScreen> {
  final _text = TextEditingController();
  var _lines = <String>[];

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bulkAddChapters)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            TextField(
              controller: _text,
              maxLines: 8,
              decoration: InputDecoration(hintText: l10n.bulkPlaceholder),
              onChanged: (value) => setState(() {
                _lines = value
                    .split('\n')
                    .map((line) => line.trim())
                    .where((line) => line.isNotEmpty)
                    .toList();
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: ListView(
                children: [
                  for (final line in _lines) ListTile(title: Text(line)),
                ],
              ),
            ),
            FilledButton(
              onPressed: _lines.isEmpty ? null : _create,
              child: Text(l10n.createChapters(_lines.length)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _create() async {
    try {
      final existing = await ref
          .read(chapterRepositoryProvider)
          .watchBySubject(widget.subjectId)
          .first;
      final clock = ref.read(clockProvider);
      final ids = ref.read(idGeneratorProvider);
      final chapters = [
        for (var index = 0; index < _lines.length; index++)
          Chapter(
            id: ids.next(),
            subjectId: widget.subjectId,
            title: _lines[index],
            chapterNumber: existing.length + index + 1,
            estimatedMinutes: 60,
            completedMinutes: 0,
            difficulty: Difficulty.moderate,
            confidence: Confidence.medium,
            priority: Priority.normal,
            examImportance: Priority.normal,
            status: ChapterStatus.notStarted,
            sortOrder: existing.length + index,
            createdAt: clock.now(),
            updatedAt: clock.now(),
          ),
      ];
      await ref.read(chapterRepositoryProvider).saveAll(chapters);
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
