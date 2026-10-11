import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/exams/domain/exam.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';
import 'package:porar_sathi/features/planner/domain/calendar_exception.dart';
import 'package:porar_sathi/features/planner/domain/generate_plan.dart';
import 'package:porar_sathi/features/planner/domain/plan_forecast.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
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
    int session = 60,
    int dailyMinutes = 120,
    int buffer = 0,
    DateTime? examDate,
  }) {
    final examRows =
        exams ??
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
        maxSessionMinutes: session,
        planningBufferPercent: buffer,
      ).copyWith(primaryExamId: examRows.isEmpty ? null : examRows.first.id),
      subjects: subjects ?? [_subject('physics', 'Physics', sortOrder: 0)],
      chapters: chapters ?? [_chapter('ch-1', 'physics', 'Chapter 4')],
      exams: examRows,
      syllabus:
          syllabus ??
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
    );
  }

  PlanResult plan(PlanningInput source, {String runId = 'run'}) {
    return generatePlan(source, runId: runId, createdAt: today);
  }

  group('planner matrix', () {
    test('single subject schedules that subject only', () {
      final result = plan(input());
      expect(result.tasks, isNotEmpty);
      expect(result.unscheduled, isEmpty);
      expect(result.tasks.map((task) => task.subjectId).toSet(), {'physics'});
      expect(result.tasks.single.examId, 'exam');
      for (final task in result.tasks) {
        expect(task.plannedDate.hour, 0);
        expect(task.plannedDate.minute, 0);
      }
    });

    test('multiple subjects both receive time', () {
      final result = plan(
        input(
          subjects: [
            _subject('physics', 'Physics', sortOrder: 0),
            _subject('chem', 'Chemistry', sortOrder: 1),
          ],
          chapters: [
            _chapter('ch-1', 'physics', 'Motion', estimated: 60),
            _chapter('ch-2', 'chem', 'Bonding', estimated: 60),
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
      expect(_minutes(result, 'physics'), 60);
      expect(_minutes(result, 'chem'), 60);
    });

    test('a single exam is attached to every generated task', () {
      final result = plan(input());
      expect(result.tasks.every((task) => task.examId == 'exam'), isTrue);
    });

    test('the nearer exam is planned before the later exam', () {
      final near = today.add(const Duration(days: 8));
      final far = today.add(const Duration(days: 50));
      final result = plan(
        input(
          exams: [_exam('near', 'Weekly', near), _exam('far', 'Board', far)],
          chapters: [
            _chapter('ch-far', 'physics', 'Optics', estimated: 40),
            _chapter('ch-near', 'physics', 'Motion', estimated: 40),
          ],
          syllabus: const [
            ExamSyllabusItem(
              id: 'map-far',
              examId: 'far',
              subjectId: 'physics',
              chapterId: 'ch-far',
              weight: 1,
              isRequired: true,
            ),
            ExamSyllabusItem(
              id: 'map-near',
              examId: 'near',
              subjectId: 'physics',
              chapterId: 'ch-near',
              weight: 1,
              isRequired: true,
            ),
          ],
        ),
      );
      expect(result.tasks.first.chapterId, 'ch-near');
      expect(result.tasks.first.examId, 'near');
    });

    test('no capacity leaves the chapter unscheduled', () {
      final result = plan(
        input(
          dailyMinutes: 0,
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 90)],
        ),
      );
      expect(result.tasks, isEmpty);
      expect(result.forecast.shortfallMinutes, greaterThan(0));
      expect(result.unscheduled, isNotEmpty);
    });

    test('exact capacity schedules the chapter with nothing left over', () {
      final result = plan(
        input(
          dailyMinutes: 120,
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 120)],
          examDate: today.add(const Duration(days: 5)),
        ),
      );
      expect(_minutes(result, 'physics'), 120);
      expect(result.unscheduled, isEmpty);
      expect(
        result.tasks
            .where((task) => task.plannedDate == today)
            .fold<int>(0, (sum, task) => sum + task.plannedMinutes),
        120,
      );
    });

    test('insufficient capacity before tomorrow keeps a shortfall', () {
      final result = plan(
        input(
          dailyMinutes: 60,
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 300)],
          examDate: today.add(const Duration(days: 1)),
        ),
      );
      expect(_minutes(result, 'physics'), 60);
      expect(
        result.unscheduled.fold<int>(0, (sum, slice) => sum + slice.minutes),
        240,
      );
      expect(result.forecast.risk, PlannerRiskLevel.impossible);
      expect(result.forecast.pace, StudyPace.atRisk);
    });

    test('a missed task raises the backlog score', () {
      final missed = plan(
        input(
          existing: [
            _task(
              id: 'missed',
              date: today.subtract(const Duration(days: 5)),
              status: TaskStatus.missed,
            ),
          ],
        ),
      );
      final clear = plan(input());
      expect(_points(missed, 'ch-1', 'backlog'), greaterThan(0));
      expect(_points(clear, 'ch-1', 'backlog'), 0);
    });

    test('partial progress schedules only the minutes still left', () {
      final result = plan(
        input(
          chapters: [
            _chapter(
              'ch-1',
              'physics',
              'Motion',
              estimated: 100,
              completed: 40,
            ),
          ],
        ),
      );
      expect(_minutes(result, 'physics'), 60);
      expect(result.unscheduled, isEmpty);
    });

    test('a locked task consumes today before new work is placed', () {
      final result = plan(
        input(
          dailyMinutes: 120,
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 120)],
          examDate: today.add(const Duration(days: 5)),
          locked: [
            _task(id: 'locked', date: today, minutes: 120, locked: true),
          ],
        ),
      );
      expect(result.tasks.where((task) => task.plannedDate == today), isEmpty);
      expect(
        result.tasks.first.plannedDate,
        today.add(const Duration(days: 1)),
      );
      expect(_minutes(result, 'physics'), 120);
    });

    test('a no-study exception moves new work off that day', () {
      final result = plan(
        input(
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 60)],
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
        ),
      );
      expect(result.tasks.every((task) => task.plannedDate != today), isTrue);
      expect(
        result.tasks.first.plannedDate,
        today.add(const Duration(days: 1)),
      );
    });

    test('a very difficult chapter scores above an easy one', () {
      final result = plan(
        input(
          chapters: [
            _chapter(
              'hard',
              'physics',
              'Waves',
              difficulty: Difficulty.veryDifficult,
            ),
            _chapter(
              'easy',
              'physics',
              'Units',
              difficulty: Difficulty.veryEasy,
            ),
          ],
          syllabus: const [],
        ),
      );
      expect(
        _points(result, 'hard', 'difficulty'),
        greaterThan(_points(result, 'easy', 'difficulty')),
      );
    });

    test('a low-confidence chapter scores above a confident one', () {
      final result = plan(
        input(
          chapters: [
            _chapter(
              'unsure',
              'physics',
              'Waves',
              confidence: Confidence.veryLow,
            ),
            _chapter(
              'sure',
              'physics',
              'Units',
              confidence: Confidence.veryHigh,
            ),
          ],
          syllabus: const [],
        ),
      );
      expect(
        _points(result, 'unsure', 'confidence'),
        greaterThan(_points(result, 'sure', 'confidence')),
      );
    });

    test('a high-priority subject outranks a low-priority subject', () {
      final result = plan(
        input(
          subjects: [
            _subject(
              'physics',
              'Physics',
              sortOrder: 0,
              priority: Priority.high,
            ),
            _subject('chem', 'Chemistry', sortOrder: 1, priority: Priority.low),
          ],
          chapters: [
            _chapter('ch-1', 'physics', 'Motion'),
            _chapter('ch-2', 'chem', 'Bonding'),
          ],
          syllabus: const [],
        ),
      );
      expect(
        _points(result, 'ch-1', 'subjectPriority'),
        greaterThan(_points(result, 'ch-2', 'subjectPriority')),
      );
    });

    test('balanced mode gives both subjects time on the first day', () {
      final result = plan(
        input(
          dailyMinutes: 100,
          subjects: [
            _subject('physics', 'Physics', sortOrder: 0),
            _subject('chem', 'Chemistry', sortOrder: 1),
          ],
          chapters: [
            _chapter('ch-1', 'physics', 'Motion', estimated: 200),
            _chapter('ch-2', 'chem', 'Bonding', estimated: 200),
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
      expect(firstDay.map((task) => task.subjectId).toSet(), {
        'physics',
        'chem',
      });
    });

    test('revision due adds revision points', () {
      final due = plan(
        input(
          chapters: [
            _chapter(
              'ch-1',
              'physics',
              'Motion',
              status: ChapterStatus.revisionDue,
            ),
          ],
        ),
      );
      final fresh = plan(input());
      expect(_points(due, 'ch-1', 'revision'), greaterThan(0));
      expect(_points(fresh, 'ch-1', 'revision'), 0);
    });

    test('an exam tomorrow cannot absorb a large chapter', () {
      final result = plan(
        input(
          dailyMinutes: 90,
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 240)],
          examDate: today.add(const Duration(days: 1)),
        ),
      );
      expect(result.tasks.every((task) => task.plannedDate == today), isTrue);
      expect(result.unscheduled, isNotEmpty);
      expect(result.forecast.pace, StudyPace.atRisk);
    });

    test('an exam 60 days away finishes early and stays ahead', () {
      final result = plan(
        input(
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 30)],
          examDate: today.add(const Duration(days: 60)),
        ),
      );
      expect(result.unscheduled, isEmpty);
      expect(result.tasks.single.plannedDate, today);
      expect(result.forecast.pace, StudyPace.ahead);
      expect(result.forecast.risk, isNot(PlannerRiskLevel.impossible));
    });

    test('the planning buffer keeps part of the day unused', () {
      final result = plan(
        input(
          dailyMinutes: 120,
          buffer: 50,
          chapters: [_chapter('ch-1', 'physics', 'Motion', estimated: 120)],
          examDate: today.add(const Duration(days: 5)),
        ),
      );
      final firstDay = result.tasks
          .where((task) => task.plannedDate == today)
          .fold<int>(0, (sum, task) => sum + task.plannedMinutes);
      expect(firstDay, 60);
      expect(_minutes(result, 'physics'), 120);
    });

    test('the same input produces the same plan', () {
      final source = input(
        subjects: [
          _subject('physics', 'Physics', sortOrder: 0),
          _subject('chem', 'Chemistry', sortOrder: 1),
        ],
        chapters: [
          _chapter('ch-1', 'physics', 'Motion', estimated: 150),
          _chapter('ch-2', 'chem', 'Bonding', estimated: 90),
        ],
      );
      final first = plan(source, runId: 'run-a');
      final second = plan(source, runId: 'run-a');
      final third = generatePlan(
        source,
        runId: 'run-b',
        createdAt: today.add(const Duration(hours: 3)),
      );
      expect(_shape(second), _shape(first));
      expect(
        second.tasks.map((task) => task.id),
        first.tasks.map((task) => task.id),
      );
      expect(_shape(third), _shape(first));
    });
  });
}

List<(String?, DateTime, int)> _shape(PlanResult result) {
  return [
    for (final task in result.tasks)
      (task.chapterId, task.plannedDate, task.plannedMinutes),
  ];
}

int _points(PlanResult result, String chapterId, String componentId) {
  for (final component in result.scores[chapterId]!.components) {
    if (component.id == componentId) {
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
    priority: Priority.normal,
    examImportance: Priority.normal,
    status: status,
    sortOrder: 0,
    createdAt: today,
    updatedAt: today,
  );
}

Exam _exam(String id, String name, DateTime start) {
  final today = DateTime(2026, 10, 10);
  return Exam(
    id: id,
    studyPlanId: 'plan',
    name: name,
    examType: ExamType.board,
    startDate: start,
    importance: Priority.high,
    createdAt: today,
    updatedAt: today,
  );
}

StudyTask _task({
  required String id,
  required DateTime date,
  int minutes = 30,
  bool locked = false,
  TaskStatus status = TaskStatus.planned,
}) {
  final today = DateTime(2026, 10, 10);
  return StudyTask(
    id: id,
    studyPlanId: 'plan',
    subjectId: 'physics',
    chapterId: 'ch-1',
    taskType: TaskType.newStudy,
    title: 'Motion',
    plannedDate: date,
    plannedMinutes: minutes,
    priorityScore: 10,
    isLocked: locked,
    status: status,
    completionPercent: 0,
    source: TaskSource.manual,
    createdAt: today,
    updatedAt: today,
  );
}
