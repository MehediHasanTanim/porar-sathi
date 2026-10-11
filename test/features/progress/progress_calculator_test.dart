import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/progress/domain/progress_calculator.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';
import 'package:porar_sathi/features/sessions/domain/study_session.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  final today = DateTime(2026, 10, 11);

  test('syllabus progress weights large chapters more than small ones', () {
    expect(overallProgressPercent([_chapter(estimated: 60, completed: 0)]), 0);
    expect(chapterProgressPercent(_chapter(estimated: 60, completed: 30)), 50);
    expect(
      chapterProgressPercent(
        _chapter(estimated: 60, completed: 0, status: ChapterStatus.completed),
      ),
      100,
    );
    final mixed = [
      _chapter(id: 'short', estimated: 10, completed: 10),
      _chapter(id: 'long', estimated: 90, completed: 0),
    ];
    expect(subjectProgressPercent(mixed), 10);
    expect(overallProgressPercent(mixed), 10);
  });

  test('daily summary counts outcomes and the busiest subject', () {
    final summary = summarizeDay(
      day: today,
      tasks: [
        _task(id: 'done', status: TaskStatus.completed, minutes: 40),
        _task(id: 'part', status: TaskStatus.partiallyCompleted, minutes: 20),
        _task(id: 'missed', status: TaskStatus.missed, minutes: 30),
      ],
      sessions: [
        _session(id: 'a', subjectId: 'physics', minutes: 40),
        _session(id: 'b', subjectId: 'math', minutes: 15),
      ],
    );
    expect(summary.plannedMinutes, 90);
    expect(summary.actualMinutes, 55);
    expect(summary.completedTasks, 1);
    expect(summary.partialTasks, 1);
    expect(summary.missedTasks, 1);
    expect(summary.mostStudiedSubjectId, 'physics');
  });

  test('weekly summary compares target, syllabus change, and neglect', () {
    final summary = summarizeWeek(
      today: today,
      tasks: [
        _task(id: 'done', status: TaskStatus.completed, minutes: 40),
        _task(id: 'open', minutes: 20),
      ],
      sessions: [
        _session(id: 'a', subjectId: 'physics', chapterId: 'motion', minutes: 30),
      ],
      chapters: [_chapter(estimated: 100, completed: 30)],
      revisions: [
        RevisionSchedule(
          id: 'rev',
          studyPlanId: 'plan',
          chapterId: 'motion',
          revisionNumber: 1,
          dueDate: today,
          estimatedMinutes: 20,
          status: RevisionStatus.completed,
          completedAt: today,
          createdAt: today,
        ),
      ],
      remainingBySubject: const {'physics': 70, 'math': 40},
    );
    expect(summary.targetMinutes, 60);
    expect(summary.actualMinutes, 30);
    expect(summary.taskCompletionPercent, 50);
    expect(summary.syllabusDelta, 30);
    expect(summary.revisionCount, 1);
    expect(summary.mostImprovedSubjectId, 'physics');
    expect(summary.neglectedSubjectId, 'math');
  });

  test('consistency ignores configured no-study days', () {
    final off = {DateTime(2026, 10, 10), DateTime(2026, 10, 5)};
    final studied = {
      DateTime(2026, 10, 11),
      DateTime(2026, 10, 9),
      DateTime(2026, 10, 8),
      DateTime(2026, 10, 7),
    };
    final window = consistencyWindow(
      today: today,
      dayCount: 7,
      isAvailable: (date) => !off.contains(date),
      wasStudied: studied.contains,
    );
    expect(window.availableDays, 5);
    expect(window.studiedDays, 4);
    expect(window.percent, 80);

    final month = consistencyWindow(
      today: today,
      dayCount: 30,
      isAvailable: (date) => !off.contains(date),
      wasStudied: studied.contains,
    );
    expect(month.availableDays, 28);
    expect(month.studiedDays, 4);
  });

  test('readiness is a weighted preparation indicator', () {
    final ready = preparationReadiness(
      syllabusPercent: 50,
      confidencePercent: 80,
      revisionPercent: 40,
      backlogHealthPercent: 100,
      consistencyPercent: 80,
    );
    expect(ready.percent, 62);
    expect(
      preparationReadiness(
        syllabusPercent: 100,
        confidencePercent: 100,
        revisionPercent: 100,
        backlogHealthPercent: 100,
        consistencyPercent: 100,
      ).percent,
      100,
    );
  });

  test('at risk when remaining work exceeds capacity before the exam', () {
    final report = classifyOnTrack(remainingMinutes: 8 * 60, capacityMinutes: 5 * 60);
    expect(report.pace, StudyPace.atRisk);
    expect(report.remainingMinutes, 480);
    expect(report.capacityMinutes, 300);
    expect(
      classifyOnTrack(
        remainingMinutes: 100,
        capacityMinutes: 200,
        daysBeforeExam: 20,
      ).pace,
      StudyPace.ahead,
    );
    expect(
      classifyOnTrack(
        remainingMinutes: 100,
        capacityMinutes: 200,
        daysBeforeExam: 7,
      ).pace,
      StudyPace.onTrack,
    );
    expect(
      classifyOnTrack(
        remainingMinutes: 100,
        capacityMinutes: 200,
        daysBeforeExam: 4,
      ).pace,
      StudyPace.slightlyBehind,
    );
    expect(
      classifyOnTrack(
        remainingMinutes: 100,
        capacityMinutes: 200,
        daysBeforeExam: 2,
      ).pace,
      StudyPace.behind,
    );
    expect(classifyOnTrack(remainingMinutes: 0, capacityMinutes: 0).pace, StudyPace.onTrack);
  });
}

Chapter _chapter({
  String id = 'motion',
  required int estimated,
  required int completed,
  ChapterStatus status = ChapterStatus.inProgress,
}) {
  final at = DateTime(2026, 10, 11);
  return Chapter(
    id: id,
    subjectId: 'physics',
    title: 'Motion',
    estimatedMinutes: estimated,
    completedMinutes: completed,
    difficulty: Difficulty.moderate,
    confidence: Confidence.medium,
    priority: Priority.normal,
    examImportance: Priority.normal,
    status: status,
    sortOrder: 0,
    createdAt: at,
    updatedAt: at,
    completedAt: status == ChapterStatus.completed ? at : null,
  );
}

StudyTask _task({
  required String id,
  TaskStatus status = TaskStatus.planned,
  int minutes = 45,
}) {
  final at = DateTime(2026, 10, 11);
  return StudyTask(
    id: id,
    studyPlanId: 'plan',
    subjectId: 'physics',
    chapterId: 'motion',
    taskType: TaskType.newStudy,
    title: 'Motion',
    plannedDate: at,
    plannedMinutes: minutes,
    priorityScore: 0,
    isLocked: false,
    status: status,
    completionPercent: status == TaskStatus.completed ? 100 : 0,
    source: TaskSource.autoPlanner,
    createdAt: at,
    updatedAt: at,
    completedAt: status == TaskStatus.completed || status == TaskStatus.partiallyCompleted
        ? at
        : null,
  );
}

StudySession _session({
  required String id,
  required String subjectId,
  String? chapterId,
  int minutes = 30,
}) {
  final at = DateTime(2026, 10, 11, 9);
  return StudySession(
    id: id,
    subjectId: subjectId,
    chapterId: chapterId,
    startedAt: at,
    endedAt: at.add(Duration(minutes: minutes)),
    plannedMinutes: minutes < 1 ? 1 : minutes,
    actualMinutes: minutes,
    completionPercent: 100,
    result: SessionResult.fullyCompleted,
    createdAt: at,
  );
}
