import 'package:drift/drift.dart';

/// Local tables for Phase 2. Topics are omitted until a later schema version.
/// Row classes are named `*Row` so they do not clash with domain models.
///
/// Clock times are minutes from local midnight. Calendar dates are local
/// midnights. Enums are stored as their stable codes.

@DataClassName('StudentProfileRow')
class StudentProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get studyLevel => text()();
  TextColumn get institution => text().nullable()();
  TextColumn get academicYear => text().nullable()();
  TextColumn get preferredLanguage => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('StudyPlanRow')
class StudyPlans extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get planType => text()();
  TextColumn get status => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get targetEndDate => dateTime().nullable()();

  /// Plain id. A foreign key would cycle with [Exams.studyPlanId].
  TextColumn get primaryExamId => text().nullable()();

  TextColumn get planningMode => text()();
  TextColumn get dailyIntensity => text()();
  IntColumn get maxDailyMinutes => integer()();
  IntColumn get maxSessionMinutes => integer()();
  IntColumn get planningBufferPercent => integer()();
  IntColumn get revisionBufferDays => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_subjects_study_plan_id', columns: {#studyPlanId})
@DataClassName('SubjectRow')
class Subjects extends Table {
  TextColumn get id => text()();
  TextColumn get studyPlanId =>
      text().references(StudyPlans, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  TextColumn get paperName => text().nullable()();
  TextColumn get colorToken => text()();
  TextColumn get iconToken => text()();
  TextColumn get priority => text()();
  TextColumn get difficulty => text()();
  TextColumn get confidence => text()();
  TextColumn get status => text()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_chapters_subject_id_status',
  columns: {#subjectId, #status},
)
@DataClassName('ChapterRow')
class Chapters extends Table {
  TextColumn get id => text()();
  TextColumn get subjectId =>
      text().references(Subjects, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  IntColumn get chapterNumber => integer().nullable()();
  IntColumn get estimatedMinutes => integer()();
  IntColumn get completedMinutes => integer()();
  TextColumn get difficulty => text()();
  TextColumn get confidence => text()();
  TextColumn get priority => text()();
  TextColumn get examImportance => text()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_exams_study_plan_id_start_date',
  columns: {#studyPlanId, #startDate},
)
@DataClassName('ExamRow')
class Exams extends Table {
  TextColumn get id => text()();
  TextColumn get studyPlanId =>
      text().references(StudyPlans, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get examType => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get timeOfDay => integer().nullable()();
  TextColumn get importance => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExamSyllabusItemRow')
class ExamSyllabusItems extends Table {
  TextColumn get id => text()();
  TextColumn get examId =>
      text().references(Exams, #id, onDelete: KeyAction.cascade)();
  TextColumn get subjectId =>
      text().references(Subjects, #id, onDelete: KeyAction.cascade)();
  TextColumn get chapterId => text().nullable().references(
    Chapters,
    #id,
    onDelete: KeyAction.cascade,
  )();

  /// Topics are not a table yet. The id is kept so a later migration can
  /// attach a foreign key without rewriting syllabus rows.
  TextColumn get topicId => text().nullable()();
  IntColumn get weight => integer()();
  BoolColumn get isRequired => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_weekly_availability_study_plan_id_weekday',
  columns: {#studyPlanId, #weekday},
  unique: true,
)
@DataClassName('WeeklyAvailabilityRow')
class WeeklyAvailabilities extends Table {
  @override
  String get tableName => 'weekly_availability';

  TextColumn get id => text()();
  TextColumn get studyPlanId =>
      text().references(StudyPlans, #id, onDelete: KeyAction.cascade)();

  /// ISO weekday: Monday is 1 and Sunday is 7, matching [DateTime.weekday].
  IntColumn get weekday => integer()();
  IntColumn get totalAvailableMinutes => integer()();
  BoolColumn get isStudyDay => boolean()();
  IntColumn get preferredStartTime => integer().nullable()();
  IntColumn get preferredEndTime => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_calendar_exceptions_study_plan_id_date',
  columns: {#studyPlanId, #exceptionDate},
  unique: true,
)
@DataClassName('CalendarExceptionRow')
class CalendarExceptions extends Table {
  TextColumn get id => text()();
  TextColumn get studyPlanId =>
      text().references(StudyPlans, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get exceptionDate => dateTime().named('date')();
  TextColumn get exceptionType => text()();
  IntColumn get availableMinutesOverride => integer().nullable()();
  TextColumn get reason => text().nullable()();
  BoolColumn get isNoStudyDay => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_study_tasks_study_plan_id_planned_date',
  columns: {#studyPlanId, #plannedDate},
)
@TableIndex(
  name: 'idx_study_tasks_status_planned_date',
  columns: {#status, #plannedDate},
)
@TableIndex(
  name: 'idx_study_tasks_subject_id_status',
  columns: {#subjectId, #status},
)
@TableIndex(
  name: 'idx_study_tasks_chapter_id_status',
  columns: {#chapterId, #status},
)
@DataClassName('StudyTaskRow')
class StudyTasks extends Table {
  TextColumn get id => text()();
  TextColumn get studyPlanId =>
      text().references(StudyPlans, #id, onDelete: KeyAction.cascade)();
  TextColumn get subjectId =>
      text().references(Subjects, #id, onDelete: KeyAction.cascade)();
  TextColumn get chapterId => text().nullable().references(
    Chapters,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get topicId => text().nullable()();
  TextColumn get examId => text().nullable().references(
    Exams,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get taskType => text()();
  TextColumn get title => text()();
  DateTimeColumn get plannedDate => dateTime()();
  IntColumn get plannedStartTime => integer().nullable()();
  IntColumn get plannedMinutes => integer()();
  IntColumn get actualMinutes => integer().nullable()();
  IntColumn get priorityScore => integer()();
  BoolColumn get isLocked => boolean()();
  TextColumn get status => text()();
  IntColumn get completionPercent => integer()();
  TextColumn get source => text()();
  TextColumn get generationBatchId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_study_sessions_subject_id_started_at',
  columns: {#subjectId, #startedAt},
)
@TableIndex(name: 'idx_study_sessions_started_at', columns: {#startedAt})
@DataClassName('StudySessionRow')
class StudySessions extends Table {
  TextColumn get id => text()();

  /// History survives task deletion. Subject and chapter deletes are blocked
  /// until the caller explicitly removes history.
  TextColumn get studyTaskId => text().nullable().references(
    StudyTasks,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get subjectId =>
      text().references(Subjects, #id, onDelete: KeyAction.restrict)();
  TextColumn get chapterId => text().nullable().references(
    Chapters,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get topicId => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get plannedMinutes => integer()();
  IntColumn get actualMinutes => integer()();
  IntColumn get completionPercent => integer()();
  TextColumn get result => text()();
  TextColumn get confidenceBefore => text().nullable()();
  TextColumn get confidenceAfter => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_revision_schedules_due_date_status',
  columns: {#dueDate, #status},
)
@TableIndex(
  name: 'idx_revision_schedules_chapter_id_status',
  columns: {#chapterId, #status},
)
@DataClassName('RevisionScheduleRow')
class RevisionSchedules extends Table {
  TextColumn get id => text()();
  TextColumn get studyPlanId =>
      text().references(StudyPlans, #id, onDelete: KeyAction.cascade)();
  TextColumn get chapterId =>
      text().references(Chapters, #id, onDelete: KeyAction.cascade)();
  TextColumn get topicId => text().nullable()();
  TextColumn get sourceStudySessionId => text().nullable().references(
    StudySessions,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get revisionNumber => integer()();
  DateTimeColumn get dueDate => dateTime()();
  IntColumn get estimatedMinutes => integer()();
  TextColumn get status => text()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PlannerRunRow')
class PlannerRuns extends Table {
  TextColumn get id => text()();
  TextColumn get studyPlanId =>
      text().references(StudyPlans, #id, onDelete: KeyAction.cascade)();
  TextColumn get trigger => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get inputTaskCount => integer()();
  IntColumn get outputTaskCount => integer()();
  TextColumn get riskLevel => text()();
  DateTimeColumn get expectedFinishDate => dateTime().nullable()();
  TextColumn get algorithmVersion => text()();

  @override
  Set<Column> get primaryKey => {id};
}
