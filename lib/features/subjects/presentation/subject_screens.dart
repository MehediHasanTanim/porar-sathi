import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_error.dart';
import 'package:porar_sathi/app/widgets/confirm_dialog.dart';
import 'package:porar_sathi/app/widgets/option_chips.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/core/time/clock_provider.dart';
import 'package:porar_sathi/core/utils/id_generator.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/subjects/domain/subject_appearance.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class SubjectFormScreen extends ConsumerStatefulWidget {
  const SubjectFormScreen({this.subjectId, super.key});

  final String? subjectId;

  @override
  ConsumerState<SubjectFormScreen> createState() => _SubjectFormScreenState();
}

class _SubjectFormScreenState extends ConsumerState<SubjectFormScreen> {
  final _name = TextEditingController();
  final _code = TextEditingController();
  final _paper = TextEditingController();
  var _priority = Priority.normal;
  var _difficulty = Difficulty.moderate;
  var _confidence = Confidence.medium;
  var _color = SubjectAppearance.colorTokens.first;
  var _icon = SubjectAppearance.iconTokens.first;
  Subject? _existing;
  var _loaded = false;

  @override
  void dispose() {
    _name.dispose();
    _code.dispose();
    _paper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!_loaded) {
      _loaded = true;
      _load();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectId == null ? l10n.addSubject : l10n.editSubject),
        actions: [
          TextButton(onPressed: _save, child: Text(l10n.actionSave)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          LabeledField(label: l10n.subjectName, child: TextField(controller: _name)),
          const SizedBox(height: AppSpacing.md),
          LabeledField(label: l10n.subjectCode, child: TextField(controller: _code)),
          const SizedBox(height: AppSpacing.md),
          LabeledField(label: l10n.paperName, child: TextField(controller: _paper)),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.color,
            child: Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final token in SubjectAppearance.colorTokens)
                  GestureDetector(
                    onTap: () => setState(() => _color = token),
                    child: CircleAvatar(
                      backgroundColor: SubjectAppearance.colorFor(token),
                      child: _color == token ? const Icon(Icons.check, color: Colors.white) : null,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledField(
            label: l10n.icon,
            child: Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final token in SubjectAppearance.iconTokens)
                  IconButton(
                    isSelected: _icon == token,
                    onPressed: () => setState(() => _icon = token),
                    icon: Icon(SubjectAppearance.iconFor(token)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.priority),
          OptionChips(
            labels: [l10n.priorityLow, l10n.priorityNormal, l10n.priorityHigh, l10n.priorityCritical],
            selectedIndex: Priority.values.indexOf(_priority),
            onSelected: (index) => setState(() => _priority = Priority.values[index]),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.difficulty),
          OptionChips(
            labels: [l10n.difficultyEasy, l10n.difficultyModerate, l10n.difficultyHard],
            selectedIndex: switch (_difficulty) {
              Difficulty.veryEasy || Difficulty.easy => 0,
              Difficulty.difficult || Difficulty.veryDifficult => 2,
              _ => 1,
            },
            onSelected: (index) => setState(() {
              _difficulty = [Difficulty.easy, Difficulty.moderate, Difficulty.difficult][index];
            }),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.confidence),
          OptionChips(
            labels: [l10n.confidenceLow, l10n.confidenceMedium, l10n.confidenceHigh],
            selectedIndex: switch (_confidence) {
              Confidence.veryLow || Confidence.low => 0,
              Confidence.high || Confidence.veryHigh => 2,
              _ => 1,
            },
            onSelected: (index) => setState(() {
              _confidence = [Confidence.low, Confidence.medium, Confidence.high][index];
            }),
          ),
          if (_existing != null) ...[
            const SizedBox(height: AppSpacing.xl),
            OutlinedButton(
              onPressed: _archive,
              child: Text(l10n.archiveSubject),
            ),
            TextButton(
              onPressed: _delete,
              child: Text(l10n.deleteSubject),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _load() async {
    final id = widget.subjectId;
    if (id == null) {
      return;
    }
    final subject = await ref.read(subjectRepositoryProvider).findById(id);
    if (subject == null || !mounted) {
      return;
    }
    setState(() {
      _existing = subject;
      _name.text = subject.name;
      _code.text = subject.code ?? '';
      _paper.text = subject.paperName ?? '';
      _priority = subject.priority;
      _difficulty = subject.difficulty;
      _confidence = subject.confidence;
      _color = subject.colorToken;
      _icon = subject.iconToken;
    });
  }

  Future<void> _save() async {
    try {
      final settings = await ref.read(settingsControllerProvider.future);
      final planId = settings.currentStudyPlanId;
      if (planId == null) {
        throw const DatabaseException(message: 'Study plan was not found.');
      }
      final clock = ref.read(clockProvider);
      final existing = _existing;
      final subject = Subject(
        id: existing?.id ?? ref.read(idGeneratorProvider).next(),
        studyPlanId: planId,
        name: _name.text,
        code: _code.text,
        paperName: _paper.text,
        colorToken: _color,
        iconToken: _icon,
        priority: _priority,
        difficulty: _difficulty,
        confidence: _confidence,
        status: existing?.status ?? SubjectStatus.active,
        sortOrder: existing?.sortOrder ?? 0,
        createdAt: existing?.createdAt ?? clock.now(),
        updatedAt: clock.now(),
      );
      await ref.read(subjectRepositoryProvider).save(subject);
      if (mounted) {
        context.pop();
      }
    } on Object catch (error) {
      if (mounted) {
        showAppError(context, error);
      }
    }
  }

  Future<void> _archive() async {
    final existing = _existing;
    if (existing == null) {
      return;
    }
    await ref.read(subjectRepositoryProvider).archive(
      existing.id,
      archivedAt: ref.read(clockProvider).now(),
    );
    if (mounted) {
      context.pop();
    }
  }

  Future<void> _delete() async {
    final existing = _existing;
    if (existing == null) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmAction(
      context,
      title: l10n.deleteSubjectTitle(existing.name),
      body: l10n.deleteSubjectBody,
      confirmLabel: l10n.actionDelete,
    );
    if (!confirmed || !mounted) {
      return;
    }
    try {
      await ref.read(subjectRepositoryProvider).delete(existing.id);
      if (mounted) {
        context.go(AppRoutes.syllabus);
      }
    } on DatabaseException catch (error) {
      if (!mounted) {
        return;
      }
      if (error.message?.contains('Study history') != true) {
        showAppError(context, error);
        return;
      }
      final erase = await confirmAction(
        context,
        title: l10n.deleteSubjectTitle(existing.name),
        body: l10n.deleteHistoryBody,
        confirmLabel: l10n.actionDeleteHistory,
      );
      if (!erase) {
        return;
      }
      await ref.read(subjectRepositoryProvider).delete(existing.id, includeHistory: true);
      if (mounted) {
        context.go(AppRoutes.syllabus);
      }
    }
  }
}

class SubjectDetailsScreen extends ConsumerStatefulWidget {
  const SubjectDetailsScreen({required this.subjectId, super.key});

  final String subjectId;

  @override
  ConsumerState<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends ConsumerState<SubjectDetailsScreen> {
  Subject? _subject;
  var _chapterCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final subject = await ref.read(subjectRepositoryProvider).findById(widget.subjectId);
    final chapters = await ref.read(chapterRepositoryProvider).watchBySubject(widget.subjectId).first;
    if (mounted) {
      setState(() {
        _subject = subject;
        _chapterCount = chapters.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subject = _subject;
    if (subject == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final color = SubjectAppearance.colorFor(subject.colorToken);
    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(AppRoutes.editSubject(subject.id));
              await _load();
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(SubjectAppearance.iconFor(subject.iconToken), color: color),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.chaptersProgress(_chapterCount, _chapterCount)),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: () => context.push(AppRoutes.chapters(subject.id)),
            child: Text(l10n.chaptersTitle),
          ),
        ],
      ),
    );
  }
}
