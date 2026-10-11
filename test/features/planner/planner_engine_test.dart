import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/day_capacity.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/planning_days.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/planner/domain/priority_score.dart';
import 'package:porar_sathi/features/planner/domain/remaining_work.dart';
import 'package:porar_sathi/features/planner/domain/session_splitter.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/weekly_availability.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  final today = DateTime(2026, 10, 10);

  PlanningInput input({
    List<Subject>? subjects,
    List<Chapter>? chapters,
    List<Exam>? exams,
    List<ExamSyllabusItem>? syllabus,
    List<WeeklyAvailability>? availability,
    List<CalendarException>? exceptions,
    List<StudyTask>? locked,
    List<StudyTask>? existing,
    PlanningMode mode = PlanningMode.balanced,
    int session = 60,
    int dailyMinutes = 120,
    int revision = 7,
    DateTime? examDate,
    PlanningConfig? config,
  }) {
    final examRows = exams ??
        [
          Exam(
            id: 'exam',
            studyPlanId: 'plan',
            name: 'Board',
            examType: ExamType.board,
            startDate: examDate ?? today.add(const Duration(days: 40)),
            importance: Priority.high,
            createdAt: today,
            updatedAt: today,
          ),
        ];
    return PlanningInput(
      today: today,
      plan: newStudyPlan(
        id: 'plan',
        name: 'HSC Final',
        startDate: today,
        createdAt: today,
        planningMode: mode,
        maxSessionMinutes: session,
        planningBufferPercent: 0,
        revisionBufferDays: revision,
      ).copyWith(primaryExamId: examRows.isEmpty ? null : examRows.first.id),
      subjects: subjects ?? [_subject('physics', 'Physics', sortOrder: 0)],
      chapters: chapters ?? [_chapter('ch-1', 'physics', 'Chapter 4')],
      exams: examRows,
      syllabus: syllabus ??
          [
            if (examRows.isNotEmpty)
              const ExamSyllabusItem(
                id: 'map-1',
                examId: 'exam',
                subjectId: 'physics',
                chapterId: 'ch-1',
                weight: 1,
                isRequired: true,
              ),
          ],
      week: availability ?? _week(dailyMinutes),
      exceptions: exceptions ?? const [],
      lockedTasks: locked ?? const [],
      existingTasks: existing ?? const [],
      config: config ?? const PlanningConfig(),
    );
  }

  PlanResult plan(PlanningInput source) {
    return generatePlan(source, runId: 'run', createdAt: today);
  }

  group('capacity', () {
    test('a normal day keeps the planning buffer out of usable time', () {
      final day = capacityForDate(
        date: today,
        week: _week(180),
        exceptions: const [],
        planningBufferPercent: 15,
      );
      expect(day.availableMinutes, 180);
      expect(day.bufferMinutes, 27);
      expect(day.usableMinutes, 153);
    });

    test('a no-study day has no usable time', () {
      final day = capacityForDate(
        date: today,
        week: _week(180),
        exceptions: [
          CalendarException(
            id: 'off',
            studyPlanId: 'plan',
            date: today,
            exceptionType: CalendarExceptionType.holiday,
            isNoStudyDay: true,
            createdAt: today,
          ),
        ],
        planningBufferPercent: 15,
      );
      expect(day.usableMinutes, 0);
      expect(day.isNoStudyDay, isTrue);
    });

    test('an extra study day opens a day that was off', () {
      final day = capacityForDate(
        date: DateTime(2026, 10, 11),
        week: [
          WeeklyAvailability(
            id: 'sunday',
            studyPlanId: 'plan',
            weekday: DateTime.sunday,
            totalAvailableMinutes: 0,
            isStudyDay: false,
            createdAt: today,
            updatedAt: today,
          ),
        ],
        exceptions: [
          CalendarException(
            id: 'extra',
            studyPlanId: 'plan',
            date: DateTime(2026, 10, 11),
            exceptionType: CalendarExceptionType.custom,
            isNoStudyDay: false,
            availableMinutesOverride: 90,
            createdAt: today,
          ),
        ],
        planningBufferPercent: 10,
      );
      expect(day.baseMinutes, 0);
      expect(day.usableMinutes, 81);
    });

    test('locked tasks can fill the day', () {
      final day = capacityForDate(
        date: today,
        week: _week(180),
        exceptions: const [],
        planningBufferPercent: 10,
        lockedMinutes: 162,
      );
      expect(day.schedulableMinutes, 162);
      expect(day.usableMinutes, 0);
    });

    test('invalid buffer and locked minutes are clamped', () {
      final day = capacityForDate(
        date: today,
        week: _week(100),
        exceptions: const [],
        planningBufferPercent: 250,
        lockedMinutes: -5,
      );
      expect(day.schedulableMinutes, 0);
      expect(day.usableMinutes, 0);
      expect(day.lockedMinutes, 0);
    });

    test('the horizon stops before the exam', () {
      final days = buildPlanningDays(
        input(examDate: today.add(const Duration(days: 3))),
      );
      expect(days.map((day) => day.capacity.date), [
        today,
        today.add(const Duration(days: 1)),
        today.add(const Duration(days: 2)),
      ]);
    });
  });

  group('remaining work', () {
    test('partial completion reduces minutes and never goes negative', () {
      expect(
        remainingChapterMinutes(_chapter('a', 'physics', 'A', estimated: 100, completed: 40)),
        60,
      );
      expect(
        remainingChapterMinutes(_chapter('a', 'physics', 'A', estimated: 80, completed: 200)),
        0,
      );
    });

    test('completed and skipped chapters are ignored', () {
      expect(
        remainingChapterMinutes(
          _chapter('a', 'physics', 'A', status: ChapterStatus.completed),
        ),
        0,
      );
      expect(
        remainingChapterMinutes(
          _chapter('a', 'physics', 'A', status: ChapterStatus.skipped, estimated: 90),
        ),
        0,
      );
    });

    test('exam work is the linked remaining minutes', () {
      final board = Exam(
        id: 'board',
        studyPlanId: 'plan',
        name: 'Board',
        examType: ExamType.board,
        startDate: today.add(const Duration(days: 40)),
        importance: Priority.high,
        createdAt: today,
        updatedAt: today,
      );
      final quiz = Exam(
        id: 'quiz',
        studyPlanId: 'plan',
        name: 'Quiz',
        examType: ExamType.quiz,
        startDate: today.add(const Duration(days: 12)),
        importance: Priority.normal,
        createdAt: today,
        updatedAt: today,
      );
      final source = input(
        exams: [board, quiz],
        chapters: [
          _chapter('ch-1', 'physics', 'Linked', estimated: 80),
          _chapter('ch-2', 'physics', 'Other', estimated: 50),
        ],
        syllabus: const [
          ExamSyllabusItem(
            id: 'map-1',
            examId: 'board',
            subjectId: 'physics',
            chapterId: 'ch-1',
            weight: 1,
            isRequired: true,
          ),
          ExamSyllabusItem(
            id: 'map-2',
            examId: 'quiz',
            subjectId: 'physics',
            chapterId: 'ch-2',
            weight: 1,
            isRequired: true,
          ),
        ],
      );
      final prepared = preparePlanningInput(source);
      final work = remainingWork(prepared);
      expect(examRemainingMinutes(input: prepared, exam: board, work: work), 80);
      expect(examRemainingMinutes(input: prepared, exam: quiz, work: work), 50);
    });
  });

  group('priority', () {
    test('every score dimension uses its documented band', () {
      expect(examUrgencyBand(2), 25);
      expect(examUrgencyBand(6), 23);
      expect(examUrgencyBand(10), 20);
      expect(examUrgencyBand(20), 15);
      expect(examUrgencyBand(45), 10);
      expect(examUrgencyBand(90), 5);
      expect(difficultyBand(Difficulty.veryDifficult), 10);
      expect(difficultyBand(Difficulty.easy), 3);
      expect(confidenceBand(Confidence.veryLow), 15);
      expect(confidenceBand(Confidence.veryHigh), 1);
      expect(priorityBand(Priority.critical), 10);
      expect(priorityBand(Priority.low), 2);
      expect(backlogBand(1), 2);
      expect(backlogBand(3), 5);
      expect(backlogBand(8), 10);
      expect(revisionBand(ChapterStatus.revisionDue), 5);
      expect(
        neglectBand(
          subjectMinutes: 7,
          totalMinutes: 100,
          subjectRemaining: 25,
          totalRemaining: 100,
        ),
        5,
      );
    });

    test('weights scale a component and can turn it off', () {
      expect(scaleBand(10, 10, 20), 20);
      expect(scaleBand(10, 10, 0), 0);
    });

    test('the explanation lists the points that make the total', () {
      final source = input(
        chapters: [
          _chapter(
            'ch-1',
            'physics',
            'Chapter 4',
            difficulty: Difficulty.moderate,
            confidence: Confidence.medium,
            priority: Priority.high,
          ),
        ],
      );
      final result = plan(source);
      final text = result.scores['ch-1']!.format('Physics Chapter 4');
      expect(text, startsWith('Physics Chapter 4 = '));
      expect(text, contains('Exam urgency +'));
      expect(text, contains('Difficulty +'));
      expect(text, contains('Low confidence +'));
      expect(text, contains('Chapter priority +'));
      expect(text, isNot(contains('Backlog +')));
    });

    test('weak-subject mode raises difficulty and confidence', () {
      final balanced = plan(input());
      final focused = plan(input(mode: PlanningMode.weakSubjectFocus));
      final balancedDifficulty = _points(balanced, 'difficulty');
      final focusedDifficulty = _points(focused, 'difficulty');
      expect(focusedDifficulty, greaterThan(balancedDifficulty));
    });
  });

  group('sessions', () {
    test('a chapter that fits stays one session', () {
      expect(splitSessions(minutes: 40, maxSession: 50, minSession: 20), [40]);
    });

    test('a small remainder merges into the previous session', () {
      expect(splitSessions(minutes: 105, maxSession: 50, minSession: 20), [50, 55]);
    });

    test('a large chapter splits on the session limit', () {
      expect(
        splitSessions(minutes: 180, maxSession: 50, minSession: 20),
        [50, 50, 50, 30],
      );
    });
  });

  group('allocation', () {
    test('one subject uses the whole day', () {
      final result = plan(
        input(chapters: [_chapter('ch-1', 'physics', 'Chapter 4', estimated: 180)]),
      );
      expect(result.unscheduled, isEmpty);
      expect(_minutes(result, 'physics'), 180);
    });

    test('two subjects share a day', () {
      final result = plan(
        input(
          subjects: [
            _subject('physics', 'Physics', sortOrder: 0),
            _subject('chem', 'Chemistry', sortOrder: 1),
          ],
          chapters: [
            _chapter('ch-1', 'physics', 'Motion', estimated: 180),
            _chapter('ch-2', 'chem', 'Bonding', estimated: 180),
          ],
          syllabus: const [
            ExamSyllabusItem(
              id: 'map-1',
              examId: 'exam',
              subjectId: 'physics',
              chapterId: 'ch-1',
              weight: 1,
              isRequired: true,
            ),
            ExamSyllabusItem(
              id: 'map-2',
              examId: 'exam',
              subjectId: 'chem',
              chapterId: 'ch-2',
              weight: 1,
              isRequired: true,
            ),
          ],
        ),
      );
      final firstDay = result.tasks.where((task) => task.plannedDate == today);
      expect(firstDay.map((task) => task.subjectId).toSet(), {'physics', 'chem'});
      expect(result.unscheduled, isEmpty);
    });

    test('a higher priority subject is placed first without taking the day', () {
      final result = plan(
        input(
          subjects: [
            _subject('physics', 'Physics', sortOrder: 0, priority: Priority.critical),
            _subject('chem', 'Chemistry', sortOrder: 1, priority: Priority.low),
          ],
          chapters: [
            _chapter(
              'ch-1',
              'physics',
              'Motion',
              estimated: 180,
              difficulty: Difficulty.veryDifficult,
              confidence: Confidence.veryLow,
              priority: Priority.critical,
            ),
            _chapter(
              'ch-2',
              'chem',
              'Bonding',
              estimated: 180,
              difficulty: Difficulty.veryEasy,
              confidence: Confidence.veryHigh,
              priority: Priority.low,
            ),
          ],
          syllabus: const [
            ExamSyllabusItem(
              id: 'map-1',
              examId: 'exam',
              subjectId: 'physics',
              chapterId: 'ch-1',
              weight: 1,
              isRequired: true,
            ),
            ExamSyllabusItem(
              id: 'map-2',
              examId: 'exam',
              subjectId: 'chem',
              chapterId: 'ch-2',
              weight: 1,
              isRequired: true,
            ),
          ],
        ),
      );
      expect(result.tasks.first.subjectId, 'physics');
      final firstDay = result.tasks.where((task) => task.plannedDate == today);
      expect(firstDay.map((task) => task.subjectId), contains('chem'));
    });

    test('exam crunch lets the urgent subject fill the day', () {
      final result = plan(
        input(
          mode: PlanningMode.examCrunch,
          subjects: [
            _subject('physics', 'Physics', sortOrder: 0, priority: Priority.critical),
            _subject('chem', 'Chemistry', sortOrder: 1),
          ],
          chapters: [
            _chapter(
              'ch-1',
              'physics',
              'Motion',
              estimated: 180,
              difficulty: Difficulty.veryDifficult,
              confidence: Confidence.veryLow,
              priority: Priority.critical,
            ),
            _chapter('ch-2', 'chem', 'Bonding', estimated: 180),
          ],
          syllabus: const [
            ExamSyllabusItem(
              id: 'map-1',
              examId: 'exam',
              subjectId: 'physics',
              chapterId: 'ch-1',
              weight: 1,
              isRequired: true,
            ),
            ExamSyllabusItem(
              id: 'map-2',
              examId: 'exam',
              subjectId: 'chem',
              chapterId: 'ch-2',
              weight: 1,
              isRequired: true,
            ),
          ],
        ),
      );
      final firstDay = result.tasks.where((task) => task.plannedDate == today);
      expect(firstDay.map((task) => task.subjectId).toSet(), {'physics'});
    });
  });

  group('forecast', () {
    test('reports pace from the revision buffer', () {
      expect(
        plan(input(chapters: [_chapter('ch-1', 'physics', 'A', estimated: 60)])).forecast.pace,
        StudyPace.ahead,
      );
      expect(
        plan(
          input(
            chapters: [_chapter('ch-1', 'physics', 'A', estimated: 600)],
            dailyMinutes: 60,
            examDate: today.add(const Duration(days: 16)),
          ),
        ).forecast.pace,
        StudyPace.onTrack,
      );
      expect(
        plan(
          input(
            chapters: [_chapter('ch-1', 'physics', 'A', estimated: 420)],
            dailyMinutes: 60,
            examDate: today.add(const Duration(days: 10)),
          ),
        ).forecast.pace,
        StudyPace.slightlyBehind,
      );
      expect(
        plan(
          input(
            chapters: [_chapter('ch-1', 'physics', 'A', estimated: 420)],
            dailyMinutes: 60,
            examDate: today.add(const Duration(days: 8)),
          ),
        ).forecast.pace,
        StudyPace.behind,
      );
    });

    test('an impossible load is reported instead of dropped', () {
      final result = plan(
        input(
          chapters: [_chapter('ch-1', 'physics', 'A', estimated: 300)],
          dailyMinutes: 60,
          examDate: today.add(const Duration(days: 1)),
        ),
      );
      final dropped = result.unscheduled.fold<int>(0, (sum, slice) => sum + slice.minutes);
      expect(dropped, greaterThan(0));
      expect(result.forecast.shortfallMinutes, greaterThan(0));
      expect(result.forecast.risk, PlannerRiskLevel.impossible);
      expect(result.forecast.pace, StudyPace.atRisk);
      expect(result.forecast.suggestions, isNotEmpty);
      expect(
        result.tasks.fold<int>(0, (sum, task) => sum + task.plannedMinutes) + dropped,
        300,
      );
    });
  });

  test('planning input is ordered and rejects an unknown subject', () {
    final prepared = preparePlanningInput(
      input(
        subjects: [
          _subject('chem', 'Chemistry', sortOrder: 2),
          _subject('physics', 'Physics', sortOrder: 0),
        ],
        chapters: [_chapter('ch-1', 'physics', 'A', estimated: 30)],
        syllabus: const [],
        exams: const [],
      ),
    );
    expect(prepared.subjects.map((subject) => subject.id), ['physics', 'chem']);

    expect(
      () => preparePlanningInput(
        input(chapters: [_chapter('ch-1', 'missing', 'A')]),
      ),
      throwsA(isA<ValidationException>()),
    );
  });
}

int _points(PlanResult result, String id) {
  for (final component in result.scores['ch-1']!.components) {
    if (component.id == id) {
      return component.points;
    }
  }
  return 0;
}

int _minutes(PlanResult result, String subjectId) {
  return result.tasks
      .where((task) => task.subjectId == subjectId)
      .fold(0, (sum, task) => sum + task.plannedMinutes);
}

List<WeeklyAvailability> _week(int minutes) {
  return [
    for (var weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++)
      WeeklyAvailability(
        id: 'day-$weekday',
        studyPlanId: 'plan',
        weekday: weekday,
        totalAvailableMinutes: minutes,
        isStudyDay: minutes > 0,
        createdAt: DateTime(2026, 10, 10),
        updatedAt: DateTime(2026, 10, 10),
      ),
  ];
}

Subject _subject(
  String id,
  String name, {
  required int sortOrder,
  Priority priority = Priority.normal,
}) {
  final today = DateTime(2026, 10, 10);
  return Subject(
    id: id,
    studyPlanId: 'plan',
    name: name,
    colorToken: 'blue',
    iconToken: 'science',
    priority: priority,
    difficulty: Difficulty.moderate,
    confidence: Confidence.medium,
    status: SubjectStatus.active,
    sortOrder: sortOrder,
    createdAt: today,
    updatedAt: today,
  );
}

Chapter _chapter(
  String id,
  String subjectId,
  String title, {
  int estimated = 60,
  int completed = 0,
  Difficulty difficulty = Difficulty.moderate,
  Confidence confidence = Confidence.medium,
  Priority priority = Priority.normal,
  ChapterStatus status = ChapterStatus.notStarted,
}) {
  final today = DateTime(2026, 10, 10);
  return Chapter(
    id: id,
    subjectId: subjectId,
    title: title,
    estimatedMinutes: estimated,
    completedMinutes: completed,
    difficulty: difficulty,
    confidence: confidence,
    priority: priority,
    examImportance: Priority.normal,
    status: status,
    sortOrder: 0,
    createdAt: today,
    updatedAt: today,
  );
}
