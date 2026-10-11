import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/features/syllabus/domain/syllabus_query.dart';

void main() {
  final physics = _subject('physics', 'Physics');
  final chemistry = _subject('chemistry', 'Chemistry');
  final chapters = {
    physics.id: [
      _chapter('vector', physics.id, 'Vector', Difficulty.difficult, Confidence.low),
      _chapter('motion', physics.id, 'Motion', Difficulty.easy, Confidence.high),
    ],
    chemistry.id: [
      _chapter('organic', chemistry.id, 'Organic', Difficulty.moderate, Confidence.medium),
    ],
  };

  test('search matches a subject name and a chapter title', () {
    final bySubject = searchSyllabus(
      subjects: [physics, chemistry],
      chaptersBySubject: chapters,
      query: const SyllabusQuery(text: 'phys'),
    );
    expect(bySubject.map((match) => match.subject.name), ['Physics']);
    expect(bySubject.single.chapters, hasLength(2));

    final byChapter = searchSyllabus(
      subjects: [physics, chemistry],
      chaptersBySubject: chapters,
      query: const SyllabusQuery(text: 'vector'),
    );
    expect(byChapter.single.chapters.single.title, 'Vector');
  });

  test('status, difficulty, and confidence filters narrow chapters', () {
    final matches = searchSyllabus(
      subjects: [physics, chemistry],
      chaptersBySubject: chapters,
      query: const SyllabusQuery(
        difficulty: Difficulty.difficult,
        confidence: Confidence.low,
      ),
    );

    expect(matches.single.subject.name, 'Physics');
    expect(matches.single.chapters.single.title, 'Vector');
    expect(
      filterChapters(chapters[physics.id]!, const SyllabusQuery(status: ChapterStatus.notStarted)),
      hasLength(2),
    );
  });

  test('a filter with no match is an empty result', () {
    final matches = searchSyllabus(
      subjects: [physics],
      chaptersBySubject: chapters,
      query: const SyllabusQuery(text: 'vector', status: ChapterStatus.completed),
    );
    expect(matches, isEmpty);
  });
}

Subject _subject(String id, String name) {
  return Subject(
    id: id,
    studyPlanId: 'plan',
    name: name,
    colorToken: 'blue',
    iconToken: 'science',
    priority: Priority.normal,
    difficulty: Difficulty.moderate,
    confidence: Confidence.medium,
    status: SubjectStatus.active,
    sortOrder: 0,
    createdAt: DateTime(2026, 10, 11),
    updatedAt: DateTime(2026, 10, 11),
  );
}

Chapter _chapter(
  String id,
  String subjectId,
  String title,
  Difficulty difficulty,
  Confidence confidence,
) {
  return Chapter(
    id: id,
    subjectId: subjectId,
    title: title,
    estimatedMinutes: 60,
    completedMinutes: 0,
    difficulty: difficulty,
    confidence: confidence,
    priority: Priority.normal,
    examImportance: Priority.normal,
    status: ChapterStatus.notStarted,
    sortOrder: 0,
    createdAt: DateTime(2026, 10, 11),
    updatedAt: DateTime(2026, 10, 11),
  );
}
