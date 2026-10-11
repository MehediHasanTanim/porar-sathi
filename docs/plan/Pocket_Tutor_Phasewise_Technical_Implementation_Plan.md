# Pocket Tutor — Phase-Wise Technical Implementation Plan

## 1. Document Purpose

This document defines a detailed technical implementation plan for **Pocket Tutor — Offline Study Planner**.

The implementation assumes:

- Mobile-only product.
- Flutter for Android and iOS.
- Riverpod for state management.
- Drift + SQLite for local persistence.
- Local notifications.
- No backend for MVP.
- Bangla + English localization.
- Deterministic on-device study planning engine.
- Local backup and restore.
- Future optional support for cloud backup, advanced analytics, and AI.

The plan is organized into:

1. Foundation.
2. Core academic data.
3. Study planning engine.
4. Daily execution flow.
5. Revision and backlog.
6. Progress and analytics.
7. Notifications.
8. Backup, restore, privacy, and data safety.
9. Production hardening and release.
10. Phase 2 enhancements.
11. Phase 3 enhancements.

---

# 2. Recommended Delivery Model

Recommended sprint duration:

**2 weeks**

Recommended MVP timeline:

**8–10 sprints**

Recommended team shape:

- 1 Flutter developer.
- 1 QA engineer part-time or shared.
- 1 product owner/project manager.
- UI/UX support as needed.

For a solo developer, each sprint may effectively take 2–4 calendar weeks depending on availability.

---

# 3. Technical Milestones

## Milestone 1 — App Foundation

App launches, local database works, architecture is established, localization and theme infrastructure are ready.

## Milestone 2 — Academic Setup

User can create study plans, subjects, chapters, exams, and study availability.

## Milestone 3 — Planner MVP

App can generate a realistic daily study plan.

## Milestone 4 — Study Execution

User can start, complete, partially complete, skip, and quick-log study sessions.

## Milestone 5 — Adaptive Planning

App can handle missed tasks, backlog, revision, and automatic replanning.

## Milestone 6 — Progress and Readiness

User can track syllabus completion, time, subject balance, and exam readiness.

## Milestone 7 — Notifications and Backup

Reminders, export/import backup, and device-level resilience are complete.

## Milestone 8 — Production Release

Testing, migration safety, accessibility, performance, and store-readiness are complete.

---

# 4. Phase 0 — Product and Engineering Preparation

## Goal

Convert product requirements into an implementation-ready engineering backlog.

## Duration

3–5 days.

---

## 4.1 Finalize MVP Scope

Tasks:

- Review feature specification.
- Separate MVP, Phase 2, and Phase 3.
- Confirm no backend for MVP.
- Confirm local-first data model.
- Confirm Bangla + English requirement.
- Confirm initial user segments:
  - SSC.
  - HSC.
  - University.
  - Admission test.
- Confirm default study-planning behavior.
- Confirm default revision policy.
- Confirm notification scope.
- Confirm export/import requirements.

Deliverable:

`MVP_Scope.md`

Acceptance criteria:

- Every MVP feature is mapped to at least one engineering task.
- No Phase 2-only feature blocks MVP release.

---

## 4.2 Define Domain Terminology

Create shared definitions for:

- Study Plan.
- Subject.
- Chapter.
- Topic.
- Exam.
- Study Task.
- Study Session.
- Revision.
- Backlog.
- Difficulty.
- Confidence.
- Priority.
- Study Availability.
- Calendar Exception.
- Planning Buffer.
- Readiness.
- On-Track Status.

Acceptance criteria:

- Terms are consistent across UI, data model, and planner logic.

---

## 4.3 Define Technical Decisions

Document architecture decisions.

Recommended ADRs:

- ADR-001: Flutter selected.
- ADR-002: Riverpod selected.
- ADR-003: Drift + SQLite selected.
- ADR-004: No backend for MVP.
- ADR-005: Deterministic planner.
- ADR-006: Date-based scheduling before exact-time scheduling.
- ADR-007: Local notifications only.
- ADR-008: JSON-based portable backup.

Deliverable:

`docs/adr/`

---

# 5. Phase 1 — Project Foundation

## Goal

Build a production-ready Flutter application foundation.

## Suggested Sprint

Sprint 1.

---

## 5.1 Initialize Flutter Project

Tasks:

- Create Flutter project.
- Configure Android application ID.
- Configure iOS bundle ID.
- Configure app display name.
- Establish development/staging/release build flavors if desired.
- Configure minimum supported Android and iOS versions.
- Enable Material 3.
- Create base app entry point.
- Configure package naming conventions.

Deliverables:

- Android build runs.
- iOS build runs.
- Debug build works on simulator/emulator.

---

## 5.2 Establish Folder Architecture

Create:

```text
lib/
  app/
  core/
  features/
```

Feature folders:

- onboarding
- study_plans
- subjects
- syllabus
- exams
- planner
- sessions
- revision
- progress
- notifications
- backup_restore
- settings

Tasks:

- Define data/domain/application/presentation boundaries.
- Create base repository interfaces.
- Create common error types.
- Create common result wrapper if used.
- Create date/time abstraction.
- Create utility conventions.

Acceptance criteria:

- UI does not directly access Drift tables.
- Planner logic remains outside presentation layer.

---

## 5.3 Add Core Packages

Add and configure:

- flutter_riverpod
- riverpod_generator if codegen used
- drift
- sqlite3_flutter_libs
- path_provider
- path
- shared_preferences
- flutter_local_notifications
- timezone
- intl
- go_router
- freezed/json_serializable if desired
- file_picker/share_plus for future export/import
- uuid or ulid package

Tasks:

- Lock compatible versions.
- Configure code generation.
- Add build scripts.
- Verify CI-friendly generation commands.

---

## 5.4 Create Theme System

Tasks:

- Define semantic color tokens.
- Implement light theme.
- Implement dark theme.
- Implement system theme option.
- Create typography scale.
- Validate Bangla font rendering.
- Define spacing system.
- Define reusable card, button, chip, and form styles.

Acceptance criteria:

- Theme can be switched without restart.
- Bangla text renders correctly in all base components.

---

## 5.5 Localization Infrastructure

Tasks:

- Configure Flutter localization.
- Add English ARB file.
- Add Bangla ARB file.
- Add localized date and number helpers.
- Create language provider.
- Persist language selection.
- Add fallback behavior.

Initial strings:

- Navigation.
- Common buttons.
- Loading.
- Errors.
- Onboarding.
- Subjects.
- Chapters.
- Exams.
- Planner.

Acceptance criteria:

- App can switch between English and Bangla.
- No critical UI strings are hardcoded in widgets.

---

## 5.6 Navigation Foundation

Create main routes:

```text
/splash
/onboarding
/home
/today
/plan
/syllabus
/progress
/more
/settings
```

Tasks:

- Configure router.
- Configure bottom navigation shell.
- Preserve tab navigation state.
- Add route guard for first-run onboarding.

---

## 5.7 App Settings Persistence

Create settings model.

Fields:

- language
- theme
- onboardingComplete
- firstDayOfWeek
- currentStudyPlanId
- defaultSessionDuration
- planningBuffer
- autoReplanEnabled

Tasks:

- Implement settings repository.
- Persist with SharedPreferences.
- Create settings provider.

---

# 6. Phase 2 — Local Database and Core Domain

## Goal

Implement safe local persistence and all foundational domain objects.

## Suggested Sprint

Sprint 2.

---

## 6.1 Configure Drift Database

Tasks:

- Create database class.
- Enable foreign keys.
- Configure schema version.
- Configure migrations.
- Add database provider.
- Add transaction utilities.

Acceptance criteria:

- Database opens successfully.
- Schema migrations are testable.
- Database can be recreated in test environment.

---

## 6.2 Create Core Tables

Implement:

- student_profiles
- study_plans
- subjects
- chapters
- exams
- exam_syllabus_items
- weekly_availability
- calendar_exceptions
- study_tasks
- study_sessions
- revision_schedules
- planner_runs

MVP may omit topics initially.

---

## 6.3 Add Required Indexes

Indexes:

```text
subjects(study_plan_id)
chapters(subject_id)
exams(study_plan_id, start_date)
study_tasks(study_plan_id, planned_date)
study_tasks(status, planned_date)
study_tasks(subject_id, status)
study_sessions(subject_id, started_at)
revision_schedules(due_date, status)
calendar_exceptions(study_plan_id, date)
```

Acceptance criteria:

- Key planner queries use indexed columns.

---

## 6.4 Implement Domain Entities

Create immutable domain models for:

- StudyPlan
- Subject
- Chapter
- Exam
- WeeklyAvailability
- CalendarException
- StudyTask
- StudySession
- RevisionSchedule

Tasks:

- Add enums.
- Add validation helpers.
- Add mappers between Drift and domain models.

---

## 6.5 Implement Repositories

Repositories:

- StudyPlanRepository
- SubjectRepository
- ChapterRepository
- ExamRepository
- AvailabilityRepository
- StudyTaskRepository
- StudySessionRepository
- RevisionRepository

Tasks:

- CRUD methods.
- Reactive list queries where useful.
- Transaction support.
- Archive/delete behavior.

---

## 6.6 Add Clock Abstraction

Interface:

```text
Clock
  now()
  today()
```

Tasks:

- SystemClock implementation.
- FakeClock for tests.

Acceptance criteria:

- Planner logic never directly depends on `DateTime.now()`.

---

# 7. Phase 3 — Onboarding and Academic Setup

## Goal

Allow users to fully configure their study context.

## Suggested Sprint

Sprint 3.

---

## 7.1 Build Onboarding Flow

Screens:

1. Splash.
2. Language selection.
3. Welcome.
4. Study type.
5. Exam setup.
6. Study availability.
7. Plan summary.
8. Setup complete.

Tasks:

- Add skip/back behavior where appropriate.
- Persist progress.
- Prevent incomplete setup from breaking app startup.

---

## 7.2 Study Plan Creation

Fields:

- Plan name.
- Plan type.
- Start date.
- Target date.
- Daily intensity.
- Max daily minutes.
- Max session length.
- Planning buffer.
- Revision buffer.

Tasks:

- Create form.
- Validate.
- Save plan.
- Set as active plan.

---

## 7.3 Subject Management

Screens:

- Subject list.
- Add subject.
- Edit subject.
- Subject details.

Fields:

- Name.
- Code.
- Paper.
- Priority.
- Difficulty.
- Confidence.
- Color.
- Icon.

Tasks:

- Add subject.
- Edit subject.
- Archive subject.
- Delete with confirmation.

---

## 7.4 Chapter Management

Screens:

- Chapter list.
- Add chapter.
- Edit chapter.
- Bulk add chapters.

Fields:

- Title.
- Number.
- Estimated duration.
- Difficulty.
- Confidence.
- Priority.
- Exam importance.
- Notes.

Tasks:

- Manual creation.
- Bulk multiline import.
- Sort chapters.
- Edit estimated time.
- Status management.

---

## 7.5 Exam Management

Screens:

- Exam list.
- Add exam.
- Edit exam.
- Exam details.

Fields:

- Name.
- Type.
- Date.
- Optional end date.
- Importance.
- Notes.

Tasks:

- Link subjects/chapters to exam.
- Show countdown.
- Validate exam date.

---

## 7.6 Weekly Availability

UI:

- Saturday–Friday rows.
- Enable/disable day.
- Set available minutes.
- Optional preferred time range.

Tasks:

- Save weekly pattern.
- Validate duration.
- Support no-study days.

---

## 7.7 Calendar Exceptions

Allow:

- No-study day.
- Reduced availability.
- Extra study day.

Fields:

- Date.
- Reason.
- Available minutes override.

Acceptance criteria:

- Planner capacity reflects exceptions.

---

# 8. Phase 4 — Planner Engine MVP

## Goal

Generate a usable and explainable daily study plan.

## Suggested Sprint

Sprint 4.

This is the most important engineering phase.

---

## 8.1 Create Planner Input Model

Include:

- Current date.
- Active study plan.
- Subjects.
- Incomplete chapters.
- Exams.
- Weekly availability.
- Exceptions.
- Existing locked tasks.
- Planning config.

Tasks:

- Create `PlanningInput`.
- Add validation.
- Add deterministic ordering.

---

## 8.2 Implement Capacity Calculator

For each day:

```text
available minutes
- planning buffer
- locked tasks
= usable capacity
```

Tasks:

- Generate date range.
- Apply weekly availability.
- Apply exceptions.
- Clamp invalid values.
- Exclude days after relevant exams.

Tests:

- Normal day.
- No-study day.
- Extra-study day.
- Full locked day.
- Planning buffer.

---

## 8.3 Implement Remaining Work Calculator

Tasks:

- Calculate remaining chapter minutes.
- Handle partial completion.
- Ignore completed/skipped items as configured.
- Estimate work before each exam.

Acceptance criteria:

- No negative remaining duration.

---

## 8.4 Implement Priority Scoring

Components:

- Exam urgency.
- Difficulty.
- Confidence.
- Subject priority.
- Chapter priority.
- Exam importance.
- Backlog.
- Neglect.

Tasks:

- Create score components.
- Keep weights configurable.
- Add unit tests for every score dimension.
- Add human-readable score explanation.

Example:

```text
Physics Chapter 4 = 78
Exam urgency +22
Low confidence +12
Difficulty +8
High priority +10
...
```

---

## 8.5 Implement Session Splitter

Rules:

- Maximum session duration.
- Minimum useful session duration.
- Merge small remainder.

Example:

```text
180 min -> 50 + 50 + 50 + 30
```

Tests:

- Exactly one session.
- Small remainder.
- Very large chapter.

---

## 8.6 Implement Task Allocation

Tasks:

- Sort work items by score.
- Find eligible date.
- Check capacity.
- Reduce capacity after assignment.
- Respect exam deadline.
- Avoid overloading same subject.

Initial algorithm should be simple and deterministic.

---

## 8.7 Subject Balance Rules

Implement:

- Daily max share per subject.
- Avoid repeated same-subject sessions when alternatives exist.
- Respect high urgency override.

Tests:

- One subject only.
- Two balanced subjects.
- One high-priority subject.
- Exam crunch scenario.

---

## 8.8 Detect Impossible Plans

Calculate:

```text
required minutes
vs
available minutes
```

Return:

- shortfall
- risk
- suggested actions

Acceptance criteria:

- Planner never silently drops required work.

---

## 8.9 Finish-Date Forecast

Calculate:

- Expected completion date.
- Days before exam.
- Revision buffer.

Add status:

- Ahead.
- On Track.
- Slightly Behind.
- Behind.
- At Risk.

---

## 8.10 Persist Planner Run

Use transaction:

1. Create planner_run.
2. Save generated tasks.
3. Assign generation batch ID.
4. Commit.

Acceptance criteria:

- Failure preserves previous valid plan.

---

## 8.11 Planner Preview Screen

Show:

- Average daily study.
- Expected finish date.
- Exam date.
- Revision buffer.
- Risk.
- Tasks generated.

Actions:

- Use Plan.
- Adjust Availability.

---

# 9. Phase 5 — Today Screen and Study Execution

## Goal

Make Pocket Tutor useful every day.

## Suggested Sprint

Sprint 5.

---

## 9.1 Today Dashboard

Show:

- Greeting.
- Exam countdown.
- Today's total planned duration.
- Today's tasks.
- Syllabus completion.
- Backlog.
- Revision due.
- On-track status.

Tasks:

- Build aggregator use case.
- Optimize database queries.
- Add empty state.

---

## 9.2 Study Task Card

Display:

- Subject.
- Chapter.
- Duration.
- Priority.
- Type.
- Status.

Actions:

- Start.
- Complete.
- Partial.
- Skip.
- Move.

---

## 9.3 Study Session Timer

Implement state:

- Idle.
- Running.
- Paused.
- Completed.

Tasks:

- Start timestamp.
- Pause.
- Resume.
- End.
- Persist active state.
- Recover after app process death.

---

## 9.4 Manual Completion

Allow without timer.

Fields:

- Completion percentage.
- Actual minutes.
- Confidence after study.
- Need revision.
- Optional note.

---

## 9.5 Partial Completion

Tasks:

- Save session.
- Update task status.
- Calculate remaining work.
- Preserve original task history.
- Make remaining work eligible for replan.

---

## 9.6 Quick Study

Flow:

1. Select subject.
2. Select chapter.
3. Enter duration.
4. Optionally start timer.
5. Save session.
6. Update progress.
7. Schedule revision.

---

## 9.7 Task Completion Transaction

Transaction should:

- Insert StudySession.
- Update StudyTask.
- Update Chapter progress.
- Update confidence if changed.
- Generate revision requirements.
- Commit atomically.

---

# 10. Phase 6 — Revision, Missed Tasks, and Backlog

## Goal

Make planning adaptive rather than static.

## Suggested Sprint

Sprint 6.

---

## 10.1 Revision Engine

Default policy:

- Revision 1: +2 days.
- Revision 2: +7 days.
- Revision 3: before exam.

Tasks:

- Create revision schedule after completed study.
- Prevent duplicate revisions.
- Respect exam date.
- Adjust duration based on confidence.

---

## 10.2 Revision Queue

Screen:

- Due today.
- Overdue.
- Upcoming.

Actions:

- Start.
- Complete.
- Skip.
- Reschedule.

---

## 10.3 Missed Task Detection

At date rollover:

- Find incomplete tasks from previous dates.
- Mark MISSED where applicable.
- Compute remaining work.
- Add to backlog.

Tasks:

- Implement idempotent daily rollover service.

---

## 10.4 Backlog Dashboard

Show:

- Overdue task count.
- Remaining backlog minutes.
- Subjects affected.
- Oldest backlog item.
- Recovery estimate.

---

## 10.5 Catch-Up Plan Generator

Input:

- Backlog.
- Future spare capacity.
- Exam dates.

Output:

- Additional minutes by day.
- Recommended recovery days.
- Risk level.

---

## 10.6 Automatic Replanning

Preserve:

- Completed tasks.
- In-progress tasks.
- Locked tasks.
- Manual protected tasks.

Recalculate:

- Future auto-generated incomplete tasks.
- Missed remainder.
- Pending revisions.

---

## 10.7 Replan Diff

Generate:

- Tasks moved.
- Tasks removed.
- Tasks added.
- Finish date change.
- Risk change.

Show preview for major changes.

---

# 11. Phase 7 — Progress, Analytics, and Readiness

## Goal

Help students understand progress and risk.

## Suggested Sprint

Sprint 7.

---

## 11.1 Syllabus Progress Calculator

Implement weighted progress.

Chapter:

```text
completed / estimated
```

Subject:

Weighted by chapter workload.

Overall:

Weighted by subject workload.

Tests:

- Zero progress.
- Partial.
- Completed.
- Mixed chapter sizes.

---

## 11.2 Progress Dashboard

Cards:

- Overall syllabus.
- Study time.
- Task completion.
- Revision completion.
- Consistency.
- Subject balance.
- Backlog.
- Exam readiness.

---

## 11.3 Subject Progress Screen

Show:

- Completion percentage.
- Chapters completed.
- Confidence.
- Study time.
- Pending tasks.
- Revision due.

---

## 11.4 Daily Summary

Calculate:

- Planned minutes.
- Actual minutes.
- Completed tasks.
- Partial tasks.
- Missed tasks.
- Most studied subject.

---

## 11.5 Weekly Summary

Metrics:

- Target vs actual.
- Task completion.
- Syllabus delta.
- Revision count.
- Most improved subject.
- Neglected subject.

---

## 11.6 Study Consistency

Recommended:

```text
studied available days / total available days
```

Tasks:

- Avoid penalizing configured no-study days.
- Show rolling 7/30-day metrics.

---

## 11.7 Readiness Score

Implement informational readiness.

Inputs:

- Syllabus completion.
- Confidence.
- Revision completion.
- Backlog health.
- Consistency.

Tasks:

- Add explanation.
- Avoid exam-score prediction language.

---

## 11.8 On-Track Classification

Statuses:

- Ahead.
- On Track.
- Slightly Behind.
- Behind.
- At Risk.

Provide reason.

Example:

```text
At Risk because:
- 8h remaining
- 5h capacity before exam
```

---

# 12. Phase 8 — Notifications and Reminders

## Goal

Provide useful reminders without requiring backend services.

## Suggested Sprint

Sprint 8.

---

## 12.1 Notification Permission Flow

Tasks:

- Explain notification benefits.
- Request permission after plan setup.
- Handle denied permission gracefully.
- Add settings shortcut if needed.

---

## 12.2 Daily Plan Reminder

Configurable time.

Message example:

```text
আজ ৩টি পড়ার কাজ আছে — মোট ২ ঘণ্টা ২০ মিনিট।
```

Tasks:

- Schedule next reminders.
- Reconcile after plan changes.

---

## 12.3 Revision Reminder

Schedule when revision becomes due.

Tasks:

- Cancel when completed.
- Update when rescheduled.

---

## 12.4 Exam Countdown Notifications

Thresholds:

- 30 days.
- 14 days.
- 7 days.
- 3 days.
- 1 day.

Configurable.

---

## 12.5 Missed Task Reminder

Optional reminder for incomplete current-day task.

Avoid excessive repeated notifications.

---

## 12.6 Evening Review Reminder

Optional:

- Today's completion.
- Remaining task count.
- Quick link to review.

---

## 12.7 Notification Reconciliation Service

Trigger after:

- Replan.
- Task completion.
- Exam edit.
- Revision completion.
- Settings update.

---

# 13. Phase 9 — Backup, Restore, and Data Safety

## Goal

Protect user data without a backend.

## Suggested Sprint

Sprint 9.

---

## 13.1 Backup Data Model

Create:

```text
BackupManifest
BackupPayload
```

Manifest:

- schema version.
- app version.
- created date.
- locale.
- checksum.

---

## 13.2 Export Backup

Tasks:

- Read all user-owned tables.
- Serialize to JSON.
- Compress.
- Save using system file picker/share sheet.
- Use extension such as `.pockettutor`.

---

## 13.3 Import Validation

Validate:

- File type.
- Schema version.
- Required sections.
- Relationships.
- Integrity.

Never modify current database during validation.

---

## 13.4 Restore Flow

Steps:

1. Select backup.
2. Validate.
3. Show backup summary.
4. Confirm restore.
5. Import in transaction/temp DB.
6. Run integrity checks.
7. Replace current data.
8. Rebuild notifications.
9. Recalculate progress.

---

## 13.5 Backup Encryption

Recommended before production release if feasible.

Tasks:

- Add AES-256-GCM.
- Add password-based key derivation.
- Add salt.
- Add nonce.
- Add authentication validation.

If deferred:

Clearly label backup file as containing study data.

---

## 13.6 Data Reset

Options:

- Reset progress.
- Delete study plan.
- Delete subject.
- Delete all data.

Tasks:

- Add confirmation.
- Explain data impact.

---

# 14. Phase 10 — Settings, Accessibility, and UX Hardening

## Goal

Complete the app shell and improve usability.

---

## 14.1 General Settings

Add:

- Language.
- Theme.
- First day of week.
- Default session length.
- Planning buffer.
- Max daily workload.
- Revision policy.
- Auto-replan.

---

## 14.2 Accessibility

Tasks:

- Test large text.
- Add semantic labels.
- Verify contrast.
- Ensure icons have labels.
- Avoid color-only status indicators.
- Test Bangla with large text.
- Support reduced motion where practical.

---

## 14.3 Common UI States

Implement reusable states:

- Loading.
- Empty.
- No search results.
- Save in progress.
- Save success.
- Save failed.
- Delete confirmation.
- Unsaved changes.
- Planner failure.
- Impossible schedule.
- Notification denied.
- Backup failed.
- Restore failed.
- Migration state.

---

## 14.4 Search and Filter

MVP:

- Subject search.
- Chapter search.
- Status filters.
- Difficulty filters.
- Confidence filters.

Advanced:

- FTS5.

---

# 15. Phase 11 — Testing and Production Hardening

## Goal

Prepare a reliable release.

## Suggested Sprint

Sprint 10.

---

## 15.1 Unit Test Coverage

Focus on:

- Planner.
- Revision.
- Progress.
- Forecast.
- Capacity.
- Date handling.

Recommended priority:

**High coverage for domain logic.**

---

## 15.2 Planner Test Matrix

Required tests:

1. Single subject.
2. Multiple subjects.
3. Single exam.
4. Multiple exams.
5. No capacity.
6. Exact capacity.
7. Insufficient capacity.
8. Missed tasks.
9. Partial tasks.
10. Locked tasks.
11. Calendar exception.
12. Very difficult chapter.
13. Low confidence chapter.
14. High-priority subject.
15. Subject balance.
16. Revision due.
17. Exam tomorrow.
18. Exam 60 days away.
19. Planning buffer.
20. Replan determinism.

---

## 15.3 Database Tests

Test:

- CRUD.
- Transactions.
- Foreign keys.
- Cascade behavior.
- Archive.
- Migration.
- Query correctness.

---

## 15.4 Backup/Restore Tests

Test:

- Full round trip.
- Corrupt file.
- Wrong password.
- Missing table.
- Old schema.
- Invalid future schema.
- Restore rollback.

---

## 15.5 Notification Tests

Test:

- Permission granted.
- Permission denied.
- Replan.
- Completed revision.
- Changed exam date.
- Timezone change.

---

## 15.6 Timer Tests

Test:

- Pause/resume.
- Process death.
- Midnight crossing.
- Long-running accidental timer.
- Manual correction.

---

## 15.7 Localization QA

Verify:

- All screens in Bangla.
- All screens in English.
- Mixed-language subject names.
- Date formatting.
- Long translations.
- Overflow.

---

## 15.8 Accessibility QA

Verify:

- TalkBack.
- VoiceOver.
- Large text.
- High contrast.
- Screen orientation if supported.

---

## 15.9 Performance

Measure:

- App launch.
- Today screen load.
- Planner generation.
- Replan.
- Weekly dashboard.
- Backup creation.

Targets:

- Today screen feels near-instant.
- Typical planner generation < 1 second.
- Large planner generation remains acceptable.

---

# 16. Phase 12 — Release Preparation

## Goal

Prepare Android and iOS production releases.

---

## 16.1 Application Identity

Tasks:

- Final app name.
- Package ID.
- Bundle ID.
- Versioning.
- Build numbers.

---

## 16.2 Store Assets

Prepare:

- App icon.
- Adaptive Android icon.
- iOS icon set.
- Splash screen.
- Screenshots.
- Feature graphic.
- App description.
- Privacy policy.

---

## 16.3 Privacy Declaration

Document:

- No account required.
- Local data storage.
- No backend.
- Optional export.
- Optional notification permission.
- No sale of student data.

---

## 16.4 Android Release

Tasks:

- Configure release keystore.
- Configure signing.
- Generate AAB.
- Test release build.
- Verify notification behavior.
- Verify backup import/export.
- Internal testing track.
- Closed testing if required.

---

## 16.5 iOS Release

Tasks:

- Configure signing.
- Provisioning.
- App Store Connect metadata.
- TestFlight.
- Verify local notification behavior.
- Verify Files integration.

---

# 17. MVP Sprint Breakdown

Recommended 10-sprint structure.

---

## Sprint 1 — Foundation

Deliverables:

- Flutter project.
- Architecture.
- Riverpod.
- Navigation.
- Theme.
- Localization.
- Settings.

Exit criteria:

App shell works in Bangla and English.

---

## Sprint 2 — Database and Domain

Deliverables:

- Drift.
- Tables.
- Repositories.
- Domain entities.
- Database tests.

Exit criteria:

Core data is safely persisted.

---

## Sprint 3 — Academic Setup

Deliverables:

- Onboarding.
- Study plan.
- Subjects.
- Chapters.
- Exams.
- Availability.

Exit criteria:

Student can configure enough information to generate a plan.

---

## Sprint 4 — Planning Engine

Deliverables:

- Capacity.
- Priority scoring.
- Session splitting.
- Allocation.
- Risk detection.
- Finish forecast.
- Planner preview.

Exit criteria:

Valid daily study plan can be generated entirely offline.

---

## Sprint 5 — Study Execution

Deliverables:

- Today dashboard.
- Study tasks.
- Timer.
- Completion.
- Partial completion.
- Quick Study.

Exit criteria:

Student can execute and log daily study.

---

## Sprint 6 — Adaptive Planning

Deliverables:

- Revision.
- Missed tasks.
- Backlog.
- Catch-up.
- Replanning.
- Replan preview.

Exit criteria:

Plan survives real-life missed study days.

---

## Sprint 7 — Progress

Deliverables:

- Syllabus progress.
- Subject progress.
- Daily/weekly summary.
- Consistency.
- Readiness.
- On-track status.

Exit criteria:

Student understands progress and risk.

---

## Sprint 8 — Notifications

Deliverables:

- Study reminder.
- Revision reminder.
- Exam countdown.
- Evening summary.
- Notification settings.

Exit criteria:

All reminders work without server dependency.

---

## Sprint 9 — Backup and Settings

Deliverables:

- Backup export.
- Import.
- Restore.
- Data reset.
- Accessibility improvements.
- Search/filter.

Exit criteria:

User can protect and restore data.

---

## Sprint 10 — Hardening and Release

Deliverables:

- Planner test suite.
- Migration tests.
- Performance tuning.
- Localization QA.
- Accessibility QA.
- Release builds.

Exit criteria:

Release candidate is production-ready.

---

# 18. Phase 2 Implementation Plan

Phase 2 begins after stable MVP release.

---

## 18.1 Topic-Level Planning

Tasks:

- Add topics table.
- Add topic CRUD.
- Migrate chapter-only data.
- Planner fallback:
  - use topics when available.
  - use chapter otherwise.
- Topic progress.
- Topic confidence.

---

## 18.2 Advanced Study Calendar

Tasks:

- Monthly calendar.
- Day details.
- Exam indicators.
- Revision indicators.
- Missed-day indicators.
- Tap date to view tasks.

---

## 18.3 What-If Simulator

Scenarios:

- +30 minutes/day.
- Change exam date.
- Increase intensity.
- Change revision buffer.

Tasks:

- Run planner in memory.
- Compare outputs.
- Show finish-date change.
- Apply selected scenario.

---

## 18.4 Advanced Analytics

Add:

- Monthly summary.
- Study time trend.
- Subject allocation.
- Estimate accuracy.
- Productive time-of-day.

---

## 18.5 Estimation Learning

Tasks:

- Track actual/estimated ratio.
- Calculate bias per subject.
- Suggest estimate adjustment.
- Never silently rewrite estimates initially.

---

## 18.6 Academic Templates

Local templates:

- SSC Science.
- HSC Science.
- HSC Business Studies.
- HSC Humanities.

Tasks:

- Seed subject names.
- Optional sample chapter structure.
- Allow full edit.

---

## 18.7 Reports

Generate:

- Study plan PDF.
- Progress PDF.
- CSV history.
- CSV syllabus.

All offline.

---

# 19. Phase 3 Implementation Plan

---

## 19.1 Multiple Concurrent Study Plans

Tasks:

- Plan switcher.
- Separate dashboards.
- Cross-plan notification reconciliation.
- Per-plan settings.
- Archive old plans.

---

## 19.2 Assignment and Coursework

Tasks:

- Assignment model.
- Deadlines.
- Estimated work.
- Priority.
- Planner integration.
- University mode.

---

## 19.3 Fixed Events

Add:

- Class.
- Coaching.
- Lab.
- Tuition.

Tasks:

- Consume capacity.
- Calendar display.
- Repeat schedules.

---

## 19.4 Cloud Backup

Provider abstraction:

```text
CloudBackupProvider
```

Implement optionally:

- Google Drive.
- OneDrive.
- Dropbox.

Tasks:

- Authenticate.
- Upload.
- Download.
- List backups.
- Delete.
- Keep manual user-controlled flow.

---

## 19.5 Home Screen Widgets

Android/iOS widgets:

- Today's Study.
- Exam Countdown.
- Syllabus Progress.

Tasks:

- Create platform-specific widget integration.
- Sync local snapshot data.

---

## 19.6 Advanced Exam Crunch Mode

Tasks:

- Dynamic parameter tuning.
- Exam-linked filtering.
- Priority boost.
- More aggressive revision.
- Optional low-priority content deferment.
- Strong shortfall warnings.

---

## 19.7 Optional AI Features

Do not make AI part of planner core.

Potential features:

- Convert pasted syllabus text into chapters.
- Suggest chapter estimates.
- Explain study trends.
- Suggest study strategy.

Tasks:

- Separate AI service abstraction.
- Explicit opt-in.
- Preview data before transmission.
- Keep deterministic planner authoritative.

---

# 20. Cross-Cutting Engineering Tasks

These tasks should run across all phases.

---

## 20.1 Code Quality

- Linting.
- Formatting.
- Static analysis.
- Pull request checklist.
- No business logic in widgets.
- No database access from UI.

---

## 20.2 Error Handling

Create typed errors.

Map technical errors to user-friendly messages.

Do not show raw SQLite/plugin errors to users.

---

## 20.3 Logging

Log:

- Planner runs.
- Migration result.
- Notification errors.
- Backup errors.

Do not log:

- Personal notes.
- Backup passwords.
- Encryption keys.

---

## 20.4 Migration Discipline

For every database change:

- Increase schema version.
- Add migration test.
- Validate old data.
- Avoid destructive migration.

---

## 20.5 Dependency Management

- Keep packages minimal.
- Review abandoned plugins.
- Lock versions before releases.
- Avoid plugin overlap.

---

# 21. Recommended Engineering Backlog Priority

## P0 — Release Blocking

- Database.
- Subjects.
- Chapters.
- Exams.
- Availability.
- Planning engine.
- Today screen.
- Completion.
- Replanning.
- Revision.
- Progress.
- Notifications.
- Backup.
- Migration safety.

## P1 — Important

- Backlog recovery.
- Weekly summary.
- Readiness.
- Search.
- Accessibility.
- Improved analytics.

## P2 — Post-MVP

- Topics.
- What-if.
- Reports.
- Templates.
- Estimation learning.
- Widgets.

## P3 — Advanced

- Cloud.
- Sync.
- AI.
- Cross-device workflows.

---

# 22. Definition of Done

A feature is done only when:

- Business logic implemented.
- UI implemented.
- English strings added.
- Bangla strings added.
- Validation implemented.
- Error state implemented.
- Empty state implemented.
- Unit tests added for domain logic.
- Database tests added where relevant.
- Accessibility labels added.
- Dark mode checked.
- No critical analyzer errors.
- Product acceptance criteria passed.

---

# 23. MVP Release Acceptance Criteria

Pocket Tutor MVP is ready when a student can:

1. Install and use the app without an account.
2. Select Bangla or English.
3. Create a study plan.
4. Add subjects.
5. Add chapters.
6. Add an exam date.
7. Configure weekly study availability.
8. Generate an offline study plan.
9. See exactly what to study today.
10. Start or manually complete a study task.
11. Partially complete a task.
12. Log unscheduled Quick Study.
13. Miss a study task without breaking the schedule.
14. Receive an updated future plan.
15. See backlog.
16. Receive scheduled revision.
17. Track syllabus completion.
18. See exam countdown.
19. See on-track/risk status.
20. Receive local notifications.
21. Export a local backup.
22. Restore from backup.
23. Use all core functionality without internet.

---

# 24. Technical Success Criteria

The technical implementation should satisfy:

- No backend dependency for MVP.
- Planner is deterministic.
- Planner is unit-testable.
- Database migrations preserve data.
- Study history is not lost during replanning.
- Manual/locked tasks are protected.
- Typical plan generation completes quickly.
- Notifications are replaceable and cancellable.
- Backup restore is transactional.
- App remains useful after device connectivity is lost.
- Bangla and English both remain first-class UI languages.

---

# 25. Final Delivery Strategy

The recommended build order is:

```text
Foundation
↓
Local Data
↓
Academic Setup
↓
Planning Engine
↓
Daily Execution
↓
Revision + Replanning
↓
Progress
↓
Notifications
↓
Backup
↓
Hardening
↓
Release
```

Do **not** start with advanced charts, AI, cloud backup, or complex timetable logic.

The product succeeds only if the following loop is excellent:

```text
Enter syllabus
↓
Generate plan
↓
Study today
↓
Record result
↓
Replan safely
↓
Track progress
↓
Repeat until exam
```

The most important engineering priority should remain:

> **Build a reliable, explainable, offline study-planning engine first, and let every later feature support that execution loop.**
