import 'package:porar_sathi/core/domain/stored_enum.dart';

enum StudyLevel {
  ssc('SSC'),
  hsc('HSC'),
  university('UNIVERSITY'),
  admission('ADMISSION'),
  diploma('DIPLOMA'),
  other('OTHER');

  const StudyLevel(this.code);

  final String code;

  static StudyLevel fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

/// Separate planning contexts such as a board exam and a semester.
enum PlanType {
  exam('EXAM'),
  semester('SEMESTER'),
  admission('ADMISSION'),
  custom('CUSTOM');

  const PlanType(this.code);

  final String code;

  static PlanType fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum StudyPlanStatus {
  active('ACTIVE'),
  paused('PAUSED'),
  completed('COMPLETED'),
  archived('ARCHIVED');

  const StudyPlanStatus(this.code);

  final String code;

  static StudyPlanStatus fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum PlanningMode {
  balanced('BALANCED'),
  weakSubjectFocus('WEAK_SUBJECT_FOCUS'),
  light('LIGHT'),
  examCrunch('EXAM_CRUNCH'),
  custom('CUSTOM');

  const PlanningMode(this.code);

  final String code;

  static PlanningMode fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

/// How full a generated day should be. Feature spec section 15.
enum DailyIntensity {
  light('LIGHT'),
  normal('NORMAL'),
  focused('FOCUSED'),
  intensive('INTENSIVE');

  const DailyIntensity(this.code);

  final String code;

  static DailyIntensity fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum Priority {
  low('LOW'),
  normal('NORMAL'),
  high('HIGH'),
  critical('CRITICAL');

  const Priority(this.code);

  final String code;

  static Priority fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum Difficulty {
  veryEasy('VERY_EASY'),
  easy('EASY'),
  moderate('MODERATE'),
  difficult('DIFFICULT'),
  veryDifficult('VERY_DIFFICULT');

  const Difficulty(this.code);

  final String code;

  static Difficulty fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum Confidence {
  veryLow('VERY_LOW'),
  low('LOW'),
  medium('MEDIUM'),
  high('HIGH'),
  veryHigh('VERY_HIGH');

  const Confidence(this.code);

  final String code;

  static Confidence fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum SubjectStatus {
  active('ACTIVE'),
  archived('ARCHIVED');

  const SubjectStatus(this.code);

  final String code;

  static SubjectStatus fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum ChapterStatus {
  notStarted('NOT_STARTED'),
  planned('PLANNED'),
  inProgress('IN_PROGRESS'),
  completed('COMPLETED'),
  revisionDue('REVISION_DUE'),
  revised('REVISED'),
  skipped('SKIPPED');

  const ChapterStatus(this.code);

  final String code;

  static ChapterStatus fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum ExamType {
  classTest('CLASS_TEST'),
  quiz('QUIZ'),
  midterm('MIDTERM'),
  finalExam('FINAL'),
  board('BOARD'),
  admission('ADMISSION'),
  modelTest('MODEL_TEST'),
  custom('CUSTOM');

  const ExamType(this.code);

  final String code;

  static ExamType fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum CalendarExceptionType {
  holiday('HOLIDAY'),
  coaching('COACHING'),
  exam('EXAM'),
  familyEvent('FAMILY_EVENT'),
  travel('TRAVEL'),
  sick('SICK'),
  custom('CUSTOM');

  const CalendarExceptionType(this.code);

  final String code;

  static CalendarExceptionType fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum TaskType {
  newStudy('NEW_STUDY'),
  continueStudy('CONTINUE_STUDY'),
  practice('PRACTICE'),
  revision('REVISION'),
  mockTest('MOCK_TEST'),
  assignment('ASSIGNMENT'),
  reading('READING'),
  custom('CUSTOM');

  const TaskType(this.code);

  final String code;

  static TaskType fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum TaskStatus {
  planned('PLANNED'),
  inProgress('IN_PROGRESS'),
  partiallyCompleted('PARTIALLY_COMPLETED'),
  completed('COMPLETED'),
  missed('MISSED'),
  skipped('SKIPPED'),
  cancelled('CANCELLED');

  const TaskStatus(this.code);

  final String code;

  static TaskStatus fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum TaskSource {
  autoPlanner('AUTO_PLANNER'),
  manual('MANUAL'),
  quickStudy('QUICK_STUDY'),
  revisionEngine('REVISION_ENGINE'),
  catchUp('CATCH_UP');

  const TaskSource(this.code);

  final String code;

  static TaskSource fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum SessionResult {
  fullyCompleted('FULLY_COMPLETED'),
  mostlyCompleted('MOSTLY_COMPLETED'),
  partiallyCompleted('PARTIALLY_COMPLETED'),
  couldNotStudy('COULD_NOT_STUDY');

  const SessionResult(this.code);

  final String code;

  static SessionResult fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum RevisionStatus {
  pending('PENDING'),
  scheduled('SCHEDULED'),
  completed('COMPLETED'),
  skipped('SKIPPED'),
  overdue('OVERDUE');

  const RevisionStatus(this.code);

  final String code;

  static RevisionStatus fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum PlannerTrigger {
  initialPlan('INITIAL_PLAN'),
  missedTask('MISSED_TASK'),
  examDateChange('EXAM_DATE_CHANGE'),
  newChapter('NEW_CHAPTER'),
  deletedChapter('DELETED_CHAPTER'),
  availabilityChange('AVAILABILITY_CHANGE'),
  difficultyChange('DIFFICULTY_CHANGE'),
  confidenceChange('CONFIDENCE_CHANGE'),
  priorityChange('PRIORITY_CHANGE'),
  calendarException('CALENDAR_EXCEPTION'),
  userRequest('USER_REQUEST'),
  estimationVariance('ESTIMATION_VARIANCE');

  const PlannerTrigger(this.code);

  final String code;

  static PlannerTrigger fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}

enum PlannerRiskLevel {
  none('NONE'),
  low('LOW'),
  medium('MEDIUM'),
  high('HIGH'),
  impossible('IMPOSSIBLE');

  const PlannerRiskLevel(this.code);

  final String code;

  static PlannerRiskLevel fromCode(String code) =>
      StoredEnum.byCode(values, code, (value) => value.code);
}
