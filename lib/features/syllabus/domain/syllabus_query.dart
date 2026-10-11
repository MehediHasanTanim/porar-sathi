import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

/// In-memory subject and chapter search. The syllabus fits on the device,
/// so this does not use a full-text index.
class SyllabusQuery {
  const SyllabusQuery({
    this.text = '',
    this.status,
    this.difficulty,
    this.confidence,
  });

  final String text;
  final ChapterStatus? status;
  final Difficulty? difficulty;
  final Confidence? confidence;

  bool get hasText => text.trim().isNotEmpty;

  bool get hasFilters =>
      status != null || difficulty != null || confidence != null;

  bool get isActive => hasText || hasFilters;

  SyllabusQuery copyWith({
    String? text,
    ChapterStatus? status,
    Difficulty? difficulty,
    Confidence? confidence,
    bool clearStatus = false,
    bool clearDifficulty = false,
    bool clearConfidence = false,
  }) {
    return SyllabusQuery(
      text: text ?? this.text,
      status: clearStatus ? null : status ?? this.status,
      difficulty: clearDifficulty ? null : difficulty ?? this.difficulty,
      confidence: clearConfidence ? null : confidence ?? this.confidence,
    );
  }
}

class SyllabusMatch {
  const SyllabusMatch({required this.subject, required this.chapters});

  final Subject subject;
  final List<Chapter> chapters;
}

List<Chapter> filterChapters(List<Chapter> chapters, SyllabusQuery query) {
  final text = query.text.trim().toLowerCase();
  return [
    for (final chapter in chapters)
      if (_attributesMatch(chapter, query) &&
          (text.isEmpty || chapter.title.toLowerCase().contains(text)))
        chapter,
  ];
}

/// A subject is included when its name matches, or when one of its chapters does.
/// Attribute filters still apply to the chapters that are shown.
List<SyllabusMatch> searchSyllabus({
  required List<Subject> subjects,
  required Map<String, List<Chapter>> chaptersBySubject,
  required SyllabusQuery query,
}) {
  final text = query.text.trim().toLowerCase();
  final matches = <SyllabusMatch>[];
  for (final subject in subjects) {
    final chapters = chaptersBySubject[subject.id] ?? const <Chapter>[];
    final nameHit = text.isEmpty || subject.name.toLowerCase().contains(text);
    final passing = [
      for (final chapter in chapters)
        if (_attributesMatch(chapter, query)) chapter,
    ];
    if (nameHit) {
      if (query.hasFilters && passing.isEmpty) {
        continue;
      }
      matches.add(
        SyllabusMatch(
          subject: subject,
          chapters: query.hasFilters ? passing : chapters,
        ),
      );
      continue;
    }
    final titled = [
      for (final chapter in passing)
        if (chapter.title.toLowerCase().contains(text)) chapter,
    ];
    if (titled.isNotEmpty) {
      matches.add(SyllabusMatch(subject: subject, chapters: titled));
    }
  }
  return matches;
}

bool _attributesMatch(Chapter chapter, SyllabusQuery query) {
  if (query.status != null && chapter.status != query.status) {
    return false;
  }
  if (query.difficulty != null && chapter.difficulty != query.difficulty) {
    return false;
  }
  if (query.confidence != null && chapter.confidence != query.confidence) {
    return false;
  }
  return true;
}
