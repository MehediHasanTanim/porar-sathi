# Pocket Tutor — Technical Design Document

## 1. Document Overview

### 1.1 Product

**Pocket Tutor — Offline Study Planner**

### 1.2 Purpose

This document defines the technical design for Pocket Tutor, an offline-first mobile application for Bangladeshi SSC, HSC, university, admission-test, diploma, and other self-study learners.

Pocket Tutor is not a course-content platform. It is a **study execution system** that converts:

- Subjects
- Chapters
- Topics
- Exam dates
- Study availability
- Difficulty
- Confidence
- Priority
- Revision requirements

into a realistic, adaptive daily study plan.

The application must work without a backend for all core functionality.

### 1.3 Core Technical Principles

1. **Offline-first by default**
2. **No backend required for MVP**
3. **Deterministic local planning engine**
4. **Local-first notifications**
5. **Fast startup and near-instant data access**
6. **Safe automatic replanning**
7. **No destructive silent schedule changes**
8. **User-controlled backup/export**
9. **Privacy-preserving local storage**
10. **Architecture designed for future optional cloud features without requiring them**

---

# 2. Recommended Technology Stack

## 2.1 Mobile Framework

Recommended:

**Flutter**

Reasons:

- Single codebase for Android and iOS.
- Strong offline/local database support.
- Good localization support for বাংলা and English.
- Good performance for calendar, planning, charts, and large local datasets.
- Mature notification and background-task ecosystem.
- Suitable for standalone mobile applications.

Alternative:

- Native Android with Kotlin + Jetpack Compose.
- Native iOS with SwiftUI.

Flutter is preferred if the goal is a single mobile codebase.

---

# 3. Flutter Stack

Recommended packages/libraries should be selected carefully and kept minimal.

## 3.1 State Management

Recommended:

**Riverpod**

Responsibilities:

- Screen state.
- Async local database state.
- Planner state.
- Session timer state.
- Settings state.
- Localization state.
- Notification preferences.
- Backup/restore state.

Use feature-scoped providers instead of a single large global state container.

---

## 3.2 Local Database

Recommended:

**Drift + SQLite**

Why Drift:

- Strong relational querying.
- Type-safe queries.
- Transactions.
- Migration support.
- Good support for indexed scheduling queries.
- Works well with complex relationships such as:
  - Subjects
  - Chapters
  - Exams
  - Study plans
  - Tasks
  - Sessions
  - Revisions
  - Availability
  - Exceptions

Alternative:

- Isar.

Drift is preferred because Pocket Tutor has strongly relational planning data and many date-based queries.

---

## 3.3 Preferences

Use:

**SharedPreferences** or equivalent lightweight key-value storage.

Suitable for:

- Theme.
- Language.
- First-day-of-week preference.
- Current plan ID.
- Notification toggles.
- Intro/onboarding flags.
- Default timer settings.

Do not store academic business data in preferences.

---

## 3.4 Secure Storage

Use platform secure storage for:

- Backup encryption key metadata.
- User-created local PIN if implemented later.
- Optional cloud provider tokens in advanced versions.

Do not store normal study data in secure storage.

---

## 3.5 Notifications

Use:

- Local notification plugin.
- Time-zone-aware scheduling.

Notification categories:

- Daily plan.
- Study session.
- Revision due.
- Exam countdown.
- Missed plan.
- Evening summary.

No remote push service is required.

---

## 3.6 Background Work

Use platform-compatible background scheduling only for tasks that genuinely need it.

Examples:

- Refresh next-day notifications.
- Detect missed tasks.
- Generate next-day plan if configured.
- Lightweight backup preparation.

The app should never depend on background execution for correctness.

If background execution does not happen, the next foreground launch must reconcile the state.

---

## 3.7 Serialization

Use generated serialization for:

- Backup payloads.
- Import/export data.
- Planner snapshots.
- Report generation models.

JSON is suitable for portable backups.

---

## 3.8 Charts

Use a lightweight charting library for:

- Syllabus completion.
- Planned vs actual study time.
- Weekly trends.
- Subject balance.
- Revision progress.

Do not make charts essential for understanding the core study state.

---

# 4. High-Level Architecture

Recommended architecture:

```text
Presentation Layer
    ↓
Application / Use Case Layer
    ↓
Domain Layer
    ↓
Repository Interfaces
    ↓
Data Layer
    ↓
SQLite / Device Services
```

Additional cross-cutting services:

```text
Planning Engine
Revision Engine
Notification Scheduler
Backup Manager
Report Generator
Settings Service
Clock / Date Service
```

---

# 5. Layer Responsibilities

## 5.1 Presentation Layer

Contains:

- Screens.
- Widgets/components.
- UI controllers/providers.
- Form validation state.
- View models.
- Navigation.

Examples:

- Today screen.
- Subject screen.
- Chapter screen.
- Planner screen.
- Progress dashboard.
- Settings screen.

The presentation layer should not contain scheduling algorithms.

---

## 5.2 Application Layer

Contains use cases such as:

- CreateSubject
- AddChapter
- UpdateChapterDifficulty
- CreateExam
- GenerateStudyPlan
- ReplanMissedTasks
- CompleteStudyTask
- RecordStudySession
- GenerateRevisionQueue
- UpdateStudyAvailability
- ExportBackup
- RestoreBackup

This layer coordinates repositories and domain services.

---

## 5.3 Domain Layer

Contains:

- Core entities.
- Value objects.
- Planner rules.
- Priority scoring.
- Revision policies.
- Readiness calculation.
- Progress calculation.
- Forecasting rules.

The domain should not depend directly on Flutter or SQLite.

---

## 5.4 Data Layer

Contains:

- Drift database.
- DAO classes.
- Repository implementations.
- Database migrations.
- Import/export mappers.
- Device notification adapter.
- Secure storage adapter.

---

# 6. Suggested Project Structure

```text
lib/
  app/
    app.dart
    router/
    theme/
    localization/

  core/
    database/
    errors/
    utils/
    time/
    notifications/
    backup/
    logging/
    validation/

  features/
    onboarding/
      data/
      domain/
      application/
      presentation/

    study_plans/
      data/
      domain/
      application/
      presentation/

    subjects/
      data/
      domain/
      application/
      presentation/

    syllabus/
      data/
      domain/
      application/
      presentation/

    exams/
      data/
      domain/
      application/
      presentation/

    planner/
      data/
      domain/
      application/
      presentation/

    sessions/
      data/
      domain/
      application/
      presentation/

    revision/
      data/
      domain/
      application/
      presentation/

    progress/
      data/
      domain/
      application/
      presentation/

    notifications/
      application/
      presentation/

    backup_restore/
      data/
      application/
      presentation/

    settings/
      data/
      application/
      presentation/
```

---

# 7. Core Domain Model

## 7.1 StudentProfile

Fields:

- id
- displayName
- studyLevel
- institution
- academicYear
- preferredLanguage
- createdAt
- updatedAt

Study level values:

- SSC
- HSC
- UNIVERSITY
- ADMISSION
- DIPLOMA
- OTHER

---

## 7.2 StudyPlan

Represents an academic or exam-focused planning context.

Fields:

- id
- name
- description
- planType
- status
- startDate
- targetEndDate
- primaryExamId
- planningMode
- dailyIntensity
- maxDailyMinutes
- maxSessionMinutes
- planningBufferPercent
- revisionBufferDays
- createdAt
- updatedAt
- archivedAt

Status:

- ACTIVE
- PAUSED
- COMPLETED
- ARCHIVED

Planning modes:

- BALANCED
- WEAK_SUBJECT_FOCUS
- LIGHT
- EXAM_CRUNCH
- CUSTOM

---

## 7.3 Subject

Fields:

- id
- studyPlanId
- name
- code
- paperName
- colorToken
- iconToken
- priority
- difficulty
- confidence
- status
- sortOrder
- createdAt
- updatedAt

Priority:

- LOW
- NORMAL
- HIGH
- CRITICAL

Difficulty:

- VERY_EASY
- EASY
- MODERATE
- DIFFICULT
- VERY_DIFFICULT

Confidence:

- VERY_LOW
- LOW
- MEDIUM
- HIGH
- VERY_HIGH

---

## 7.4 Chapter

Fields:

- id
- subjectId
- title
- chapterNumber
- estimatedMinutes
- completedMinutes
- difficulty
- confidence
- priority
- examImportance
- status
- notes
- sortOrder
- createdAt
- updatedAt
- completedAt

Status:

- NOT_STARTED
- PLANNED
- IN_PROGRESS
- COMPLETED
- REVISION_DUE
- REVISED
- SKIPPED

---

## 7.5 Topic

Fields:

- id
- chapterId
- title
- estimatedMinutes
- completedMinutes
- difficulty
- confidence
- priority
- examImportance
- status
- notes
- sortOrder
- createdAt
- updatedAt

Topics are optional.

If a chapter has no topics, planning happens at chapter level.

---

## 7.6 Exam

Fields:

- id
- studyPlanId
- name
- examType
- startDate
- endDate
- timeOfDay
- importance
- notes
- createdAt
- updatedAt

Types:

- CLASS_TEST
- QUIZ
- MIDTERM
- FINAL
- BOARD
- ADMISSION
- MODEL_TEST
- CUSTOM

---

## 7.7 ExamSyllabusItem

Links exams with subjects/chapters/topics.

Fields:

- id
- examId
- subjectId
- chapterId
- topicId
- weight
- isRequired

---

## 7.8 WeeklyAvailability

Fields:

- id
- studyPlanId
- weekday
- totalAvailableMinutes
- isStudyDay
- preferredStartTime
- preferredEndTime
- createdAt
- updatedAt

---

## 7.9 AvailabilityWindow

Optional advanced structure for multiple sessions.

Fields:

- id
- weeklyAvailabilityId
- startTime
- endTime
- label

Example:

Morning:

06:30–07:30

Evening:

20:00–22:00

---

## 7.10 CalendarException

Fields:

- id
- studyPlanId
- date
- exceptionType
- availableMinutesOverride
- reason
- isNoStudyDay
- createdAt

Types:

- HOLIDAY
- COACHING
- EXAM
- FAMILY_EVENT
- TRAVEL
- SICK
- CUSTOM

---

## 7.11 StudyTask

This is the main executable planning unit.

Fields:

- id
- studyPlanId
- subjectId
- chapterId
- topicId
- examId
- taskType
- title
- plannedDate
- plannedStartTime
- plannedMinutes
- actualMinutes
- priorityScore
- isLocked
- status
- completionPercent
- source
- generationBatchId
- createdAt
- updatedAt
- completedAt

Task types:

- NEW_STUDY
- CONTINUE_STUDY
- PRACTICE
- REVISION
- MOCK_TEST
- ASSIGNMENT
- READING
- CUSTOM

Status:

- PLANNED
- IN_PROGRESS
- PARTIALLY_COMPLETED
- COMPLETED
- MISSED
- SKIPPED
- CANCELLED

Source:

- AUTO_PLANNER
- MANUAL
- QUICK_STUDY
- REVISION_ENGINE
- CATCH_UP

---

## 7.12 StudySession

Fields:

- id
- studyTaskId
- subjectId
- chapterId
- topicId
- startedAt
- endedAt
- plannedMinutes
- actualMinutes
- completionPercent
- result
- confidenceBefore
- confidenceAfter
- note
- createdAt

Result:

- FULLY_COMPLETED
- MOSTLY_COMPLETED
- PARTIALLY_COMPLETED
- COULD_NOT_STUDY

---

## 7.13 RevisionSchedule

Fields:

- id
- studyPlanId
- chapterId
- topicId
- sourceStudySessionId
- revisionNumber
- dueDate
- estimatedMinutes
- status
- completedAt
- createdAt

Status:

- PENDING
- SCHEDULED
- COMPLETED
- SKIPPED
- OVERDUE

---

## 7.14 Goal

Fields:

- id
- studyPlanId
- goalType
- targetValue
- periodType
- startDate
- endDate
- active

Examples:

- STUDY_MINUTES = 120/day
- TASKS_COMPLETED = 3/day
- CHAPTERS_COMPLETED = 5/week

---

## 7.15 UserSettings

Fields:

- language
- themeMode
- firstDayOfWeek
- defaultSessionMinutes
- defaultBreakMinutes
- revisionPolicy
- notificationPreferences
- analyticsEnabled
- autoReplanEnabled

---

# 8. Database Schema Recommendations

Suggested tables:

```text
student_profiles
study_plans
subjects
chapters
topics
exams
exam_syllabus_items
weekly_availability
availability_windows
calendar_exceptions
study_tasks
study_sessions
revision_schedules
goals
app_settings
planner_runs
backup_history
```

---

# 9. Database Indexes

Important indexes:

```text
study_tasks(study_plan_id, planned_date)
study_tasks(status, planned_date)
study_tasks(subject_id, status)
study_tasks(chapter_id, status)

chapters(subject_id, status)
topics(chapter_id, status)

exams(study_plan_id, start_date)

revision_schedules(due_date, status)
revision_schedules(chapter_id, status)

study_sessions(started_at)
study_sessions(subject_id, started_at)

calendar_exceptions(study_plan_id, date)
weekly_availability(study_plan_id, weekday)
```

---

# 10. Database Constraints

Recommended:

- Foreign keys enabled.
- Cascade only when behavior is safe.
- Avoid accidental cascade deletion of historical study sessions.
- Use soft delete or archival for important academic history where appropriate.

Example:

Deleting a subject should require explicit confirmation because it may affect:

- Chapters.
- Topics.
- Tasks.
- Revision schedules.
- Progress calculations.

Study history can either be:

1. Deleted with explicit confirmation, or
2. Preserved as archived historical records.

Choose one behavior consistently.

---

# 11. Database Transactions

Use transactions for:

- Subject deletion.
- Import/restore.
- Completing a study task.
- Recording session + updating chapter progress.
- Generating a study plan.
- Replanning tasks.
- Bulk chapter creation.
- Creating revision schedules.

Example task completion transaction:

```text
BEGIN

Insert StudySession
Update StudyTask
Update Chapter completedMinutes
Update Topic completedMinutes
Update confidence
Generate revision schedule
Recalculate completion status

COMMIT
```

---

# 12. Planning Engine Overview

The planner is the core domain service.

Recommended components:

```text
PlanningInputBuilder
PriorityScorer
CapacityCalculator
TaskSplitter
TaskAllocator
RevisionAllocator
BacklogResolver
ConstraintValidator
PlanForecastService
PlanDiffGenerator
```

---

# 13. Planning Inputs

The planner receives:

- Current date.
- Study plan configuration.
- Exam dates.
- Remaining chapters/topics.
- Estimated remaining minutes.
- Difficulty.
- Confidence.
- Priority.
- Exam importance.
- Revision requirements.
- Weekly availability.
- Date exceptions.
- Existing locked tasks.
- Missed tasks.
- Planning buffer.
- Maximum session length.

---

# 14. Capacity Calculation

For each planning day:

```text
Base Available Minutes
- Calendar Exception Reduction
- Fixed Locked Study Tasks
- Planning Buffer
= Schedulable Capacity
```

Example:

Available:

180 min

Planning buffer:

15%

Buffer:

27 min

Schedulable:

153 min

Round appropriately.

---

# 15. Planning Buffer

Default recommendation:

**10–20%**

Example:

3 hours available:

180 minutes

15% buffer:

27 minutes

Planner may schedule:

153 minutes

Benefits:

- Prevent unrealistic schedules.
- Allow breaks.
- Handle unexpected delay.
- Avoid fragile plans.

---

# 16. Remaining Work Calculation

For every chapter/topic:

```text
remainingMinutes =
max(
    estimatedMinutes - completedEquivalentMinutes,
    0
)
```

If partial completion is recorded as a percentage but no actual minutes are known:

```text
remainingMinutes =
estimatedMinutes × (1 - completionPercent)
```

Prefer actual measured study time when available, but never assume study time directly equals knowledge mastery.

---

# 17. Priority Scoring

Recommended normalized score:

```text
PriorityScore =
    ExamUrgencyWeight
  + DifficultyWeight
  + LowConfidenceWeight
  + SubjectPriorityWeight
  + ChapterPriorityWeight
  + ExamImportanceWeight
  + BacklogWeight
  + RevisionWeight
  + NeglectWeight
```

Each component should be deterministic and configurable.

Example 0–100 scoring:

```text
Exam urgency      0–25
Difficulty        0–10
Low confidence    0–15
Subject priority  0–10
Chapter priority  0–10
Exam importance   0–10
Backlog age       0–10
Revision need     0–5
Neglect           0–5
```

Total:

0–100

---

# 18. Exam Urgency Score

Possible formula:

```text
daysRemaining = examDate - today
```

Example mapping:

```text
> 60 days      = 5
31–60 days     = 10
15–30 days     = 15
8–14 days      = 20
4–7 days       = 23
0–3 days       = 25
```

This should be modified by the percentage of unfinished syllabus.

---

# 19. Syllabus Pressure

Define:

```text
unfinishedRatio =
remainingEstimatedMinutes / totalEstimatedMinutes
```

A subject with:

- 40 days remaining and 80% unfinished

should rank higher than:

- 40 days remaining and 15% unfinished.

A useful urgency modifier:

```text
pressure =
unfinishedMinutes / remainingSchedulableMinutesBeforeExam
```

Interpretation:

```text
pressure < 0.5      Comfortable
0.5–0.8             Healthy
0.8–1.0             Tight
1.0–1.2             At Risk
> 1.2                Impossible without change
```

---

# 20. Difficulty Weight

Suggested:

```text
Very Easy       1
Easy            3
Moderate        5
Difficult       8
Very Difficult 10
```

Difficult topics may also receive:

- Earlier scheduling.
- Longer session allocation.
- Additional revision sessions.

---

# 21. Confidence Weight

Suggested:

```text
Very High   1
High        3
Medium      7
Low        11
Very Low   15
```

Confidence must never be treated as a precise measurement of actual exam performance.

---

# 22. Backlog Weight

For missed tasks:

```text
BacklogWeight =
min(daysOverdue × factor, maximum)
```

Example:

```text
1 day overdue   +2
3 days overdue  +5
7+ days overdue +10
```

Do not force every backlog task into tomorrow.

---

# 23. Neglect Detection

Purpose:

Prevent one subject from being ignored.

For each subject calculate:

```text
daysSinceLastStudy
weeklyStudyShare
requiredStudyShare
```

If actual share is significantly below required share:

Add neglect priority.

Example:

Required weekly allocation:

Chemistry = 25%

Actual:

Chemistry = 7%

Planner should increase Chemistry priority.

---

# 24. Task Splitting

If remaining work exceeds maximum session length:

Example:

Chapter remaining:

180 min

Maximum session:

50 min

Create:

- 50 min
- 50 min
- 50 min
- 30 min

Avoid generating extremely short fragments.

Recommended minimum generated study block:

15–20 minutes.

Small leftovers may be merged with adjacent work.

---

# 25. Allocation Algorithm

High-level algorithm:

```text
1. Build all eligible study items.
2. Calculate remaining work.
3. Calculate priority score.
4. Build capacity for each date.
5. Reserve locked/manual tasks.
6. Reserve required revision slots.
7. Sort remaining study items by urgency/priority.
8. Allocate tasks to available dates.
9. Apply subject-balance constraints.
10. Apply session-length constraints.
11. Verify exam deadlines.
12. Calculate expected completion date.
13. Generate warnings.
14. Save plan in one transaction.
```

---

# 26. Planner Pseudocode

```text
function generatePlan(input):

    days = buildPlanningDays(
        today,
        finalExamDate,
        weeklyAvailability,
        calendarExceptions
    )

    capacity = calculateCapacity(days)

    lockedTasks = getLockedTasks()

    reserveCapacity(capacity, lockedTasks)

    workItems = buildRemainingWorkItems()

    for each item in workItems:
        item.priorityScore = score(item)

    workItems.sort(descending priorityScore)

    revisionItems = buildRevisionRequirements()

    allocateRequiredRevisions(revisionItems, capacity)

    for each workItem:
        chunks = splitIntoSessions(workItem)

        for each chunk:
            date = findBestDate(
                chunk,
                capacity,
                examDeadline,
                balanceRules
            )

            if no date exists:
                recordPlanningRisk(chunk)
            else:
                allocate(chunk, date)
                reduceCapacity(date, chunk.minutes)

    validatePlan()

    return PlanResult
```

---

# 27. Date Selection Rules

`findBestDate()` should consider:

1. Must be before relevant exam.
2. Must have remaining capacity.
3. Prefer earlier dates for high difficulty.
4. Prefer preferred study periods when possible.
5. Avoid too many consecutive sessions of same subject.
6. Avoid overloading one day.
7. Keep buffer.
8. Respect locked tasks.
9. Respect no-study days.
10. Prefer time for revision after initial completion.

---

# 28. Subject Balance Rules

Example guardrails:

- No more than 50–60% of a day's auto-planned time on one subject unless:
  - Exam is very close.
  - User is in Focus Subject mode.
  - User selects Exam Crunch mode.
- Avoid more than 2 consecutive generated tasks for the same subject when alternatives exist.
- Ensure neglected high-priority subjects get slots.

---

# 29. Revision Engine

Revision is treated separately from initial study.

Recommended default pattern:

```text
Revision 1: 2 days after study
Revision 2: 7 days after study
Revision 3: before exam
```

Advanced pattern may be:

```text
1 day
3 days
7 days
14 days
Exam review
```

Keep default simple.

---

# 30. Revision Scheduling Rules

When a study task becomes substantially completed:

1. Create revision requirements.
2. Determine next due date.
3. Check exam date.
4. Avoid revision after exam.
5. Allocate shorter session.
6. Increase duration for low-confidence topics.
7. Allow revision to be postponed once or twice.
8. Mark overdue if repeatedly missed.

---

# 31. Revision Duration

Example baseline:

```text
Initial Study Duration × RevisionRatio
```

Suggested:

```text
Revision 1 = 25%
Revision 2 = 20%
Revision 3 = 15%
```

Minimum:

10 minutes.

Maximum should be configurable.

---

# 32. Confidence-Driven Revision

Example:

```text
Very Low confidence:
  +50% revision duration
  additional revision cycle

Low confidence:
  +25% revision duration

Medium:
  normal

High/Very High:
  shorter revision unless exam importance is high
```

---

# 33. Missed Task Handling

At day rollover:

A planned task still incomplete becomes:

**MISSED**

Do not immediately generate duplicate tasks.

Instead:

- Keep original history.
- Calculate remaining work.
- Replan remaining portion.

Example:

Task:

60 min

Completion:

40%

Remaining:

36 min

Replanning should create approximately 36 min of continued work.

---

# 34. Automatic Replanning

Replanning triggers:

- Missed task.
- Exam date change.
- New chapter.
- Deleted chapter.
- Availability change.
- Difficulty change.
- Confidence change.
- Priority change.
- Calendar exception.
- User request.
- Large estimation variance.

---

# 35. Replanning Strategy

Replanning should preserve:

- Completed tasks.
- In-progress tasks.
- Locked future tasks.
- Manually fixed tasks.

Auto-generated future tasks may be replaced.

Recommended approach:

```text
Freeze:
  completed
  in-progress
  locked
  manual fixed

Recalculate:
  unfinished auto-generated tasks
  revisions not yet completed
```

---

# 36. Replan Preview

Before applying a major replan, generate a diff.

Example:

```text
5 tasks moved
2 tasks shortened
1 revision added
Expected completion:
Nov 18 → Nov 20
```

Small daily background replans may be automatically applied if user enabled:

**Auto Replan**

Define threshold:

- Minor: same-week movement, no increased daily limit.
- Major: exam risk, >3-day changes, increased workload, moving locked-adjacent tasks.

Major replans should request review.

---

# 37. Catch-Up Engine

Input:

- Missed tasks.
- Backlog remaining minutes.
- Current daily capacity.
- Exam deadlines.

Output:

- Recovery days.
- Extra minutes per day.
- Tasks to prioritize.
- Risk level.

Example:

Backlog:

200 min

Available spare capacity:

```text
Saturday +40
Sunday +40
Tuesday +30
Friday +90
```

Total:

200 min

---

# 38. Impossible Schedule Detection

Calculate:

```text
totalRequiredMinutesBeforeExam
vs
totalSchedulableMinutesBeforeExam
```

If:

```text
required > capacity
```

return structured planning warning.

Example:

```text
Required: 48h
Available: 29h
Shortfall: 19h
```

Possible actions:

- Increase availability.
- Increase intensity.
- Reduce revision buffer.
- Prioritize required chapters.
- Change estimated duration.
- Skip lower-priority optional content.

Never silently ignore the shortfall.

---

# 39. Finish-Date Forecast

Calculate earliest realistic finish date using:

- Remaining study minutes.
- Daily capacity.
- Existing tasks.
- Revision policy.

Output:

- Expected syllabus finish date.
- Exam date.
- Revision buffer days.
- Risk category.

---

# 40. On-Track Status

Suggested:

```text
AHEAD
ON_TRACK
SLIGHTLY_BEHIND
BEHIND
AT_RISK
```

Inputs:

- Planned completion percentage.
- Actual completion percentage.
- Capacity pressure.
- Backlog.
- Exam proximity.
- Revision completion.

Do not use a single raw percentage only.

---

# 41. Readiness Indicator

Readiness is informational, not a score prediction.

Possible weighted calculation:

```text
40% syllabus completion
25% confidence
20% revision completion
10% backlog health
5% consistency
```

Always label clearly:

**Preparation Readiness**

Do not imply exam result prediction.

---

# 42. Progress Calculation

## 42.1 Chapter Progress

If topic-based:

```text
chapterProgress =
weighted completion of topics
```

Otherwise:

```text
completedMinutes / estimatedMinutes
```

Clamp:

0–100%.

---

# 43. Subject Progress

Recommended:

Weighted by estimated study time.

```text
sum(chapter estimated × chapter completion)
/
sum(chapter estimated)
```

This is better than simple chapter counts because chapters vary in size.

---

# 44. Overall Syllabus Progress

Weighted across subjects by:

- Total estimated workload.

Do not average subject percentages equally unless each subject should intentionally have equal weight.

---

# 45. Study Time Metrics

Track separately:

- Planned minutes.
- Actual minutes.
- Completed task minutes.
- Revision minutes.
- Quick study minutes.

This enables accurate analytics.

---

# 46. Study Session Timer Design

Timer state:

```text
IDLE
RUNNING
PAUSED
COMPLETED
CANCELLED
```

Persist active timer state so process death does not lose a study session.

Fields to persist:

- studyTaskId
- startedAt
- pausedAt
- accumulatedPausedSeconds
- currentState

Calculate elapsed time from timestamps rather than incrementing every second in persistent storage.

---

# 47. App Lifecycle and Timer Recovery

If application is terminated during a timer:

On restart:

1. Detect active timer session.
2. Calculate elapsed wall-clock time.
3. Ask if student was studying the entire time when duration is suspiciously long.
4. Allow editing actual duration.
5. Resume or finish.

---

# 48. Manual Completion

Timer must never be mandatory.

Student can:

- Mark completed.
- Enter actual minutes.
- Choose completion percentage.
- Update confidence.

This keeps daily usage fast.

---

# 49. Quick Study

Quick Study creates:

- A completed or in-progress StudyTask with source `QUICK_STUDY`.
- A StudySession.

It should update:

- Chapter progress.
- Subject statistics.
- Confidence if user changes it.
- Revision schedule.

---

# 50. Calendar Design

Calendar source of truth:

`study_tasks.planned_date`

Calendar indicators:

- Planned task.
- Completed day.
- Missed day.
- Exam.
- Revision.
- No-study day.

Do not store duplicate calendar event data unless needed for performance.

---

# 51. Notification Architecture

Recommended service abstraction:

```text
NotificationScheduler
  scheduleDailyPlan()
  scheduleStudyReminder()
  scheduleRevisionReminder()
  scheduleExamCountdown()
  scheduleEveningReview()
  cancelForTask()
  rescheduleAll()
```

---

# 52. Notification IDs

Generate stable local notification IDs based on domain IDs.

Example:

```text
daily_plan: dateHash
study_task: taskId hash
revision: revisionScheduleId hash
exam: examId + threshold
```

Stable IDs allow safe replacement/cancellation.

---

# 53. Notification Reconciliation

Whenever important planning data changes:

- Cancel invalid future notifications.
- Regenerate relevant future notifications.

Triggers:

- Replan.
- Exam date update.
- Task completion.
- Task deletion.
- Notification setting change.

---

# 54. Localization

Support:

- বাংলা
- English

Use ARB/Flutter localization or equivalent.

Do not hardcode translated strings inside widgets.

Recommended keys:

```text
today_title
today_tasks_count
syllabus_progress
exam_days_remaining
start_study
mark_complete
revision_due
backlog
```

---

# 55. Bengali Number Formatting

Decide whether numeric values follow:

- Latin digits by default.
- Optional Bengali digits in advanced settings.

Example:

```text
18 days
১৮ দিন
```

Keep calculation/storage numeric and localize only the presentation.

---

# 56. Date and Time Handling

Store:

- Timestamps in UTC where relevant.
- Study-plan local dates as explicit date-only values.
- User's time zone context where needed.

For planning:

Use local calendar dates.

Avoid deriving planned date by UTC timestamps alone.

---

# 57. Bangladesh Week Model

Recommended default:

- Week may start Saturday for Bangladesh student context.

But this should be configurable.

Settings:

- Saturday
- Sunday
- Monday

---

# 58. Navigation

Suggested routes:

```text
/splash
/onboarding
/home
/today
/planner
/planner/day
/planner/week
/planner/calendar
/syllabus
/subjects/:id
/chapters/:id
/progress
/backlog
/revision
/exams
/settings
/backup
```

---

# 59. Bottom Navigation

Recommended:

1. Today
2. Plan
3. Syllabus
4. Progress
5. More

Navigation state should persist across tab switches.

---

# 60. Today Screen Data Query

The Today dashboard should load:

- Today's tasks.
- Today's total planned minutes.
- Completion count.
- Nearest exam.
- Overall syllabus completion.
- On-track status.
- Backlog minutes.
- Revision due count.

Prefer one application-level aggregator instead of many independent database queries from widgets.

---

# 61. Dashboard Performance

Use:

- Indexed date queries.
- Cached derived metrics.
- Reactive streams only where helpful.

Avoid recalculating full study plan every time a widget rebuilds.

---

# 62. Derived Statistics Cache

For large histories, optionally maintain daily aggregates:

Table:

`daily_study_stats`

Fields:

- date
- studyPlanId
- plannedMinutes
- actualMinutes
- tasksPlanned
- tasksCompleted
- revisionMinutes

Regenerate if needed.

MVP may calculate from raw data until performance justifies this table.

---

# 63. Search

Search fields:

- Subject name.
- Chapter title.
- Topic title.
- Task title.
- Notes.

MVP:

SQLite `LIKE`.

Advanced:

SQLite FTS5.

---

# 64. Filtering

Filtering should happen in database where possible.

Examples:

```text
difficulty
confidence
priority
status
subject
exam
revisionDue
```

---

# 65. Backup Design

Backup format:

```text
PocketTutorBackup
  schemaVersion
  appVersion
  createdAt
  devicePlatform
  locale
  payload
  checksum
```

Payload should include all user-owned app data.

---

# 66. Backup Format

Recommended:

JSON compressed as ZIP.

Example extension:

```text
.pockettutor
```

Internally:

```text
manifest.json
data.json
```

Advanced:

Encrypted archive.

---

# 67. Encrypted Backup

Recommended for production.

Flow:

```text
Serialize data
→ Compress
→ Encrypt using AES-256-GCM
→ Write file
```

Encryption key options:

1. User password-derived key.
2. Device-generated key for device-only backup.
3. User-selected password for portable backup.

For portable backups, password-based encryption is preferable.

Use a modern KDF such as:

- Argon2id
- scrypt
- PBKDF2 only if platform constraints require it

Include:

- Random salt.
- Nonce.
- Authentication tag.

---

# 68. Backup Integrity

Store checksum or rely on authenticated encryption.

Restore validation:

- File format.
- Schema version.
- Encryption authentication.
- Required fields.
- Referential consistency.

Never overwrite current database until validation succeeds.

---

# 69. Restore Strategy

Recommended process:

```text
1. Parse backup
2. Validate
3. Migrate backup schema if needed
4. Create temporary database
5. Import into temporary database
6. Run integrity checks
7. Ask user for final confirmation
8. Replace live database
9. Rebuild notifications
10. Recalculate derived metrics
```

---

# 70. Import Conflict Policy

For full restore:

Prefer:

**Replace all current Pocket Tutor data**

For selected-plan import:

Use new IDs and remap relationships.

Avoid complicated object-level merging in MVP.

---

# 71. Export Reports

Supported future formats:

- PDF.
- CSV.
- JSON.

Reports:

- Study plan.
- Study history.
- Syllabus progress.
- Weekly summary.
- Exam preparation report.

Report generation must work offline.

---

# 72. Optional Cloud Backup

Advanced only.

Possible providers:

- Google Drive.
- OneDrive.
- Dropbox.

Architecture:

```text
CloudBackupProvider
  authenticate()
  upload()
  listBackups()
  download()
  delete()
```

Cloud provider integration should remain isolated from the rest of the app.

Core app must not require cloud access.

---

# 73. Privacy Architecture

Core rules:

- No account required.
- No backend required.
- No automatic upload.
- No silent cloud sync.
- No advertising identifiers required.
- No student data leaves device without explicit action.

---

# 74. Analytics

Recommendation for MVP:

Do not require analytics.

If analytics are added later:

- Make privacy-conscious.
- Avoid collecting chapter names, notes, institution, or other student content.
- Prefer aggregate event names only.
- Allow opt-out.

---

# 75. Security

## 75.1 Local Database

For MVP:

Standard app sandbox may be sufficient.

Advanced:

Use SQLCipher if stronger at-rest protection is required.

## 75.2 Sensitive Exports

Warn:

> Exported files may contain your study data.

For encrypted export:

Use password protection.

## 75.3 Screenshot Protection

Not generally necessary because data is low sensitivity.

Could be optional for private notes.

---

# 76. Error Model

Create typed application errors:

```text
ValidationError
DatabaseError
PlanningError
ImpossibleScheduleError
BackupError
RestoreError
NotificationError
ExportError
PermissionError
```

Presentation layer maps these to localized user messages.

---

# 77. Logging

Use local structured logs for development.

Production logs:

- Avoid personal study content.
- Avoid notes.
- Avoid institution names.
- Avoid backup file passwords.
- Avoid encryption keys.

Log:

- Planner execution duration.
- Migration success/failure.
- Notification scheduling errors.
- Backup validation failures.

---

# 78. Planner Run Logging

Table:

`planner_runs`

Fields:

- id
- studyPlanId
- trigger
- startedAt
- completedAt
- inputTaskCount
- outputTaskCount
- riskLevel
- expectedFinishDate
- algorithmVersion

Useful for debugging without storing sensitive content.

---

# 79. Algorithm Versioning

Store:

`algorithmVersion`

inside generated tasks or planner run.

This helps when planning logic changes across app versions.

Example:

```text
planner_v1
planner_v2
```

Existing completed tasks should never be rewritten because of a new algorithm.

---

# 80. Database Migration Strategy

Use sequential migrations.

Example:

```text
v1 → initial schema
v2 → topics
v3 → revision schedules
v4 → planner run metadata
```

Migration requirements:

- Transactional.
- Tested.
- Never silently wipe user data.
- Backup before risky migrations when practical.

---

# 81. App Startup Flow

```text
Launch
↓
Initialize database
↓
Run migration
↓
Load settings
↓
Resolve locale/theme
↓
Check active timer
↓
Check date rollover
↓
Reconcile missed tasks
↓
Reconcile notifications
↓
Open Today screen
```

Do heavy work asynchronously after the first meaningful UI when possible.

---

# 82. Date Rollover Reconciliation

When app opens on a new day:

1. Find yesterday and older pending tasks.
2. Mark overdue tasks missed where applicable.
3. Update backlog.
4. Determine if automatic replan is needed.
5. Refresh revision due state.
6. Schedule today's reminders.

---

# 83. Planner Execution Performance

Typical student data is small.

Expected:

- Subjects: < 30.
- Chapters/topics: < 1,000.
- Future tasks: < 2,000.
- Study sessions: a few thousand.

Planning engine should complete quickly on-device.

Aim:

- Normal replan under ~200–500 ms on modern phones.
- Large plans under a few seconds.

Do not optimize prematurely.

---

# 84. Concurrency

Only one planner run per StudyPlan at a time.

Use application-level mutex/lock.

Prevent:

- Two replans overwriting each other.
- Completing a task during destructive regeneration without reconciliation.

Recommended:

```text
plannerMutex.withLock {
    run planner transaction
}
```

---

# 85. Idempotency

Critical operations should be idempotent where possible.

Examples:

- Daily rollover.
- Notification regeneration.
- Revision schedule generation.

Avoid duplicate revisions when a completion event is processed twice.

Use unique constraints.

Example:

```text
UNIQUE(sourceStudySessionId, revisionNumber)
```

---

# 86. Optimistic UI

For simple edits:

- Subject rename.
- Theme change.
- Task completion.

Optimistic UI is acceptable if database operation is reliable.

For planning changes:

Wait for transaction completion before showing success.

---

# 87. Form Validation

Examples:

Exam:

- Date cannot be earlier than today unless importing historical data.

Chapter:

- Estimated minutes > 0.
- Completion 0–100%.

Availability:

- 0–1440 minutes/day.

Timer:

- Actual minutes cannot be negative.

Backup:

- Password confirmation required if encrypted.

---

# 88. Study Estimation Learning

Advanced feature.

Track:

```text
estimatedMinutes
actualMinutes
```

Calculate subject/chapter estimation bias.

Example:

```text
actual / estimated
```

If a student consistently needs:

1.3× estimated time

Planner can suggest:

> Your estimates for Physics are usually low. Adjust future estimates?

Do not change automatically without user permission in early versions.

---

# 89. What-If Simulation

Use the planner in non-persisting mode.

Input overrides:

- +30 study minutes/day.
- Different revision buffer.
- New exam date.
- Higher intensity.

Output:

- Expected completion date.
- Capacity pressure.
- Backlog risk.
- Revision buffer.

No database changes until user selects Apply.

---

# 90. Exam Crunch Mode

When activated:

Planner parameters change:

- Reduce planning buffer slightly.
- Increase exam urgency weighting.
- Prefer exam-linked chapters.
- Increase revision weighting.
- Reduce low-priority optional content.
- Allow higher daily intensity within user-defined maximum.

Never exceed configured hard maximum daily minutes.

---

# 91. Focus Subject Mode

Fields:

- subjectId
- startDate
- endDate
- boostFactor

Example:

```text
priority multiplier = 1.3
```

Still preserve other critical exam tasks.

---

# 92. Pause Subject

Paused subject:

- Excluded from new planning.
- Existing auto-generated tasks may be cancelled or held.
- Manual locked tasks remain unless user removes them.
- History remains.

---

# 93. Archive Behavior

Archived:

- StudyPlan
- Subject

should:

- Disappear from active planning.
- Remain queryable in history.
- Not create notifications.
- Not affect current stats unless viewing historical scope.

---

# 94. State Management Strategy

Use Riverpod providers by feature.

Examples:

```text
currentStudyPlanProvider
todayTasksProvider
todaySummaryProvider
subjectListProvider
chapterListProvider
plannerStatusProvider
activeStudySessionProvider
revisionQueueProvider
progressDashboardProvider
settingsProvider
```

Avoid broad invalidation of the entire app.

---

# 95. Repository Interfaces

Examples:

```text
StudyPlanRepository
SubjectRepository
ChapterRepository
ExamRepository
TaskRepository
SessionRepository
RevisionRepository
AvailabilityRepository
SettingsRepository
BackupRepository
```

Repositories expose domain models rather than raw Drift rows.

---

# 96. Use Case Examples

```text
CreateStudyPlanUseCase
GenerateInitialPlanUseCase
ReplanStudyPlanUseCase
MarkTaskCompletedUseCase
RecordPartialCompletionUseCase
StartStudySessionUseCase
FinishStudySessionUseCase
AddQuickStudyUseCase
GenerateCatchUpPlanUseCase
CalculateReadinessUseCase
ExportBackupUseCase
RestoreBackupUseCase
```

---

# 97. Testing Strategy

Testing layers:

1. Unit tests.
2. Repository tests.
3. Database tests.
4. Planner algorithm tests.
5. Widget tests.
6. Integration tests.
7. Migration tests.
8. Backup/restore round-trip tests.

---

# 98. Planner Unit Tests

Essential cases:

- One subject, one chapter.
- Multiple subjects.
- Exam tomorrow.
- Very large backlog.
- No available study time.
- Locked task consumes entire day.
- Partial completion.
- Different difficulties.
- Different confidence.
- No-study day.
- Extra study day.
- Revision due.
- Multiple exams.
- Subject balance.
- Impossible schedule.
- Exam crunch mode.
- Focus subject mode.

---

# 99. Planner Determinism Test

Given identical:

- Current date.
- Input data.
- Planner version.

Output must be identical.

Avoid randomness unless a stable seed is used.

Determinism makes debugging and user trust easier.

---

# 100. Database Tests

Test:

- Cascade behavior.
- Foreign key constraints.
- Transactions.
- Partial completion update.
- Subject deletion.
- Plan archive.
- Query indexes.
- Date filters.

---

# 101. Migration Tests

For each schema migration:

1. Create old-version DB fixture.
2. Populate representative data.
3. Run migration.
4. Verify:
   - no data loss.
   - relationships intact.
   - new defaults correct.

---

# 102. Backup Tests

Test:

- Export then restore.
- Encrypted export.
- Wrong password.
- Corrupt archive.
- Older schema version.
- Unknown future schema version.
- Partial file.
- Restore rollback.

---

# 103. Notification Tests

Test:

- Daily reminder.
- Exam countdown.
- Revision completion cancels reminder.
- Replan reschedules reminder.
- Permission denied.
- Timezone change.
- Device reboot where platform supports rescheduling.

---

# 104. Timer Tests

Test:

- Start.
- Pause.
- Resume.
- Finish.
- Process death.
- Midnight crossing.
- Manual actual time correction.
- Long accidental running session.

---

# 105. Accessibility Testing

Test:

- Large text.
- Screen readers.
- Contrast.
- Button labels.
- Bengali text rendering.
- Dynamic layout with longer translations.

---

# 106. Localization Testing

Test all critical flows in:

- English.
- বাংলা.

Special attention:

- Mixed English/Bengali subject names.
- Numbers.
- Date formatting.
- Long Bengali labels.
- Pluralization.

---

# 107. Performance Testing

Measure:

- Cold start.
- Today dashboard query.
- Plan generation.
- Weekly planner load.
- Progress dashboard.
- Backup creation.
- Restore.

---

# 108. Failure Recovery

## 108.1 Planner Failure

Keep previous valid plan.

Show:

> We couldn't update your study plan.

Provide:

- Retry.
- Review availability.

## 108.2 Database Write Failure

Do not update UI permanently until transaction succeeds.

## 108.3 Backup Failure

Keep current app data untouched.

## 108.4 Restore Failure

Rollback entirely.

Never leave partially restored data.

---

# 109. Common UI State Mapping

Application states:

```text
Loading
Empty
Ready
Saving
Success
ValidationError
RecoverableError
FatalError
```

Planner-specific:

```text
Idle
Generating
Generated
NeedsReview
Impossible
Failed
```

---

# 110. Offline Guarantee

The following must work without internet:

- Onboarding.
- Subject/chapter setup.
- Exam setup.
- Automatic planning.
- Replanning.
- Timer.
- Study completion.
- Revision scheduling.
- Progress.
- Calendar.
- Notifications.
- Backup to local file.
- Restore from local file.
- PDF/CSV generation when implemented.

---

# 111. Optional Online Features Boundary

Any future internet-dependent capability must sit outside core domain behavior.

Examples:

- Cloud backup.
- Optional AI suggestions.
- Shared syllabus templates.
- Sync across devices.

If internet is unavailable:

Core study planning remains fully functional.

---

# 112. Optional AI Architecture

AI is not required for Pocket Tutor.

If added later, AI should not replace the deterministic planner.

Possible uses:

- Suggest reasonable chapter estimates.
- Convert pasted syllabus text into chapter structure.
- Suggest study strategy.
- Summarize study trends.

Architecture:

```text
OptionalAiService
```

The application should always offer a non-AI path.

---

# 113. AI Privacy Rule

Never send the following without explicit consent:

- Notes.
- Institution.
- Study history.
- Exam details.
- Personal profile.

Provide clear preview of data before sending.

---

# 114. Data Retention

Since data is local:

- User controls deletion.
- Archived academic plans may remain indefinitely.
- Study history may be retained until deleted.

Provide:

- Delete plan.
- Reset progress.
- Delete all data.

---

# 115. Exported File Permissions

Use platform document pickers and scoped storage.

Android:

- Storage Access Framework.

iOS:

- Document picker / share sheet.

Avoid requesting broad storage permissions.

---

# 116. Android Considerations

Support:

- Material 3.
- WorkManager where appropriate.
- Alarm/notification permission handling.
- Android 13+ notification permission.
- Scoped storage.
- App shortcut actions.
- Home-screen widgets in later versions.

---

# 117. iOS Considerations

Support:

- Local notification permissions.
- Background limitations.
- App lifecycle recovery.
- Files export.
- Home-screen widgets in later versions.

Do not rely on guaranteed periodic background execution.

---

# 118. Minimum Platform Recommendation

At implementation time, select minimum versions based on current store requirements and library compatibility.

Avoid supporting very old OS versions if it significantly increases maintenance burden.

---

# 119. Theme System

Use semantic design tokens:

```text
primary
secondary
surface
success
warning
danger
info
```

Subject colors should be distinguishable in both light and dark themes.

Do not encode state meaning with color alone.

---

# 120. Accessibility-Friendly Status

Example:

Instead of only green:

```text
✓ On Track
```

Instead of only red:

```text
! At Risk
```

---

# 121. Background Planner Policy

Do not frequently regenerate the entire plan in background.

Prefer:

- Foreground reconciliation.
- Small daily check.
- User-triggered replanning.

This saves battery and avoids confusing schedule changes.

---

# 122. Planner Snapshot

Before applying a major replan, optionally save:

`PlannerSnapshot`

Fields:

- generatedAt
- previousExpectedFinishDate
- task summary
- risk state

This allows user-visible comparison and potential undo in advanced versions.

---

# 123. Undo Replan

Advanced:

Keep previous future-task generation batch.

On undo:

- Remove new auto-generated future tasks.
- Restore previous generation batch.

Do not undo completed tasks.

---

# 124. Generation Batch IDs

Every auto-plan run should generate:

`generationBatchId`

This allows:

- Safe replacement.
- Planner debugging.
- Replan diff.
- Undo.

---

# 125. Manual Task Protection

Manual tasks should never be silently deleted by auto replanning.

Rules:

- Manual unlocked task may move only if user explicitly allows.
- Manual locked task never moves automatically.
- Auto-generated task can move freely within constraints.

---

# 126. Scheduling Granularity

MVP recommendation:

Plan by **date + duration**, not exact clock time.

Optional preferred session:

- Morning.
- Afternoon.
- Evening.
- Night.

Exact start-time scheduling can be advanced.

Reason:

Students' real schedules are flexible and exact minute scheduling can make the planner brittle.

---

# 127. Exact Time Support

If introduced:

`plannedStartTime` is optional.

Locked exact-time tasks:

- Coaching.
- Mock test.
- Scheduled study group.

Normal study tasks remain duration-based.

---

# 128. MVP Technical Scope

## Required

- Flutter.
- Riverpod.
- Drift/SQLite.
- Local notifications.
- Local planner.
- Subjects.
- Chapters.
- Exams.
- Availability.
- Today plan.
- Task completion.
- Partial completion.
- Quick Study.
- Basic revision schedule.
- Progress.
- Backlog.
- Local backup/restore.
- Bangla + English.
- Dark mode.

## Exclude from MVP

- Cloud account.
- Cross-device sync.
- AI.
- Social features.
- Shared study plans.
- Teacher portal.
- Live collaboration.
- Advanced timetable integration.

---

# 129. Phase 2 Technical Additions

- Topic-level planning.
- More advanced catch-up algorithm.
- Revision queue.
- Study calendar.
- Weekly/monthly analytics.
- Subject balance.
- What-if planner.
- CSV/PDF reports.
- Improved estimation learning.

---

# 130. Phase 3 Technical Additions

- Multiple concurrent plans.
- Cloud backup providers.
- Optional sync architecture.
- Home-screen widgets.
- Assignment/deadline planning.
- Fixed class/coaching schedule.
- Advanced exam crunch.
- Optional AI features.

---

# 131. Future Sync Architecture

If synchronization is added later:

Use local database as the primary source.

Each syncable row should gain:

```text
syncId
updatedAt
deletedAt
revision
```

Sync architecture:

```text
Local DB
↓
Change Log
↓
Sync Engine
↓
Cloud Provider
```

Do not redesign the app around online-first networking.

---

# 132. Conflict Resolution

If future sync is added:

Prefer:

- Last-write-wins for simple settings.
- User-reviewed conflict for important academic structures.
- Append-only study sessions where possible.

Planning tasks should generally be regenerated from domain data rather than merged blindly.

---

# 133. Technical Risks

## Risk 1: Planner becomes too complicated

Mitigation:

- Start with deterministic rule-based algorithm.
- Version algorithm.
- Add complexity gradually.

## Risk 2: Students enter poor estimates

Mitigation:

- Easy estimate editing.
- Track actual vs estimated.
- Suggest adjustments later.

## Risk 3: Automatic replanning frustrates users

Mitigation:

- Protect manual/locked tasks.
- Show major replan preview.
- Keep plan changes explainable.

## Risk 4: Too much setup before value

Mitigation:

- Fast onboarding.
- Quick chapter entry.
- Bulk chapter creation.
- Allow rough estimates.

## Risk 5: Background limitations

Mitigation:

- Foreground reconciliation.
- Never rely on background jobs for correctness.

---

# 134. Explainable Planner

For each generated task, optionally expose:

**Why this task?**

Example:

> Physics was scheduled today because:
>
> - Exam is in 12 days.
> - Confidence is Low.
> - This chapter is marked High Priority.
> - You have not studied Physics for 3 days.

This builds trust in automation.

---

# 135. Explainable Risk

Example:

> Chemistry is At Risk because:
>
> - 420 minutes remain.
> - Only 300 available study minutes remain before the exam.
> - 2 revision sessions are still due.

This is better than showing only a red warning.

---

# 136. Domain Events

Useful internal events:

```text
StudyTaskCompleted
StudyTaskMissed
StudySessionFinished
ChapterCompleted
ExamDateChanged
AvailabilityChanged
RevisionCompleted
StudyPlanReplanned
```

These events may trigger:

- Progress recalculation.
- Revision generation.
- Notification changes.
- Replanning.

---

# 137. Event Processing

For MVP, events can be handled in-process synchronously.

No message queue is required.

Keep logic modular so event handling can become more sophisticated later if necessary.

---

# 138. Time Service Abstraction

Create:

```text
Clock
  now()
  today()
```

Do not call system time directly throughout domain logic.

Benefits:

- Deterministic planner tests.
- Easier exam countdown testing.
- Timezone testing.

---

# 139. ID Strategy

Use UUIDs or ULIDs for domain records.

Benefits:

- Safe future import/export.
- Easier future sync.
- No collision when merging imported plans.

---

# 140. Soft Delete

Recommended for:

- StudyPlan.
- Subject if preserving history.

Optional fields:

```text
deletedAt
```

For simple MVP, hard delete may still be acceptable when user explicitly confirms.

---

# 141. Revision After Chapter Completion

Chapter can be:

**Completed**

while revision status is separately tracked.

Do not change chapter back to "Incomplete" simply because revision is due.

Represent:

```text
contentCompletion = 100%
revisionState = DUE
```

This avoids confusing progress metrics.

---

# 142. Separate Completion and Confidence

Do not equate:

100% completion

with:

High confidence.

A student can finish a chapter and still mark confidence Low.

Planner should use both dimensions.

---

# 143. Separate Difficulty and Confidence

Difficulty:

How inherently challenging the student finds the material.

Confidence:

How prepared the student currently feels.

Both should affect planning differently.

---

# 144. Study Task Completion Rules

Example:

Full completion:

```text
completionPercent = 100
status = COMPLETED
```

Partial:

```text
0 < completionPercent < 100
status = PARTIALLY_COMPLETED
```

Skipped:

```text
status = SKIPPED
```

Missed:

System-detected when date passes and task remains planned.

---

# 145. Progress Update Rules

When StudyTask completes:

Update linked topic/chapter using work-equivalent completion.

Do not double-count repeated revisions as new syllabus completion.

Revision sessions affect:

- Revision completion.
- Confidence.
- Readiness.

Not:

- Initial syllabus completion.

---

# 146. Study History Integrity

Once a study session is completed:

Prefer append-only semantics.

Allow correction through:

- Edit actual minutes.
- Edit note.
- Edit confidence.

If corrected, retain updatedAt.

Do not delete historical sessions during replanning.

---

# 147. Daily Summary Generation

Derived from study sessions and tasks for date.

Metrics:

- Planned minutes.
- Actual minutes.
- Planned tasks.
- Completed tasks.
- Partial tasks.
- Missed tasks.
- Most studied subject.
- Remaining work.

No separate persistence is required initially.

---

# 148. Weekly Summary Generation

Aggregate local study data for selected week.

Metrics:

- Study time.
- Target.
- Completion percentage.
- Syllabus change.
- Revision count.
- Most studied subject.
- Neglected subject.
- Backlog delta.

---

# 149. Monthly Summary

Aggregate:

- Study hours.
- Completed tasks.
- Study days.
- Syllabus change.
- Revision sessions.
- Average daily study.
- Subject allocation.

---

# 150. Consistency Metric

Prefer:

```text
studyDays / availableStudyDays
```

over a punitive infinite streak.

Example:

23 of last 30 available days.

This handles intentionally configured no-study days fairly.

---

# 151. Notification Permission UX

Do not request notification permission immediately at first launch.

Ask after the user creates a study plan.

Explain value:

> Pocket Tutor can remind you about today's study and upcoming revision.

Then request permission.

---

# 152. Storage Permission UX

Use system file picker/share sheet.

Avoid broad storage permission.

Only ask when user explicitly exports/imports.

---

# 153. First Plan Generation UX

After setup:

```text
Collect inputs
↓
Validate
↓
Generate in-memory plan
↓
Show summary
↓
Persist after confirmation
```

Summary:

- Study days.
- Daily average.
- Expected syllabus completion.
- Revision buffer.
- Risk state.

---

# 154. Initial Plan Confirmation

Example:

```text
Your plan is ready

Average study:
2h 10m/day

Expected syllabus finish:
18 November

Exam:
5 December

Revision buffer:
17 days

Status:
On Track
```

Actions:

- Use This Plan.
- Adjust Availability.

---

# 155. Planner Validation Rules

Before generation:

- At least one active subject.
- At least one incomplete chapter or task.
- Exam or target end date exists.
- At least one study day available.
- Maximum session > minimum session.
- Daily limit valid.

Return actionable errors.

---

# 156. Planner Risk Levels

Suggested enum:

```text
NONE
LOW
MEDIUM
HIGH
IMPOSSIBLE
```

Used for:

- Initial plan.
- Replan.
- Progress dashboard.

---

# 157. Architecture Decision: No Backend

The app deliberately avoids a backend because core value does not require:

- Authentication.
- Server scheduling.
- Remote content.
- Social data.
- Teacher administration.

Benefits:

- Works in low-connectivity environments.
- Lower operating cost.
- Better privacy.
- Faster initial release.
- Less infrastructure maintenance.

---

# 158. Consequences of No Backend

The app must handle locally:

- Planning.
- Data persistence.
- Notifications.
- Backups.
- Reports.
- Migrations.

Cross-device sync is unavailable until optional future cloud integration is introduced.

---

# 159. Recommended MVP Release Architecture

```text
Flutter App
│
├── Riverpod
│
├── Domain Services
│   ├── Study Planner
│   ├── Revision Engine
│   ├── Progress Calculator
│   └── Forecast Calculator
│
├── Repositories
│
├── Drift / SQLite
│
├── Local Notifications
│
├── File Export / Import
│
└── Device Secure Storage
```

No server.

No API gateway.

No authentication service.

No remote database.

---

# 160. Final Technical Recommendation

Pocket Tutor should be implemented as a **local-first Flutter application with a deterministic planning engine and SQLite-based academic data model**.

The technical design should prioritize:

1. Reliable study-plan generation.
2. Safe automatic replanning.
3. Fast offline access.
4. Explainable scheduling decisions.
5. Strong preservation of study history.
6. Simple backup and restore.
7. Bengali localization.
8. Privacy by default.
9. Testable deterministic algorithms.
10. Future extensibility without introducing backend complexity too early.

The most important architectural rule is:

> **The study planner must remain a deterministic, explainable domain engine that works entirely on-device.**

Everything else in the application should support that core.
