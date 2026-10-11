import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/revision/domain/revision_engine.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';

void main() {
  final studied = DateTime(2026, 10, 11);
  final exam = DateTime(2026, 10, 20);

  RevisionSchedule schedule({
    required RevisionPolicy policy,
    required List<String> ids,
  }) {
    return buildRevisionSchedule(
      studyPlanId: 'plan',
      chapterId: 'chapter',
      studiedOn: studied,
      studyMinutes: 40,
      confidence: Confidence.medium,
      examImportance: Priority.normal,
      examDate: exam,
      existing: const [],
      createdAt: studied,
      ids: ids,
      policy: policy,
    ).first;
  }

  test('light policy skips the two-day review', () {
    final created = buildRevisionSchedule(
      studyPlanId: 'plan',
      chapterId: 'chapter',
      studiedOn: studied,
      studyMinutes: 40,
      confidence: Confidence.medium,
      examImportance: Priority.normal,
      examDate: exam,
      existing: const [],
      createdAt: studied,
      ids: const ['a', 'b', 'c'],
      policy: RevisionPolicy.light,
    );

    expect(created.map((item) => item.dueDate), [
      DateTime(2026, 10, 18),
      DateTime(2026, 10, 19),
    ]);
  });

  test('frequent policy uses one, three, and seven days', () {
    final created = buildRevisionSchedule(
      studyPlanId: 'plan',
      chapterId: 'chapter',
      studiedOn: studied,
      studyMinutes: 40,
      confidence: Confidence.medium,
      examImportance: Priority.normal,
      examDate: exam,
      existing: const [],
      createdAt: studied,
      ids: const ['a', 'b', 'c'],
      policy: RevisionPolicy.frequent,
    );

    expect(created.map((item) => item.dueDate), [
      DateTime(2026, 10, 12),
      DateTime(2026, 10, 14),
      DateTime(2026, 10, 18),
    ]);
    expect(schedule(policy: RevisionPolicy.standard, ids: const ['a']).dueDate, DateTime(2026, 10, 13));
  });
}
