import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/exams/domain/exam_repository.dart';
import 'package:porar_sathi/features/exams/domain/exam_syllabus_item.dart';
import 'package:porar_sathi/features/planner/domain/availability_repository.dart';
import 'package:porar_sathi/features/planner/domain/planning_input.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/planner/domain/study_task_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter_repository.dart';

Future<PlanningInput> loadPlanningInput({
  required StudyPlanRepository plans,
  required SubjectRepository subjects,
  required ChapterRepository chapters,
  required ExamRepository exams,
  required AvailabilityRepository availability,
  required StudyTaskRepository tasks,
  required String planId,
  required DateTime today,
}) async {
  final plan = await plans.findById(planId);
  if (plan == null) {
    throw const DatabaseException(message: 'Study plan was not found.');
  }
  final subjectRows = await subjects.watchByPlan(planId).first;
  final chapterRows = <Chapter>[];
  for (final subject in subjectRows) {
    chapterRows.addAll(await chapters.watchBySubject(subject.id).first);
  }
  final examRows = await exams.watchByPlan(planId).first;
  final syllabus = <ExamSyllabusItem>[];
  for (final exam in examRows) {
    syllabus.addAll(await exams.watchSyllabus(exam.id).first);
  }
  final week = await availability.watchWeek(planId).first;
  final exceptions = await availability.watchExceptions(planId).first;
  final existing = await tasks.listByPlan(planId);
  final locked = [
    for (final task in existing)
      if (task.isLocked && _stillOccupies(task)) task,
  ];
  return PlanningInput(
    today: today,
    plan: plan,
    subjects: subjectRows,
    chapters: chapterRows,
    exams: examRows,
    syllabus: syllabus,
    week: week,
    exceptions: exceptions,
    lockedTasks: locked,
    existingTasks: existing,
  );
}

bool _stillOccupies(StudyTask task) {
  return task.status == TaskStatus.planned || task.status == TaskStatus.inProgress;
}
