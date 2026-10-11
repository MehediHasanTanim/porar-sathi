import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/core/database/database_provider.dart';
import 'package:porar_sathi/features/exams/data/drift_exam_repository.dart';
import 'package:porar_sathi/features/exams/domain/exam_repository.dart';
import 'package:porar_sathi/features/onboarding/data/drift_student_profile_repository.dart';
import 'package:porar_sathi/features/onboarding/domain/student_profile_repository.dart';
import 'package:porar_sathi/features/planner/data/drift_availability_repository.dart';
import 'package:porar_sathi/features/planner/data/drift_planner_run_repository.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/availability_repository.dart';
import 'package:porar_sathi/features/planner/domain/planner_run_repository.dart';
import 'package:porar_sathi/features/planner/domain/study_task_repository.dart';
import 'package:porar_sathi/features/revision/data/drift_revision_repository.dart';
import 'package:porar_sathi/features/revision/domain/revision_repository.dart';
import 'package:porar_sathi/features/sessions/data/drift_study_session_repository.dart';
import 'package:porar_sathi/features/sessions/domain/study_session_repository.dart';
import 'package:porar_sathi/features/study_plans/data/drift_study_plan_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan_repository.dart';
import 'package:porar_sathi/features/subjects/data/drift_subject_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject_repository.dart';
import 'package:porar_sathi/features/syllabus/data/drift_chapter_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter_repository.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
StudentProfileRepository studentProfileRepository(Ref ref) {
  return DriftStudentProfileRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
StudyPlanRepository studyPlanRepository(Ref ref) {
  return DriftStudyPlanRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
SubjectRepository subjectRepository(Ref ref) {
  return DriftSubjectRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
ChapterRepository chapterRepository(Ref ref) {
  return DriftChapterRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
ExamRepository examRepository(Ref ref) {
  return DriftExamRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
AvailabilityRepository availabilityRepository(Ref ref) {
  return DriftAvailabilityRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
StudyTaskRepository studyTaskRepository(Ref ref) {
  return DriftStudyTaskRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
StudySessionRepository studySessionRepository(Ref ref) {
  return DriftStudySessionRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
RevisionRepository revisionRepository(Ref ref) {
  return DriftRevisionRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
PlannerRunRepository plannerRunRepository(Ref ref) {
  return DriftPlannerRunRepository(ref.watch(appDatabaseProvider));
}
