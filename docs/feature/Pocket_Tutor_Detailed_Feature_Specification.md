# Pocket Tutor — Detailed Feature Specification

## 1. Product Overview

### 1.1 Product Name

**Pocket Tutor**

### 1.2 Product Category

Offline-first mobile study planning, syllabus tracking, revision, and exam-preparation application.

### 1.3 Target Market

Primary target users:

- SSC students.
- HSC students.
- University students.
- Admission-test candidates.
- Polytechnic and diploma students.
- Coaching students.
- Self-study learners following a structured syllabus.

Primary geography:

- Bangladesh.

Primary language support:

- বাংলা.
- English.

### 1.4 Core Product Idea

Pocket Tutor is not a learning-content application.

It does not attempt to replace:

- Teachers.
- Coaching centers.
- Textbooks.
- Lecture videos.
- Notes.
- Online courses.

Instead, Pocket Tutor works as a **study execution system**.

A student tells the application:

- What subjects they have.
- What chapters/topics they need to complete.
- Which topics are difficult.
- Their confidence level.
- Their exam dates.
- How many hours they can study.
- Which days and times they are available.

Pocket Tutor converts this information into an actionable daily study plan.

Example:

> আজকের পড়া  
>
> Physics — Chapter 4 — 45 min  
> Chemistry — Organic Chemistry — 60 min  
> Mathematics — Exercise 7.2 — 40 min

The student then records actual progress.

Pocket Tutor continuously answers questions such as:

- What should I study today?
- Am I behind schedule?
- Which chapters need more attention?
- Can I finish the syllabus before the exam?
- What should I revise next?
- How much of my syllabus is complete?
- Which subjects am I neglecting?

---

# 2. Product Goals

Pocket Tutor should help students:

1. Turn a large syllabus into small daily study tasks.
2. Reduce the mental effort required to decide what to study.
3. Finish the syllabus before examinations.
4. Allocate more study time to difficult and weak topics.
5. Track actual progress against planned progress.
6. Build a consistent study habit.
7. Identify syllabus backlog early.
8. Schedule revision before exams.
9. Recover automatically when students miss study sessions.
10. Use the application completely offline.

---

# 3. Product Principles

## 3.1 Offline First

All core functions must work without internet access.

Store all application data locally on the device.

No user account should be required for the MVP.

## 3.2 Execution Over Content

Pocket Tutor should focus on:

- Planning.
- Scheduling.
- Tracking.
- Revision.
- Discipline.
- Progress visibility.

It should not become another:

- Video learning platform.
- Question bank.
- Course marketplace.
- Notes repository.

## 3.3 Simple Enough for Daily Use

Creating or completing a study task should require very few taps.

The student should normally be able to answer:

> “What should I study now?”

within a few seconds of opening the application.

## 3.4 Flexible Planning

Real students do not follow perfect schedules.

Pocket Tutor must support:

- Missed sessions.
- Unexpected holidays.
- Sick days.
- Coaching classes.
- School exams.
- Changed exam dates.
- Increased/decreased study availability.

The schedule should adapt automatically.

---

# 4. User Profiles

## 4.1 SSC Student

Example:

- 8–12 subjects.
- Board examination target.
- School + coaching schedule.
- Needs chapter-level tracking.
- Mostly follows textbooks.

## 4.2 HSC Student

Example:

- Science/Commerce/Humanities.
- Large syllabus.
- Multiple papers.
- Board exam plus admission preparation.

Needs stronger revision and backlog management.

## 4.3 University Student

Example:

- Semester-based study.
- Courses rather than school subjects.
- Midterm, quiz, assignment, lab, and final exams.

Needs deadline-based planning.

## 4.4 Admission-Test Candidate

Examples:

- Medical admission.
- Engineering admission.
- University admission.
- BCS/preliminary-style preparation in later versions.

Needs intense short-term planning and revision cycles.

---

# 5. App Structure

Recommended main navigation:

1. **আজ / Today**
2. **Plan**
3. **Syllabus**
4. **Progress**
5. **More**

Optional floating action:

**+ Quick Study**

---

# 6. First Launch and Onboarding

## 6.1 Splash Screen

Show:

- Pocket Tutor logo.
- App name.
- Short tagline.

Example:

**পকেট টিউটর**

`আজ কী পড়বেন, সেটা আর ভাবতে হবে না।`

## 6.2 Language Selection

Options:

- বাংলা.
- English.

Allow language changes later.

## 6.3 Welcome Screen

Explain the core product in three short points:

- Add your subjects and syllabus.
- Tell us your available study time.
- Get a realistic daily study plan.

Primary action:

**শুরু করি**

## 6.4 Study Type Selection

Ask:

**আপনি কীসের জন্য পড়ছেন?**

Options:

- SSC.
- HSC.
- University.
- Admission Test.
- Diploma/Polytechnic.
- Other.

This should influence terminology but not restrict functionality.

## 6.5 Exam Information

Ask:

- Exam name.
- Exam date.
- Optional exam start/end date.
- Exam importance.

Examples:

- HSC Final.
- Physics Midterm.
- BUET Admission Test.

Allow multiple exams.

## 6.6 Daily Study Availability

Ask:

**সাধারণত প্রতিদিন কতক্ষণ পড়তে পারেন?**

Examples:

- 1 hour.
- 2 hours.
- 3 hours.
- 4 hours.
- Custom.

## 6.7 Weekly Availability

Allow per-day configuration.

Example:

| Day | Available Time |
|---|---:|
| Saturday | 3 hr |
| Sunday | 2 hr |
| Monday | 2 hr |
| Tuesday | 3 hr |
| Wednesday | 2 hr |
| Thursday | 2 hr |
| Friday | 5 hr |

Students can mark:

- School day.
- Coaching day.
- Busy day.
- Free day.

## 6.8 Preferred Study Sessions

Optional setup:

- Morning.
- Afternoon.
- Evening.
- Night.

Student can define multiple sessions.

Example:

6:30–7:30 AM

8:00–10:00 PM

---

# 7. Academic Structure

Pocket Tutor should support a flexible hierarchy.

Recommended:

**Study Program → Subject → Unit/Section → Chapter → Topic**

Not every student needs every level.

---

# 8. Subjects

## 8.1 Subject List

Display:

- Subject name.
- Syllabus progress.
- Upcoming exam.
- Confidence.
- Pending tasks.
- Color/icon.

Example:

**Physics**

72% completed

12 chapters remaining

Exam in 42 days

## 8.2 Add Subject

Fields:

- Subject name.
- Optional subject code.
- Paper.
- Exam.
- Priority.
- Subject color/icon.
- Estimated difficulty.

Example:

Physics 1st Paper.

## 8.3 Subject Priority

Options:

- Low.
- Normal.
- High.
- Critical.

Priority influences scheduling.

## 8.4 Subject Difficulty

Five-level scale:

1. Very Easy.
2. Easy.
3. Moderate.
4. Difficult.
5. Very Difficult.

## 8.5 Subject Confidence

Allow students to estimate confidence:

- Very Low.
- Low.
- Medium.
- High.
- Very High.

This should be updated over time.

---

# 9. Chapter and Topic Management

## 9.1 Chapter List

Each subject should contain chapters.

Example:

Physics

1. Physical World and Measurement.
2. Vector.
3. Dynamics.
4. Newtonian Mechanics.
5. Work, Energy and Power.

## 9.2 Add Chapter

Fields:

- Chapter title.
- Chapter number.
- Estimated study time.
- Difficulty.
- Confidence.
- Priority.
- Exam importance.
- Optional notes.

## 9.3 Topic Breakdown

Students may optionally divide chapters into topics.

Example:

### Chapter: Organic Chemistry

Topics:

- Hydrocarbons.
- Functional groups.
- Isomerism.
- Reaction mechanisms.

## 9.4 Estimated Study Time

Students may enter:

- 30 minutes.
- 1 hour.
- 2 hours.
- Custom.

For large chapters, Pocket Tutor should automatically split work into multiple sessions.

Example:

Estimated chapter duration:

**4 hours**

Generated:

- Session 1 — 50 min.
- Session 2 — 50 min.
- Session 3 — 50 min.
- Session 4 — 50 min.
- Review — 40 min.

---

# 10. Syllabus Setup

## 10.1 Manual Syllabus Creation

Students create:

- Subjects.
- Chapters.
- Topics.

## 10.2 Quick Chapter Creation

Allow rapid entry such as:

Chapter 1  
Chapter 2  
Chapter 3  
Chapter 4  
Chapter 5

Students can rename later.

## 10.3 Bulk Add

Allow multiline input.

Example:

```text
Vector
Dynamics
Newtonian Mechanics
Work and Energy
Gravitation
```

Automatically create separate chapters.

## 10.4 Duplicate Subject/Syllabus

Useful for:

- Similar courses.
- 1st/2nd papers.
- New semester setup.

---

# 11. Study Planning Engine

This is the most important Pocket Tutor feature.

The planner should calculate tasks based on:

- Exam date.
- Remaining syllabus.
- Available study time.
- Topic difficulty.
- Student confidence.
- Subject priority.
- Chapter importance.
- Previous missed tasks.
- Required revision.
- User's maximum session duration.

---

# 12. Daily Study Plan

## 12.1 Today's Plan

Primary home screen.

Example:

# আজকের পড়া

**Physics**

Newtonian Mechanics

45 min

Priority: High

---

**Chemistry**

Organic Chemistry

60 min

Priority: Medium

---

**Mathematics**

Exercise 7.2

40 min

Summary:

**Today's target**

2h 25m

3 study tasks

## 12.2 Start Study

Each task includes:

**Start**

Starting opens the study session screen.

## 12.3 Complete Without Timer

Students should also be able to mark:

**Completed**

without using the timer.

## 12.4 Partial Completion

Options:

- Completed.
- Partially completed.
- Not studied.
- Skip.

If partially completed:

Ask:

**How much did you complete?**

Example:

70%.

Remaining work automatically returns to future plans.

---

# 13. Automatic Scheduling

Pocket Tutor automatically generates future study tasks.

Example:

Exam: 30 days away

Remaining chapters: 18

Available study days: 24

Pocket Tutor distributes study sessions while preserving time for revision.

---

# 14. Study Planning Modes

## 14.1 Balanced

Spread workload evenly.

## 14.2 Weak-Subject Focus

Allocate additional time to:

- Low-confidence topics.
- Difficult chapters.

## 14.3 Exam-Crunch Mode

Used near exams.

Characteristics:

- Higher daily workload.
- More revision.
- Reduced low-priority work.

## 14.4 Light Plan

For students who want sustainable daily habits.

## 14.5 Custom

Student chooses weighting.

---

# 15. Study Load Control

Allow the student to select:

**How intense should today's plan be?**

Options:

- Light.
- Normal.
- Focused.
- Intensive.

Example:

Normal = 2h 30m

Intensive = 4h

---

# 16. Smart Daily Adjustment

When Pocket Tutor opens each day, reevaluate the plan.

For example:

Yesterday:

2 tasks missed.

Today should not simply add everything.

Instead:

- Reschedule urgent work.
- Reduce lower-priority tasks.
- Keep workload realistic.

---

# 17. Missed Study Tasks

When a task is missed:

Options:

- Move to tomorrow.
- Reschedule automatically.
- Skip permanently.
- Mark completed.
- Change estimated time.

---

# 18. Backlog Management

Create a dedicated backlog view.

Example:

# Backlog

5 overdue tasks

Physics — 2

Chemistry — 1

Mathematics — 2

Show:

- Number of overdue tasks.
- Total estimated recovery time.
- Suggested catch-up schedule.

---

# 19. Catch-Up Plan

Pocket Tutor should generate:

**Catch-Up Plan**

Example:

You are approximately:

**3h 20m behind schedule.**

Recommended recovery:

Saturday: +40 min

Sunday: +40 min

Tuesday: +30 min

Friday: +90 min

---

# 20. Study Timer

Optional timer.

Display:

- Subject.
- Chapter.
- Planned duration.
- Current session time.

Actions:

- Pause.
- Resume.
- Finish.
- Stop early.

---

# 21. Focus Timer

Optional Pomodoro-style mode.

Presets:

- 25/5.
- 40/10.
- 50/10.
- Custom.

Students should not be forced to use Pomodoro.

---

# 22. Study Session Result

After finishing:

Ask:

### How did this session go?

Completion:

- Fully completed.
- Mostly completed.
- Partially completed.
- Could not study.

Confidence after study:

1–5 scale.

Optional:

**Need revision?**

- Yes.
- No.

---

# 23. Confidence Tracking

Each chapter should have a confidence score.

Example:

**Chapter 4 — Newtonian Mechanics**

Confidence:

2/5

After successful study:

3/5

After revision:

4/5

Students can always override scores manually.

---

# 24. Difficulty Tracking

Students set initial difficulty.

Pocket Tutor may later suggest adjustments based on:

- Multiple incomplete sessions.
- Repeated revision.
- Low confidence.

Example:

> You needed more study time than expected for this chapter. Mark it as Difficult?

---

# 25. Syllabus Progress

Core dashboard metric:

# Syllabus Completion

**67%**

Also show:

Completed chapters: 32

In progress: 8

Not started: 14

---

# 26. Subject-Level Progress

Example:

| Subject | Progress |
|---|---:|
| Physics | 72% |
| Chemistry | 61% |
| Math | 80% |
| Biology | 54% |

---

# 27. Progress by Study Time

Show:

Planned:

22h 30m

Completed:

18h 10m

Completion:

81%

---

# 28. Exam Readiness

Calculate a simple readiness indicator using:

- Syllabus completion.
- Confidence.
- Revision completion.
- Remaining days.
- Backlog.

Example:

**Physics readiness**

76%

Status:

On Track

Avoid presenting this as a guaranteed exam-score prediction.

---

# 29. On-Track Indicator

Possible statuses:

- Ahead.
- On Track.
- Slightly Behind.
- Behind.
- At Risk.

Example:

**HSC Physics**

Slightly Behind

Recommendation:

Study an additional 25 minutes on Saturday and Friday.

---

# 30. Exam Countdown

Home screen:

**HSC Exam**

42 days remaining

Secondary:

Physics Test

8 days remaining

---

# 31. Multiple Exams

Support:

- Class test.
- Quiz.
- Midterm.
- Final.
- Board exam.
- Admission test.

A chapter may relate to multiple exams.

---

# 32. Revision Planning

Pocket Tutor should schedule revision automatically.

Example revision cycle:

Initial Study

↓

Revision 1 — 2 days later

↓

Revision 2 — 7 days later

↓

Revision 3 — before exam

Student should be able to customize this.

---

# 33. Revision Queue

Screen:

# আজকের Revision

Physics — Vector

15 min

Last studied: 6 days ago

Confidence: Low

---

# 34. Revision Priority

Prioritize:

1. Low-confidence chapters.
2. Difficult chapters.
3. Important chapters.
4. Topics not reviewed recently.
5. Topics closest to exam.

---

# 35. Quick Revision

Allow student to manually select:

**Revise Now**

Specify:

- 10 minutes.
- 20 minutes.
- 30 minutes.
- Custom.

---

# 36. Study Calendar

Monthly calendar displaying:

- Study days.
- Exams.
- Missed days.
- Completed days.
- Revision days.

Selecting a date shows the study plan.

---

# 37. Weekly Planner

Example:

## This Week

Planned:

14h 30m

Completed:

9h 20m

Remaining:

5h 10m

Subjects:

Physics — 3h

Math — 4h

Chemistry — 3h

Biology — 4h 30m

---

# 38. Manual Planning

Students can override automatic scheduling.

They can:

- Add study task.
- Move study task.
- Delete task.
- Change duration.
- Change priority.
- Lock a study task.

---

# 39. Locked Tasks

A locked task should not be moved by automatic replanning.

Example:

Friday

10:00 AM

Physics Model Test

**Locked**

---

# 40. Quick Study

The student may sometimes study something not scheduled.

Button:

**+ Quick Study**

Select:

- Subject.
- Chapter.
- Duration.

After completion, Pocket Tutor updates progress.

---

# 41. Study History

Show previous sessions.

Example:

### October 5

Physics

Newtonian Mechanics

52 min

Completed

Confidence: 3 → 4

---

# 42. Daily Summary

At the end of a study day:

# আজকের সারাংশ

Planned:

3h

Studied:

2h 35m

Tasks:

4 / 5 completed

Most studied:

Mathematics

Remaining:

Chemistry — Organic Chemistry

---

# 43. Weekly Summary

Example:

# এই সপ্তাহ

Study time:

14h 40m

Target:

16h

Tasks completed:

28/32

Syllabus progress:

52% → 61%

Most improved:

Physics

Needs attention:

Chemistry

---

# 44. Monthly Summary

Display:

- Study hours.
- Planned vs completed hours.
- Chapters completed.
- Revision sessions.
- Most studied subjects.
- Weakest subjects.
- Missed study days.
- Consistency.

---

# 45. Study Streak

Display:

**7-Day Study Streak**

But avoid making streaks psychologically punitive.

One missed day should not make the entire app feel like failure.

Possible concept:

**Consistency Days**

23 of last 30 days.

---

# 46. Daily Goal

Students define targets such as:

- 2 hours/day.
- 3 tasks/day.
- 1 chapter/day.

Pocket Tutor should recommend realistic targets.

---

# 47. Weekly Goal

Examples:

- Study 15 hours.
- Finish 5 chapters.
- Complete 10 revision sessions.

---

# 48. Subject Balance

Detect neglected subjects.

Example:

> You have studied Mathematics for 6 hours this week but Chemistry for only 45 minutes.

Suggested action:

**Add Chemistry to tomorrow's plan**

---

# 49. Study Statistics

Include:

- Today.
- This week.
- This month.
- All time.

Metrics:

- Study hours.
- Sessions.
- Completed tasks.
- Average daily time.
- Completion percentage.
- Syllabus progress.
- Revision count.

---

# 50. Focus Analytics

Optional statistics:

Average planned session:

45 min

Average actual session:

38 min

Most productive study period:

8–10 PM

---

# 51. Calendar Exceptions

Students may define:

- Holiday.
- Coaching exam.
- Family event.
- Travel.
- Sick day.

Pocket Tutor automatically redistributes study work.

---

# 52. No-Study Days

Example:

Friday afternoon unavailable.

or:

October 12 — No Study

No tasks should be scheduled there.

---

# 53. Extra Study Day

Student can mark:

**Free day**

Example:

Friday

Available study time:

6 hours

The planner may move backlog or difficult subjects there.

---

# 54. Study Hours Adjustment

Allow one-time override.

Example:

> Normally Tuesday: 2h

This Tuesday:

30 minutes only.

---

# 55. Priority Chapters

Mark chapter as:

- Low.
- Normal.
- High.
- Must Finish.

---

# 56. Important Exam Topics

Students can flag topics such as:

**Important for exam**

The scheduler gives them additional review priority.

---

# 57. Chapter Status

Possible states:

- Not Started.
- Planned.
- In Progress.
- Completed.
- Revision Due.
- Revised.
- Skipped.

---

# 58. Notes

Allow short chapter notes such as:

- Need teacher explanation.
- Formula needs revision.
- Important CQ.
- Weak in derivation.

Pocket Tutor should not attempt to become a full note-taking application.

---

# 59. Bookmarks / Attention List

Students can bookmark topics requiring additional attention.

Possible label:

**Need Attention**

Example:

Physics

Vectors

Reason:

Low confidence.

---

# 60. Study Search

Search:

- Subjects.
- Chapters.
- Topics.
- Tasks.
- Notes.

---

# 61. Filters

Examples:

Filter by:

- Subject.
- Completion status.
- Difficulty.
- Confidence.
- Priority.
- Exam.
- Revision due.

---

# 62. Smart Suggestions

Local rule-based suggestions.

Examples:

> Mathematics hasn't been studied for 4 days.

> Your Chemistry exam is in 12 days but 38% of the syllabus is incomplete.

> You have 5 low-confidence Physics chapters.

> Friday has two free study hours. Consider moving backlog there.

No cloud AI is required.

---

# 63. Risk Alerts

Provide useful warnings without unnecessary anxiety.

Examples:

### Syllabus Risk

At the current pace, you may not finish Chemistry before the exam.

Options:

- Increase daily study time.
- Reduce revision buffer.
- Reprioritize chapters.
- Adjust exam date.

---

# 64. Finish-Date Forecast

Estimate:

**Expected syllabus completion**

November 18

Exam:

December 5

Revision buffer:

17 days

---

# 65. What-If Planning

Student can test scenarios.

Example:

> What happens if I study 30 minutes more each day?

Result:

Current expected completion:

November 28

With +30 min/day:

November 18

---

# 66. Exam-Crunch Mode

Student can activate manually or Pocket Tutor may suggest it.

Useful during the final:

- 7 days.
- 14 days.
- 30 days.

Changes:

- Reduce low-priority tasks.
- Increase revision.
- Show countdown more prominently.
- Emphasize low-confidence content.

---

# 67. Last 7 Days Plan

Example:

### 7-Day Revision Plan

Day 1

Physics — Mechanics

Chemistry — Organic

Day 2

Math — Algebra

Biology — Genetics

etc.

---

# 68. Exam-Day Mode

On examination date:

Show:

- Exam subject.
- Exam time.
- Quick revision tasks.
- Completed preparation status.

Avoid scheduling heavy new study immediately before the exam unless requested.

---

# 69. Notifications

Local device notifications only.

Examples:

**আজ ৩টি পড়ার কাজ আছে।**

**Physics revision is due today.**

**Your Chemistry exam is 7 days away.**

---

# 70. Study Reminder

Student configures:

- Morning reminder.
- Study-session reminder.
- Evening review reminder.

---

# 71. Missed Plan Reminder

Example:

> Today's Mathematics task is still incomplete.

Allow notification to be disabled.

---

# 72. Exam Countdown Notification

Configurable notifications:

- 30 days.
- 14 days.
- 7 days.
- 3 days.
- 1 day.

---

# 73. Revision Reminder

Example:

> You studied Vector 7 days ago. A short revision is due.

---

# 74. Motivation Messages

Keep these simple and non-patronizing.

Examples:

> আজকের ছোট অগ্রগতিও পরীক্ষার প্রস্তুতির অংশ।

> দুই ঘণ্টা বাকি নেই—পরের ৩০ মিনিট থেকেই শুরু করুন।

Allow disabling motivational messages.

---

# 75. Home Dashboard

Recommended layout:

## Greeting

Good evening.

## Exam Countdown

HSC Final

42 days

## Today

3 tasks

2h 25m

## Progress

Syllabus completed

67%

## Study Status

On Track

## Quick Actions

- Start Study.
- Quick Study.
- Add Task.
- View Backlog.

---

# 76. Syllabus Dashboard

Show:

Overall:

67%

Subject progress.

Chapters:

Completed: 38

In Progress: 5

Remaining: 14

Revision due: 8

---

# 77. Progress Dashboard

Cards:

- Study Time.
- Task Completion.
- Syllabus Completion.
- Study Consistency.
- Revision Progress.
- Subject Balance.

---

# 78. Planner Screen

Tabs:

- Day.
- Week.
- Calendar.

Allow drag/reorder only where practical for mobile UX.

---

# 79. Upcoming Screen

Show next:

- 7 days.
- 14 days.
- 30 days.

Includes:

- Study tasks.
- Revision tasks.
- Exams.

---

# 80. Backlog Dashboard

Display:

5 overdue tasks.

3h 20m required.

Possible recovery:

3 days.

Button:

**Build Catch-Up Plan**

---

# 81. Multiple Study Plans

Allow separate plans.

Example:

- HSC Final.
- Medical Admission.
- University Semester.

Students may switch between plans.

Advanced feature.

---

# 82. Academic Templates

Future optional local templates:

- SSC Science.
- HSC Science.
- HSC Business Studies.
- HSC Humanities.

Templates can pre-create subject names while still requiring students to configure chapters.

No network needed.

---

# 83. English/Bangla Terminology

Examples:

Study Plan

`পড়ার পরিকল্পনা`

Today's Study

`আজকের পড়া`

Syllabus Progress

`সিলেবাস অগ্রগতি`

Backlog

`বাকি পড়া`

Revision

`পুনরাবৃত্তি`

Confidence

`আত্মবিশ্বাস`

Difficulty

`কঠিনতার মাত্রা`

---

# 84. Dark Mode

Support:

- Light.
- Dark.
- System Default.

---

# 85. Accessibility

Support:

- Large font.
- Dynamic text.
- High contrast.
- Reduced animations.
- Screen-reader-friendly labels.

---

# 86. Offline Data Storage

Store locally:

- User preferences.
- Academic profile.
- Subjects.
- Chapters.
- Topics.
- Exams.
- Study plans.
- Study tasks.
- Study sessions.
- Study history.
- Progress.
- Revision schedules.
- Notifications.
- Settings.

---

# 87. Backup

Although no backend is required, provide local backups.

Options:

- Export backup.
- Import backup.

Recommended encrypted backup format.

---

# 88. File Export

Students should be able to export:

- Study plan.
- Progress report.
- Syllabus progress.

Possible formats:

- PDF.
- CSV.
- JSON backup.

Advanced feature.

---

# 89. Cloud Backup

Optional advanced feature.

Allow user-controlled backup to services such as:

- Google Drive.
- OneDrive.
- Dropbox.

The core application should remain independent of cloud services.

---

# 90. Restore

Students can restore:

- Full Pocket Tutor backup.
- Selected academic plan.

Provide validation before replacing existing data.

---

# 91. Data Reset

Options:

- Reset progress only.
- Delete one study plan.
- Delete one subject.
- Delete all data.

Require confirmation for destructive actions.

---

# 92. Settings

Sections:

## General

- Language.
- Theme.
- First day of week.

## Study

- Default study session length.
- Default break length.
- Maximum daily workload.
- Revision frequency.
- Planning mode.

## Notifications

- Study reminder.
- Revision reminder.
- Exam countdown.
- Evening summary.

## Data

- Export backup.
- Import backup.
- Export reports.
- Reset application.

---

# 93. Student Profile

Minimal profile.

Fields:

- Name or nickname.
- Study level.
- Optional institution.
- Academic year.
- Preferred language.

No personally identifying information should be required.

---

# 94. Local Planning Engine

The offline planning engine should consider a weighted priority score.

Conceptually:

`Priority Score = Exam Urgency + Difficulty + Low Confidence + Importance + Backlog Age + Revision Need`

Higher-scoring tasks should be scheduled first.

---

# 95. Exam Urgency

A topic becomes increasingly important as the exam approaches.

Example:

Exam in:

60 days → moderate weighting.

14 days → high weighting.

3 days → critical weighting.

---

# 96. Confidence Weighting

Example:

Confidence 1/5:

High additional priority.

Confidence 5/5:

Lower additional priority unless exam importance is high.

---

# 97. Difficulty Weighting

Difficult chapters should:

- Receive longer sessions.
- Be scheduled earlier.
- Receive more revision.

---

# 98. Workload Constraints

The scheduler must obey:

- Maximum daily study hours.
- Available weekdays.
- Locked tasks.
- No-study periods.
- Exam dates.
- Maximum session duration.

---

# 99. Planning Buffer

Pocket Tutor should intentionally avoid planning 100% of available time.

Example:

Available:

3 hours

Scheduled:

2h 30m

30-minute buffer allows for:

- Delays.
- Breaks.
- Unexpected tasks.

Configurable.

---

# 100. Automatic Replanning

Trigger replanning when:

- A study task is missed.
- Exam date changes.
- Study availability changes.
- New chapters are added.
- Topic difficulty changes significantly.
- Student manually requests replan.

---

# 101. Replan Preview

Before major schedule changes:

Show:

**Your study plan needs an update.**

Changes:

5 tasks moved.

2 revision sessions added.

Expected completion changed:

Nov 18 → Nov 20.

Actions:

**Apply Plan**

**Review Changes**

---

# 102. Study Completion Methods

Allow:

- Complete entire task.
- Complete percentage.
- Enter actual study minutes.
- Mark chapter complete manually.

---

# 103. Estimated vs Actual Time

Track:

Planned:

45 min

Actual:

62 min

Pocket Tutor may use this data when estimating future sessions.

---

# 104. Task Types

Task types:

- New Study.
- Continue Study.
- Practice.
- Revision.
- Mock Test.
- Assignment.
- Reading.
- Custom.

---

# 105. Assignment and Coursework

Particularly useful for university users.

Fields:

- Assignment name.
- Course.
- Deadline.
- Estimated duration.
- Priority.
- Completion state.

---

# 106. Fixed Events

Users can add:

- Class.
- Coaching.
- Lab.
- Tuition.
- Exam.

These consume availability but are not necessarily study tasks.

Advanced scheduling feature.

---

# 107. Habit View

Simple view showing:

Last 7 days:

Sat ✓

Sun ✓

Mon ✓

Tue —

Wed ✓

Thu ✓

Fri ✓

---

# 108. Focus Subject

Allow students to temporarily designate:

**Focus Subject**

Example:

Physics

Duration:

7 days.

The planner increases Physics allocation.

---

# 109. Pause Subject

Example:

Biology exam completed.

Pause subject until further notice.

The scheduler should temporarily exclude it.

---

# 110. Archive Subject

Completed courses can be archived.

History remains available.

---

# 111. New Semester / New Exam Cycle

Allow creation of a new academic plan while retaining previous statistics.

---

# 112. Home Screen Widgets

Advanced mobile feature.

Possible widgets:

### Today's Study

3 tasks

2h 25m

### Exam Countdown

12 days

### Syllabus Progress

67%

---

# 113. Quick Actions

App shortcut actions:

- Start Next Task.
- Quick Study.
- Add Study Task.
- View Today.

---

# 114. Search and Filter

Global search should include:

- Subject names.
- Chapter names.
- Topics.
- Exam names.
- Study tasks.

---

# 115. Common Empty States

Examples:

### No Subjects

`এখনও কোনো বিষয় যোগ করা হয়নি।`

Action:

**বিষয় যোগ করুন**

### Today's Plan Empty

`আজকের সব পড়া শেষ।`

Secondary:

View tomorrow's plan.

---

# 116. No Upcoming Exam

Message:

**No exam has been added yet.**

Action:

**Add Exam**

---

# 117. Loading State

Because most data is local, loading should normally be near-instant.

Use:

- Short skeletons where necessary.
- Avoid unnecessary full-screen spinners.

---

# 118. Planning State

When generating a large schedule:

Show:

**আপনার পড়ার পরিকল্পনা তৈরি হচ্ছে...**

Steps may include:

- Checking syllabus.
- Calculating available time.
- Creating revision periods.
- Balancing subjects.

---

# 119. Planning Failure

If a valid plan cannot be generated:

Example:

**There isn't enough available study time to complete the current plan before the exam.**

Suggest:

- Increase study hours.
- Extend available days.
- Prioritize important chapters.
- Reduce revision buffer.

---

# 120. Impossible Schedule Warning

Example:

Remaining study:

48 hours

Available before exam:

29 hours

Difference:

19 hours

Pocket Tutor should clearly surface the issue rather than generating an unrealistic schedule.

---

# 121. Validation

Examples:

Exam date cannot be in the past.

Estimated chapter duration must be greater than zero.

Daily availability cannot exceed 24 hours.

Topic cannot be completed beyond 100%.

---

# 122. Delete Confirmation

Example:

**Delete Physics?**

This will delete:

- 12 chapters.
- 34 scheduled tasks.
- Study history linked to this subject.

Provide:

Cancel.

Delete.

---

# 123. Unsaved Changes

Warn when leaving important editing screens.

---

# 124. Database Migration

When app versions change:

Display a safe data-upgrade state if required.

Never silently discard study history.

---

# 125. Storage Management

Pocket Tutor should consume very little storage because it primarily stores structured data.

Show database/backup size in Data Settings.

---

# 126. Privacy

Because Pocket Tutor is offline-first:

- No account required.
- No analytics required for core functionality.
- No student data should leave the device without explicit action.
- Export and cloud backup should be user initiated.

---

# 127. MVP Feature Scope

Recommended MVP:

### Setup

- Language selection.
- Student type.
- Exam setup.
- Daily/weekly availability.

### Academic Management

- Subjects.
- Chapters.
- Difficulty.
- Confidence.
- Estimated study time.

### Planning

- Automatic daily planning.
- Manual tasks.
- Missed-task rescheduling.
- Basic revision scheduling.

### Execution

- Today's study.
- Start task.
- Optional timer.
- Complete/partial/skip.
- Quick Study.

### Tracking

- Syllabus completion.
- Subject progress.
- Daily/weekly study time.
- Task completion.
- Exam countdown.

### Offline

- Local database.
- Local notifications.
- Export/import backup.

---

# 128. Phase 2 Features

- Topics under chapters.
- Advanced backlog recovery.
- Confidence-driven scheduling.
- Revision queue.
- Weekly analytics.
- Study calendar.
- Custom planning modes.
- Study streak/consistency.
- Subject balance.
- PDF/CSV reports.

---

# 129. Phase 3 Features

- Multiple simultaneous plans.
- Cloud backup.
- What-if simulation.
- Academic templates.
- Advanced focus analytics.
- Home-screen widgets.
- Assignment support.
- Class/coaching schedule integration.
- Advanced exam-crunch planning.

---

# 130. Features to Avoid Initially

Pocket Tutor should deliberately avoid becoming bloated.

Do not prioritize:

- Video courses.
- Live classes.
- Teacher marketplace.
- Social feed.
- Student chat.
- Public leaderboards.
- Full textbook content.
- Large question banks.
- Online accounts.
- Complex AI chatbots.

These features would weaken the core proposition:

> **Helping the student actually finish what they already need to study.**

---

# 131. Core User Journey

The ideal flow is:

### Step 1

Student installs Pocket Tutor.

### Step 2

Selects:

HSC Science.

### Step 3

Adds:

Physics  
Chemistry  
Higher Mathematics  
Biology

### Step 4

Adds chapters and estimated times.

### Step 5

Sets exam date:

December 5.

### Step 6

Sets study availability:

2 hours weekdays.

5 hours Friday.

### Step 7

Pocket Tutor calculates the study plan.

### Step 8

Next morning the student sees:

## আজকের পড়া

Physics — Newtonian Mechanics — 45 min

Chemistry — Organic Chemistry — 50 min

Math — Exercise 7.2 — 35 min

### Step 9

Student completes two tasks but misses Chemistry.

### Step 10

Pocket Tutor automatically redistributes Chemistry without overloading the next day.

### Step 11

Over the next weeks the student sees:

**Syllabus Completed**

67%

**Exam**

18 days remaining

**Status**

On Track

### Step 12

The final two weeks shift increasingly toward revision.

This daily planning-and-feedback loop is the central Pocket Tutor experience.

---

# 132. Key Product Differentiator

Most educational applications answer:

> **“What can I learn?”**

Pocket Tutor answers:

> **“What exactly should I study today so that I finish everything before my exam?”**

That distinction should remain at the center of product, UX, technical, and feature decisions.

---

# 133. Recommended Core Dashboard Metrics

The most important numbers should be:

**Today's study**

2h 25m

**Tasks**

3

**Syllabus**

67%

**Exam**

18 days

**Study status**

On Track

**Backlog**

1h 20m

**Revision due**

3 chapters

Students should be able to understand their entire study situation from this single dashboard.

---

# 134. Product Success Criteria

Pocket Tutor succeeds if a student can:

1. Set up their syllabus quickly.
2. Open the app and immediately know what to study.
3. Finish tasks with minimal interaction.
4. Miss study days without breaking their entire plan.
5. See clearly whether they are ahead or behind.
6. Finish the syllabus with enough time left for revision.
7. Use the complete core product without internet access.

The most important product promise should remain:

> **Pocket Tutor turns a syllabus and an exam date into a realistic daily execution plan.**
