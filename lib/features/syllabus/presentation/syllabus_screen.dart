import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:porar_sathi/app/router/app_routes.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/widgets/app_card.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/core/database/repository_providers.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/subjects/domain/subject_appearance.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class SyllabusScreen extends ConsumerStatefulWidget {
  const SyllabusScreen({super.key});

  @override
  ConsumerState<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends ConsumerState<SyllabusScreen> {
  List<Subject> _subjects = [];
  Map<String, List<Chapter>> _chapters = {};
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
        setState(() {
          _subjects = [];
          _chapters = {};
          _loading = false;
        });
      }
      return;
    }
    final subjects = await ref.read(subjectRepositoryProvider).watchByPlan(planId).first;
    final chapters = <String, List<Chapter>>{};
    for (final subject in subjects) {
      chapters[subject.id] = await ref.read(chapterRepositoryProvider).watchBySubject(subject.id).first;
    }
    if (mounted) {
      setState(() {
        _subjects = subjects;
        _chapters = chapters;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final allChapters = _chapters.values.expand((rows) => rows).toList();
    final completed = allChapters.where((chapter) => chapter.status == ChapterStatus.completed || chapter.status == ChapterStatus.revised).length;
    final percent = allChapters.isEmpty ? 0 : (completed * 100 / allChapters.length).round();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSyllabus),
        actions: [
          IconButton(
            tooltip: l10n.examsTitle,
            onPressed: () async {
              await context.push(AppRoutes.exams);
              await _load();
            },
            icon: const Icon(Icons.event_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push(AppRoutes.newSubject);
          await _load();
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addSubject),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _subjects.isEmpty
          ? EmptyState(
              icon: Icons.menu_book_outlined,
              title: l10n.noSubjectsTitle,
              body: l10n.noSubjectsBody,
            )
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.syllabusCompleted, style: Theme.of(context).textTheme.titleSmall),
                      Text('$percent%', style: Theme.of(context).textTheme.headlineMedium),
                      Text(l10n.chaptersProgress(completed, allChapters.length)),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                for (final subject in _subjects) ...[
                  _SubjectRow(
                    subject: subject,
                    chapters: _chapters[subject.id] ?? const [],
                    onTap: () async {
                      await context.push(AppRoutes.subject(subject.id));
                      await _load();
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ],
            ),
    );
  }
}

class _SubjectRow extends StatelessWidget {
  const _SubjectRow({
    required this.subject,
    required this.chapters,
    required this.onTap,
  });

  final Subject subject;
  final List<Chapter> chapters;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final done = chapters.where((chapter) => chapter.status == ChapterStatus.completed || chapter.status == ChapterStatus.revised).length;
    final percent = chapters.isEmpty ? 0 : (done * 100 / chapters.length).round();
    final color = SubjectAppearance.colorFor(subject.colorToken);
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(SubjectAppearance.iconFor(subject.iconToken), color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject.name, style: Theme.of(context).textTheme.titleMedium),
                Text('$percent%'),
                LinearProgressIndicator(value: percent / 100, color: color),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
