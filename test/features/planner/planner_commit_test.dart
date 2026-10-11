import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/core/database/app_database.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/errors/app_exception.dart';
import 'package:porar_sathi/features/planner/data/drift_planner_run_repository.dart';
import 'package:porar_sathi/features/planner/data/drift_study_task_repository.dart';
import 'package:porar_sathi/features/planner/domain/planner_run.dart';
import 'package:porar_sathi/features/planner/domain/study_task.dart';
import 'package:porar_sathi/features/study_plans/data/drift_study_plan_repository.dart';
import 'package:porar_sathi/features/study_plans/domain/study_plan.dart';
import 'package:porar_sathi/features/subjects/data/drift_subject_repository.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/data/drift_chapter_repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

void main() {
  test('a failed planner run keeps the previous tasks', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final today = DateTime(2026, 10, 10, 8);
    final plans = DriftStudyPlanRepository(database);
    final subjects = DriftSubjectRepository(database);
    final chapters = DriftChapterRepository(database);
    final tasks = DriftStudyTaskRepository(database);
    final runs = DriftPlannerRunRepository(database);

    await plans.save(
      newStudyPlan(id: 'plan', name: 'HSC Final', startDate: today, createdAt: today),
    );
    await subjects.save(
      Subject(
        id: 'physics',
        studyPlanId: 'plan',
        name: 'Physics',
        colorToken: 'blue',
        iconToken: 'science',
        priority: Priority.normal,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        status: SubjectStatus.active,
        sortOrder: 0,
        createdAt: today,
        updatedAt: today,
      ),
    );
    await chapters.save(
      Chapter(
        id: 'motion',
        subjectId: 'physics',
        title: 'Motion',
        estimatedMinutes: 60,
        completedMinutes: 0,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        priority: Priority.normal,
        examImportance: Priority.normal,
        status: ChapterStatus.notStarted,
        sortOrder: 0,
        createdAt: today,
        updatedAt: today,
      ),
    );
    await tasks.save(_task(id: 'kept', subjectId: 'physics', chapterId: 'motion', at: today));

    await expectLater(
      tasks.replaceGeneratedPlan(
        run: _run('bad-run', today),
        tasks: [_task(id: 'bad-run-0', subjectId: 'missing', chapterId: null, at: today)],
      ),
      throwsA(isA<DatabaseException>()),
    );

    final stored = await tasks.listByPlan('plan');
    expect(stored.map((task) => task.id), ['kept']);
    final history = await runs.watchByPlan('plan').first;
    expect(history, isEmpty);
  });
}

StudyTask _task({
  required String id,
  required String subjectId,
  required String? chapterId,
  required DateTime at,
}) {
  return StudyTask(
    id: id,
    studyPlanId: 'plan',
    subjectId: subjectId,
    chapterId: chapterId,
    taskType: TaskType.newStudy,
    title: 'Motion',
    plannedDate: at,
    plannedMinutes: 45,
    priorityScore: 10,
    isLocked: false,
    status: TaskStatus.planned,
    completionPercent: 0,
    source: TaskSource.autoPlanner,
    generationBatchId: id.startsWith('bad') ? 'bad-run' : 'old-run',
    createdAt: at,
    updatedAt: at,
  );
}

PlannerRun _run(String id, DateTime at) {
  return PlannerRun(
    id: id,
    studyPlanId: 'plan',
    trigger: PlannerTrigger.userRequest,
    startedAt: at,
    completedAt: at,
    inputTaskCount: 1,
    outputTaskCount: 1,
    riskLevel: PlannerRiskLevel.none,
    algorithmVersion: 'planner_v1',
  );
}
