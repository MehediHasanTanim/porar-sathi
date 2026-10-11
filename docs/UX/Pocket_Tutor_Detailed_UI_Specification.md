# Pocket Tutor — Detailed UI Specification

## 1. Document Purpose

This document defines the complete mobile UI specification for **Pocket Tutor — Offline Study Planner**.

The application targets:

- SSC students.
- HSC students.
- University students.
- Admission-test candidates.
- Diploma and polytechnic students.
- Other self-study learners in Bangladesh.

The app is:

- Mobile-only.
- Offline-first.
- English + বাংলা.
- Designed for Android and iOS.
- Focused on study execution rather than learning content.

The core UX question is:

> **What exactly should I study today so I can finish everything before my exam?**

---

# 2. Global UX Principles

## 2.1 Simplicity

The app should feel useful within seconds.

Avoid:

- Complex dashboards.
- Excessive charts.
- Dense configuration.
- Deep menu structures.
- Unnecessary confirmations.

Prioritize:

- Clear next action.
- Short forms.
- Large tap targets.
- Visible study status.

---

## 2.2 Offline-First UX

Never show network-dependent loading for core features.

Core areas should remain available offline:

- Today.
- Planner.
- Syllabus.
- Progress.
- Exams.
- Study timer.
- Revision.
- Backup to local file.

If optional cloud features are added later, clearly distinguish them from core features.

---

## 2.3 Bangla-First Readability

Bangla copy should be natural and concise.

Examples:

- Today's Study → `আজকের পড়া`
- Study Plan → `পড়ার পরিকল্পনা`
- Syllabus Progress → `সিলেবাস অগ্রগতি`
- Backlog → `বাকি পড়া`
- Revision → `পুনরাবৃত্তি`
- Confidence → `আত্মবিশ্বাস`
- Difficulty → `কঠিনতার মাত্রা`

Avoid overly formal Bangla where a simpler phrase works better.

---

## 2.4 Progressive Disclosure

Show only essential information by default.

Example:

Task card default:

- Subject.
- Chapter/topic.
- Duration.
- Priority.
- Start.

Secondary information such as:

- Reason for recommendation.
- Exam linkage.
- Confidence.
- Difficulty.

should be available via expand/details.

---

## 2.5 Explainable Automation

Generated plans must feel understandable.

Where relevant, provide:

**Why this task?**

Example:

- Exam is in 8 days.
- Confidence is Low.
- Chapter is High Priority.

---

# 3. Visual Design Direction

## 3.1 Overall Style

Recommended:

- Clean.
- Calm.
- Academic.
- Friendly.
- Minimal.
- Modern Material 3 / iOS-compatible design language.

Avoid:

- Gamified neon visuals.
- Excessive gradients.
- Childish iconography.
- Highly decorative academic illustrations.

---

## 3.2 Color System

Use semantic tokens:

- Primary.
- Secondary.
- Surface.
- Success.
- Warning.
- Danger.
- Info.

Subject colors may be user-selectable.

Examples:

- Physics.
- Chemistry.
- Mathematics.
- Biology.

Do not use color alone to communicate status.

---

## 3.3 Typography

Use:

- Large readable headings.
- Medium-weight task titles.
- High legibility Bangla font.
- Comfortable line spacing.

Recommended hierarchy:

- Display title.
- Screen title.
- Section title.
- Card title.
- Body.
- Caption.

---

# 4. App Navigation

## 4.1 Bottom Navigation

Five primary items:

1. **Today / আজ**
2. **Plan / পরিকল্পনা**
3. **Syllabus / সিলেবাস**
4. **Progress / অগ্রগতি**
5. **More / আরও**

Recommended icons:

- Today: Home/Today.
- Plan: Calendar.
- Syllabus: Book.
- Progress: Chart.
- More: Menu.

---

## 4.2 Global Quick Action

Floating action or contextual button:

**+ Quick Study**

Alternative Bangla:

**+ দ্রুত পড়া**

Available from:

- Today.
- Plan.
- Syllabus.

---

# 5. Screen Inventory

This specification covers:

## A. Launch & Onboarding

1. Splash
2. Language Selection
3. Welcome
4. Study Type
5. Student Profile
6. Create Study Plan
7. Exam Setup
8. Weekly Availability
9. Preferred Study Time
10. Planning Preferences
11. Initial Plan Preview
12. Notification Permission Education
13. Setup Complete

## B. Today

14. Today Dashboard
15. Today Task Details
16. Start Study Confirmation
17. Active Study Session
18. Pause Session
19. Finish Session
20. Manual Completion
21. Partial Completion
22. Skip Task
23. Move Task
24. Quick Study
25. Quick Study Session
26. Today's Summary

## C. Plan

27. Plan Home
28. Day View
29. Week View
30. Calendar View
31. Upcoming
32. Add Manual Task
33. Edit Task
34. Lock Task
35. Replan Preview
36. Replan Applied
37. Planning Risk
38. Impossible Schedule
39. Study Availability Override
40. Calendar Exception
41. Catch-Up Plan

## D. Syllabus

42. Syllabus Dashboard
43. Subject List
44. Add Subject
45. Edit Subject
46. Subject Details
47. Chapter List
48. Add Chapter
49. Bulk Add Chapters
50. Edit Chapter
51. Chapter Details
52. Topic List
53. Add Topic
54. Edit Topic
55. Attention List
56. Syllabus Search & Filter

## E. Exams

57. Exam List
58. Add Exam
59. Edit Exam
60. Exam Details
61. Exam Syllabus Mapping
62. Exam Countdown
63. Exam-Crunch Mode
64. Last 7 Days Plan
65. Exam Day Mode

## F. Revision & Backlog

66. Revision Queue
67. Revision Details
68. Revision Session
69. Revision Complete
70. Backlog Dashboard
71. Backlog Task Details
72. Recovery Recommendation
73. Catch-Up Confirmation

## G. Progress

74. Progress Dashboard
75. Syllabus Progress Details
76. Subject Progress
77. Study Time
78. Task Completion
79. Study Consistency
80. Subject Balance
81. Readiness
82. Daily Summary
83. Weekly Summary
84. Monthly Summary
85. Study History
86. Session History Details

## H. More

87. More Home
88. Student Profile
89. Edit Profile
90. Study Plans
91. Study Plan Details
92. New Study Plan
93. Archived Plans
94. Notifications Settings
95. Study Settings
96. Appearance
97. Language
98. Data & Backup
99. Export Backup
100. Import Backup
101. Backup Validation
102. Restore Confirmation
103. Restore Complete
104. Export Reports
105. Storage Management
106. Privacy
107. About

## I. Common States & Components

108. Initial Loading
109. Skeleton Loading
110. Empty Today
111. Empty Subject List
112. Empty Chapter List
113. No Search Results
114. Save in Progress
115. Save Success
116. Save Failed
117. Delete Confirmation
118. Delete Failed
119. Unsaved Changes
120. Permission Denied
121. Notification Denied
122. Planner Generating
123. Planner Failed
124. Database Migration
125. Backup Failed
126. Restore Failed
127. Corrupt Backup
128. Storage Nearly Full
129. Date Picker
130. Duration Picker
131. Confidence Selector
132. Difficulty Selector
133. Priority Selector
134. Subject Selector
135. Chapter Selector
136. Search & Filter Sheet
137. Confirmation Bottom Sheet

---

# 6. A. Launch & Onboarding

# 6.1 Screen 1 — Splash

## Purpose

Provide a fast branded launch while local services initialize.

## Layout

Center:

- App icon.
- App name: **Pocket Tutor**.
- Optional Bangla subtitle: `পকেট টিউটর`.

Bottom:

- Small loading indicator only if initialization exceeds a brief moment.

## Behavior

On launch:

1. Initialize database.
2. Load settings.
3. Resolve theme/language.
4. Check onboarding status.
5. Navigate accordingly.

## UX Rule

Avoid long splash animation.

---

# 6.2 Screen 2 — Language Selection

## Header

**Choose your language**

Bangla:

**ভাষা বেছে নিন**

## Content

Two large cards:

### বাংলা

- `বাংলায় অ্যাপ ব্যবহার করুন`

### English

- `Use the app in English`

## Primary Action

**Continue / চালিয়ে যান**

## Behavior

- Selected language applies instantly.
- Persist choice.
- Can be changed later.

---

# 6.3 Screen 3 — Welcome

## Header

**Plan less. Study better.**

Bangla:

**কী পড়বেন ভাববেন কম, পড়বেন বেশি।**

## Content

Three concise benefits:

1. Add your subjects and syllabus.
2. Tell Pocket Tutor when you can study.
3. Get a realistic daily study plan.

## Illustration

Optional simple calendar/book illustration.

## Primary Action

**Get Started / শুরু করি**

## Secondary

**How it works**

Optional.

---

# 6.4 Screen 4 — Study Type

## Header

**What are you studying for?**

Bangla:

**আপনি কীসের জন্য পড়ছেন?**

## Options

Large selectable cards:

- SSC
- HSC
- University
- Admission Test
- Diploma / Polytechnic
- Other

## Footer

Small note:

`You can change this later.`

## Primary Action

**Continue**

---

# 6.5 Screen 5 — Student Profile

## Purpose

Collect minimal personalization.

## Fields

- Name or nickname.
- Academic year/session.
- Institution — optional.

## UX

Name should be optional.

Do not require:

- Email.
- Phone.
- Account creation.

## Primary Action

**Continue**

## Secondary

**Skip for now**

---

# 6.6 Screen 6 — Create Study Plan

## Header

**Create your first study plan**

## Fields

- Plan name.
- Plan type.
- Start date.
- Target end date.

Examples:

- HSC Final 2027.
- Semester 3 Finals.
- BUET Admission.

## Suggested Plan Name

Auto-generated based on selected study type.

## Primary Action

**Continue**

---

# 6.7 Screen 7 — Exam Setup

## Header

**When is your exam?**

## Fields

- Exam name.
- Exam type.
- Exam date.
- Optional end date.
- Importance.

## Importance

- Normal.
- Important.
- Very Important.

## Actions

- Add another exam.
- Continue.

## Empty Option

Allow:

**I don't have an exam date yet**

Then use target completion date.

---

# 6.8 Screen 8 — Weekly Availability

## Header

**How much time can you study?**

Bangla:

**কোন দিনে কতক্ষণ পড়তে পারেন?**

## Layout

Rows:

- Saturday
- Sunday
- Monday
- Tuesday
- Wednesday
- Thursday
- Friday

Each row:

- Enable toggle.
- Hours/minutes picker.

Example:

`Saturday  [ 3h 00m ]`

## Quick Presets

- 1 hour every day.
- 2 hours every day.
- Custom.

## Primary Action

**Continue**

---

# 6.9 Screen 9 — Preferred Study Time

## Header

**When do you usually study?**

## Options

Multi-select:

- Morning.
- Afternoon.
- Evening.
- Night.

Optional exact windows:

- 6:30–7:30 AM.
- 8:00–10:00 PM.

## UX

Mark as optional.

## Primary Action

**Continue**

## Secondary

**Skip**

---

# 6.10 Screen 10 — Planning Preferences

## Header

**How should Pocket Tutor plan your study?**

## Planning Mode Cards

### Balanced

`Spread subjects evenly.`

### Weak Subject Focus

`Give more time to difficult and low-confidence topics.`

### Light

`Keep the daily plan lighter.`

### Exam Crunch

`Prioritize urgent exam preparation.`

Default:

**Balanced**

## Additional Settings

- Max session length.
- Planning buffer.
- Daily intensity.

## Primary Action

**Generate My Plan**

---

# 6.11 Screen 11 — Initial Plan Preview

## Header

**Your study plan is ready**

## Summary Cards

- Average daily study.
- Expected syllabus finish.
- Exam date.
- Revision buffer.
- Current risk.

Example:

**Average daily study**
2h 10m

**Expected finish**
18 November

**Exam**
5 December

**Revision buffer**
17 days

**Status**
On Track

## Sections

- First 3 days preview.
- Subject allocation.
- Warning if capacity is tight.

## Primary Action

**Use This Plan**

## Secondary

**Adjust Availability**

---

# 6.12 Screen 12 — Notification Permission Education

## Header

**Get gentle study reminders**

## Explain

Pocket Tutor can remind you about:

- Today's plan.
- Revision.
- Upcoming exams.
- Evening review.

## Primary Action

**Enable Notifications**

## Secondary

**Not Now**

Only after education should the OS permission dialog appear.

---

# 6.13 Screen 13 — Setup Complete

## Header

**You're ready to start**

## Content

Show:

- Active plan.
- Today's planned duration.
- Number of tasks.

## Primary Action

**See Today's Study**

---

# 7. B. Today

# 7.1 Screen 14 — Today Dashboard

## Purpose

Primary daily execution screen.

## Top App Bar

Left:

- Greeting or date.

Example:

**Tuesday, 6 October**

Right:

- Notification icon.
- Overflow.

## Hero Section

### Today's Target

- Total planned duration.
- Tasks completed / total.
- Progress ring or bar.

Example:

**2h 25m**
`1 of 3 tasks done`

## Exam Card

Show nearest important exam:

**HSC Physics**
18 days remaining

Secondary:

`On Track`

## Section — Today's Study

Task cards.

Each card includes:

- Subject color strip/icon.
- Subject name.
- Chapter/topic.
- Duration.
- Task type.
- Priority chip if important.
- Status.
- Start button.

Example:

**Physics**
Newtonian Mechanics  
45 min  
High Priority

`Start`

## Section — Revision Due

Compact card:

**3 revisions due**

Action:

**Review**

## Section — Backlog

Only show if backlog exists.

Example:

`1h 20m behind schedule`

Action:

**View Backlog**

## Quick Actions

- Quick Study.
- Add Task.

## Empty Today State

If all done:

**আজকের সব পড়া শেষ।**

Secondary:

`Tomorrow's plan is ready.`

Actions:

- View Tomorrow.
- Quick Study.

---

# 7.2 Screen 15 — Today Task Details

## Header

Subject + task title.

## Content

- Subject.
- Chapter/topic.
- Task type.
- Planned duration.
- Exam linked.
- Difficulty.
- Confidence.
- Priority.
- Why this task?

## Why This Task

Expandable section:

- Exam in 12 days.
- Confidence is Low.
- High-priority chapter.

## Actions

Primary:

**Start Study**

Secondary:

- Mark Complete.
- Move.
- Edit.
- Skip.

---

# 7.3 Screen 16 — Start Study Confirmation

Optional lightweight bottom sheet.

Show:

- Task title.
- Planned duration.
- Timer mode.

Options:

- Start Timer.
- Study Without Timer.

Do not force confirmation if user preference disables it.

---

# 7.4 Screen 17 — Active Study Session

## Layout

Top:

- Subject.
- Chapter.
- Small exam countdown if relevant.

Center:

Large timer.

Example:

`24:36`

Below:

`Planned: 45 min`

Progress ring optional.

## Controls

- Pause.
- Finish.
- Stop.

## Secondary

- Add quick note.
- Mark distraction — optional future feature.

## UX

Keep screen distraction-free.

No charts or dashboard information.

---

# 7.5 Screen 18 — Pause Session

## State

Timer visibly paused.

Message:

**Session paused**

Actions:

- Resume.
- Finish Now.

Optional:

Show current elapsed time.

---

# 7.6 Screen 19 — Finish Session

## Header

**How did this session go?**

## Completion Options

- Fully completed.
- Mostly completed.
- Partially completed.
- Could not study.

## Actual Time

Pre-filled from timer.

Editable.

## Confidence

`How confident do you feel now?`

1–5 selector.

## Revision

Toggle:

**I want to revise this later**

## Note

Optional.

## Primary Action

**Save Session**

---

# 7.7 Screen 20 — Manual Completion

For users not using timer.

Fields:

- Completion status.
- Actual study minutes.
- Confidence.
- Need revision?
- Note.

Primary:

**Save**

---

# 7.8 Screen 21 — Partial Completion

## Header

**How much did you finish?**

Controls:

- Slider.
- Percentage field.
- Quick values:
  - 25%
  - 50%
  - 75%

Show:

`About 30 minutes remain.`

Primary:

**Save & Replan Remaining**

Secondary:

**Save Without Replanning**

---

# 7.9 Screen 22 — Skip Task

## Bottom Sheet

Header:

**Skip this task?**

Options:

- Skip only today.
- Remove from plan.
- Reschedule automatically.

Optional reason:

- Not enough time.
- Too difficult.
- Already studied.
- Other.

Primary action varies by option.

---

# 7.10 Screen 23 — Move Task

## Header

**Move study task**

## Controls

- Date selector.
- Suggested dates.
- Available capacity indicator.

Example:

Wednesday  
`1h 20m free`

Thursday  
`40m free`

If selected day exceeds capacity:

Show warning.

---

# 7.11 Screen 24 — Quick Study

## Header

**Quick Study**

## Fields

- Subject.
- Chapter/topic.
- Study type.
- Planned duration.

Buttons:

- Start Timer.
- Log Completed Study.

---

# 7.12 Screen 25 — Quick Study Session

Same visual structure as Active Study Session.

Label:

**Quick Study**

On finish:

Update study history and progress.

---

# 7.13 Screen 26 — Today's Summary

## Header

**আজকের সারাংশ / Today's Summary**

## Cards

- Planned.
- Studied.
- Completed tasks.
- Syllabus progress change.

Example:

Planned  
3h

Studied  
2h 35m

Tasks  
4 / 5

## Sections

### Most Studied

Mathematics — 1h 10m

### Remaining

Chemistry — Organic Chemistry

### Tomorrow

3 tasks · 2h 15m

Primary:

**Done**

---

# 8. C. Plan

# 8.1 Screen 27 — Plan Home

## Header

**Study Plan**

## Segmented Control

- Day.
- Week.
- Calendar.

## Summary

- This week's planned study.
- Available study time.
- Backlog.
- Next exam.

## Actions

- Add Task.
- Replan.
- Edit Availability.

---

# 8.2 Screen 28 — Day View

## Date Header

Left/right navigation.

Example:

`Tue, 6 Oct`

## Content

Vertical timeline/list:

- Study tasks.
- Revision.
- Manual tasks.
- Exam events.

Each item:

- Time or duration.
- Subject.
- Chapter.
- Status.
- Locked icon.

## Actions

Tap task → Task Details.

Long press or overflow:

- Move.
- Edit.
- Lock.
- Delete.

---

# 8.3 Screen 29 — Week View

## Header

**This Week**

## Summary

Planned:

14h 30m

Completed:

9h 20m

Remaining:

5h 10m

## Layout

Seven collapsible day groups.

Each day shows:

- Planned duration.
- Task count.
- Completion state.

Expanded:

Task list.

## Footer

Subject allocation bar.

---

# 8.4 Screen 30 — Calendar View

## Monthly Calendar

Indicators:

- Completed day.
- Partial day.
- Missed day.
- Revision due.
- Exam.
- No-study day.

## Selected Date Panel

Below calendar:

- Study duration.
- Tasks.
- Exam.
- Availability.

---

# 8.5 Screen 31 — Upcoming

## Filters

- 7 days.
- 14 days.
- 30 days.

## Sections

Grouped by date.

Show:

- Study task.
- Revision.
- Exam.
- Backlog recovery.

---

# 8.6 Screen 32 — Add Manual Task

Fields:

- Subject.
- Chapter/topic.
- Task type.
- Date.
- Duration.
- Priority.
- Lock task.
- Note.

Primary:

**Add Task**

---

# 8.7 Screen 33 — Edit Task

Editable:

- Title.
- Subject.
- Chapter/topic.
- Date.
- Duration.
- Priority.
- Lock state.

If task was auto-generated:

Show label:

`Generated by Pocket Tutor`

If modified manually:

Mark:

`Manual override`

---

# 8.8 Screen 34 — Lock Task

Bottom sheet:

**Keep this task fixed?**

Explanation:

`Locked tasks will not move during automatic replanning.`

Actions:

- Lock.
- Cancel.

---

# 8.9 Screen 35 — Replan Preview

## Header

**Your plan needs an update**

## Summary

Example:

- 5 tasks moved.
- 2 revisions added.
- Expected finish changed:
  - Nov 18 → Nov 20.

## Tabs

- Summary.
- Changes.

## Change List

Each row:

Old date → New date.

## Primary

**Apply Changes**

## Secondary

**Keep Current Plan**

---

# 8.10 Screen 36 — Replan Applied

Success state:

**Study plan updated**

Show:

- New expected finish.
- Backlog status.
- Next task.

Primary:

**View Today**

---

# 8.11 Screen 37 — Planning Risk

## Header

**Your plan is getting tight**

## Visual

Warning icon.

## Explain

Example:

`You need 18 hours of study, but only 14 hours are available before the exam.`

## Suggestions

- Add more study time.
- Increase daily intensity.
- Reduce revision buffer.
- Mark lower-priority chapters optional.

Primary:

**Adjust Plan**

Secondary:

**Continue Anyway**

---

# 8.12 Screen 38 — Impossible Schedule

## Header

**This plan doesn't fit before the exam**

## Summary

Required:

48h

Available:

29h

Shortfall:

19h

## Actions

- Increase Study Time.
- Prioritize Chapters.
- Change Exam Date.
- Edit Estimates.

Do not allow silent plan creation that drops required work.

---

# 8.13 Screen 39 — Study Availability Override

## Header

**Change study time for this day**

Show:

Normal Tuesday:

2h

Override:

30m

Options:

- Custom available time.
- No study today.
- Extra study day.

Primary:

**Save Override**

---

# 8.14 Screen 40 — Calendar Exception

Fields:

- Date.
- Type.
- Reason.
- Available study time.

Types:

- Holiday.
- Coaching.
- Exam.
- Family Event.
- Travel.
- Sick Day.
- Custom.

---

# 8.15 Screen 41 — Catch-Up Plan

## Header

**Catch-Up Plan**

## Summary

`You are about 3h 20m behind.`

## Recommended Recovery

Saturday +40m  
Sunday +40m  
Tuesday +30m  
Friday +90m

## Actions

Primary:

**Apply Catch-Up Plan**

Secondary:

**Adjust**

---

# 9. D. Syllabus

# 9.1 Screen 42 — Syllabus Dashboard

## Header

**Syllabus**

## Overall Progress

Large:

**67%**

Below:

- Completed chapters.
- In progress.
- Remaining.
- Revision due.

## Subject Cards

Each:

- Subject.
- Progress.
- Confidence.
- Remaining chapters.
- Exam countdown.

## Actions

- Add Subject.
- Search.

---

# 9.2 Screen 43 — Subject List

## Toolbar

- Search.
- Filter.
- Add.

## Subject Row/Card

- Color.
- Name.
- Progress.
- Confidence.
- Remaining chapters.
- Status.

Swipe or overflow:

- Edit.
- Pause.
- Archive.
- Delete.

---

# 9.3 Screen 44 — Add Subject

Fields:

- Subject name.
- Subject code — optional.
- Paper.
- Priority.
- Difficulty.
- Confidence.
- Color.
- Icon.

Primary:

**Add Subject**

---

# 9.4 Screen 45 — Edit Subject

Same fields as Add.

Additional:

- Status.
- Pause subject.
- Archive subject.

Destructive section:

- Delete subject.

---

# 9.5 Screen 46 — Subject Details

## Header

Subject name.

## Summary

- Progress.
- Confidence.
- Study time.
- Exam date.
- Remaining chapters.

## Sections

- Chapters.
- Upcoming tasks.
- Revision due.
- Study history.

Actions:

- Add Chapter.
- Edit Subject.

---

# 9.6 Screen 47 — Chapter List

Rows:

- Chapter number.
- Title.
- Progress.
- Difficulty.
- Confidence.
- Status.

Quick filter chips:

- All.
- Not Started.
- In Progress.
- Completed.
- Revision Due.

---

# 9.7 Screen 48 — Add Chapter

Fields:

- Chapter title.
- Chapter number.
- Estimated study time.
- Difficulty.
- Confidence.
- Priority.
- Exam importance.
- Notes.

Primary:

**Add Chapter**

---

# 9.8 Screen 49 — Bulk Add Chapters

## Header

**Add multiple chapters**

## Text Area

Example placeholder:

```text
Vector
Dynamics
Newtonian Mechanics
Work and Energy
Gravitation
```

## Preview

Show parsed lines.

Allow:

- Remove line.
- Edit line.

Primary:

**Create 5 Chapters**

---

# 9.9 Screen 50 — Edit Chapter

Editable:

- Title.
- Number.
- Estimate.
- Difficulty.
- Confidence.
- Priority.
- Exam importance.
- Notes.
- Status.

Show if chapter has generated tasks:

`Changing study time may update your plan.`

---

# 9.10 Screen 51 — Chapter Details

## Summary

- Progress.
- Estimated time.
- Actual study time.
- Difficulty.
- Confidence.
- Priority.
- Revision status.

## Actions

- Study Now.
- Revise Now.
- Edit.
- Mark Complete.

## Sections

- Topics.
- Upcoming tasks.
- Study history.
- Notes.

---

# 9.11 Screen 52 — Topic List

Only when topic-level planning is enabled.

Each row:

- Topic.
- Progress.
- Confidence.
- Status.

Action:

**Add Topic**

---

# 9.12 Screen 53 — Add Topic

Fields:

- Topic title.
- Estimated time.
- Difficulty.
- Confidence.
- Priority.
- Exam importance.
- Notes.

---

# 9.13 Screen 54 — Edit Topic

Same as Add Topic.

Additional:

- Status.
- Delete.

---

# 9.14 Screen 55 — Attention List

## Header

**Needs Attention**

Shows topics/chapters with:

- Low confidence.
- High difficulty.
- Overdue revision.
- Repeated partial completion.

Each item includes reason.

Example:

**Vector**
Low confidence · Revision overdue

---

# 9.15 Screen 56 — Syllabus Search & Filter

Search field.

Filters:

- Subject.
- Status.
- Difficulty.
- Confidence.
- Priority.
- Revision due.

Actions:

- Apply.
- Clear All.

---

# 10. E. Exams

# 10.1 Screen 57 — Exam List

Sections:

- Upcoming.
- Completed.
- No date.

Exam card:

- Name.
- Date.
- Days remaining.
- Preparation status.
- Linked subjects.

Action:

**Add Exam**

---

# 10.2 Screen 58 — Add Exam

Fields:

- Exam name.
- Type.
- Date.
- Optional end date.
- Time.
- Importance.
- Notes.

Primary:

**Add Exam**

---

# 10.3 Screen 59 — Edit Exam

Same fields.

Warning if date changes:

`Your study plan may need to be updated.`

Primary:

**Save & Review Plan**

---

# 10.4 Screen 60 — Exam Details

## Header

Exam name.

## Countdown

**18 days remaining**

## Preparation Summary

- Syllabus completion.
- Revision completion.
- Readiness.
- Backlog.

## Sections

- Subjects.
- Chapters.
- Upcoming tasks.

Actions:

- Edit.
- Map Syllabus.
- Enter Exam Crunch Mode.

---

# 10.5 Screen 61 — Exam Syllabus Mapping

## Header

**What's included in this exam?**

Hierarchical check list:

Subject  
→ Chapter  
→ Topic

Actions:

- Select All.
- Clear.
- Save.

---

# 10.6 Screen 62 — Exam Countdown

Focused screen/widget-like view.

Show:

- Exam.
- Date.
- Days remaining.
- Remaining syllabus.
- Required study hours.
- Current status.

Action:

**View Preparation Plan**

---

# 10.7 Screen 63 — Exam-Crunch Mode

## Header

**Exam Crunch Mode**

Explain changes:

- More urgent topics first.
- More revision.
- Higher daily intensity.
- Low-priority content may be deferred.

Controls:

- 7 days.
- 14 days.
- 30 days.
- Custom.

Primary:

**Activate**

---

# 10.8 Screen 64 — Last 7 Days Plan

Shows day-by-day:

- Revision subjects.
- Key topics.
- Mock tests.
- Light load before exam.

Avoid heavy new content unless user requests.

---

# 10.9 Screen 65 — Exam Day Mode

## Header

Exam subject.

## Content

- Exam time.
- Short revision list.
- Preparation completed.
- Confidence.

## Actions

- Quick Revision.
- Mark Exam Completed.

Avoid heavy planning UI.

---

# 11. F. Revision & Backlog

# 11.1 Screen 66 — Revision Queue

Tabs:

- Due Today.
- Overdue.
- Upcoming.

Each revision item:

- Subject.
- Chapter/topic.
- Estimated time.
- Last studied.
- Confidence.

Action:

**Start Revision**

---

# 11.2 Screen 67 — Revision Details

Show:

- Topic/chapter.
- Last studied.
- Number of previous revisions.
- Confidence history.
- Due date.
- Estimated duration.

Actions:

- Start.
- Reschedule.
- Skip.

---

# 11.3 Screen 68 — Revision Session

Similar to study timer but labeled:

**Revision**

Show:

- Timer.
- Chapter.
- Last studied.
- Confidence.

Actions:

- Pause.
- Finish.

---

# 11.4 Screen 69 — Revision Complete

Ask:

- How confident do you feel now?
- Need another revision?

Show:

`Next revision: 7 days`

Primary:

**Done**

---

# 11.5 Screen 70 — Backlog Dashboard

## Header

**Backlog / বাকি পড়া**

## Summary

- Overdue tasks.
- Total backlog time.
- Oldest missed task.
- Recovery estimate.

## Subject Breakdown

Physics — 2 tasks  
Math — 2 tasks  
Chemistry — 1 task

## Primary

**Build Catch-Up Plan**

---

# 11.6 Screen 71 — Backlog Task Details

Show:

- Original date.
- Subject.
- Chapter.
- Planned duration.
- Completion.
- Days overdue.

Actions:

- Study Now.
- Reschedule.
- Skip.
- Remove.

---

# 11.7 Screen 72 — Recovery Recommendation

Show:

`You can recover this backlog in 4 days.`

Suggested extra study:

- Sat +40m.
- Sun +40m.
- Tue +30m.
- Fri +90m.

Actions:

- Apply.
- Edit.

---

# 11.8 Screen 73 — Catch-Up Confirmation

Success:

**Catch-Up Plan Added**

Show:

- New backlog completion date.
- New expected syllabus finish.

Primary:

**View Updated Plan**

---

# 12. G. Progress

# 12.1 Screen 74 — Progress Dashboard

## Header

**Progress**

## Time Range

- Week.
- Month.
- All Time.

## Cards

### Syllabus

67%

### Study Time

14h 40m

### Task Completion

28 / 32

### Revision

8 completed

### Consistency

23 of 30 days

### Readiness

76% — On Track

## Sections

- Subject progress.
- Study trend.
- Subject balance.

---

# 12.2 Screen 75 — Syllabus Progress Details

Show:

- Overall progress.
- Completed chapters.
- In progress.
- Not started.
- Revision due.

Subject breakdown.

Progress should be workload-weighted.

---

# 12.3 Screen 76 — Subject Progress

Show:

- Completion.
- Study time.
- Confidence.
- Revision completion.
- Remaining work.

Chapter list sorted by:

- Needs attention.
- In progress.
- Complete.

---

# 12.4 Screen 77 — Study Time

Time filters.

Metrics:

- Planned.
- Actual.
- Difference.
- Average daily.
- Most productive day/time.

Chart:

Simple bar/line chart.

---

# 12.5 Screen 78 — Task Completion

Show:

- Completed.
- Partial.
- Missed.
- Skipped.

Trend by week.

Avoid judgmental wording.

---

# 12.6 Screen 79 — Study Consistency

Show:

**23 of last 30 available study days**

Calendar heatmap optional.

Explain:

`Configured no-study days are not counted against you.`

---

# 12.7 Screen 80 — Subject Balance

Show allocation:

Physics 28%  
Math 32%  
Chemistry 12%  
Biology 28%

Highlight neglected subject.

Action:

**Balance Upcoming Plan**

---

# 12.8 Screen 81 — Readiness

## Header

**Preparation Readiness**

Score/status:

76%  
On Track

## Breakdown

- Syllabus completion.
- Confidence.
- Revision.
- Backlog.
- Consistency.

## Explanation

`This is a preparation indicator, not an exam-score prediction.`

---

# 12.9 Screen 82 — Daily Summary

See Today Summary but accessible historically.

Display:

- Planned.
- Studied.
- Completed.
- Missed.
- Notes.

---

# 12.10 Screen 83 — Weekly Summary

Show:

- Study time target.
- Actual study time.
- Task completion.
- Syllabus change.
- Revision.
- Most improved subject.
- Needs attention.

---

# 12.11 Screen 84 — Monthly Summary

Show:

- Total study hours.
- Average per study day.
- Chapters completed.
- Revisions.
- Consistency.
- Subject distribution.

---

# 12.12 Screen 85 — Study History

Filters:

- Date.
- Subject.
- Task type.

Rows:

- Date.
- Subject.
- Chapter.
- Actual duration.
- Result.

---

# 12.13 Screen 86 — Session History Details

Show:

- Task.
- Started time.
- Ended time.
- Duration.
- Completion.
- Confidence before/after.
- Note.

Allow editing:

- Actual duration.
- Note.

Avoid altering original planning history except through controlled correction.

---

# 13. H. More

# 13.1 Screen 87 — More Home

Sections:

### Account & Profile

- Student Profile.
- Study Plans.

### Preferences

- Study Settings.
- Notifications.
- Appearance.
- Language.

### Data

- Backup & Restore.
- Export Reports.
- Storage.

### About

- Privacy.
- About Pocket Tutor.

---

# 13.2 Screen 88 — Student Profile

Show:

- Name/nickname.
- Study level.
- Academic year.
- Institution.
- Preferred language.

Action:

**Edit Profile**

---

# 13.3 Screen 89 — Edit Profile

Fields:

- Name.
- Study level.
- Academic year.
- Institution.

Primary:

**Save**

---

# 13.4 Screen 90 — Study Plans

List:

- Active.
- Paused.
- Archived.

Each card:

- Plan name.
- Type.
- Progress.
- Target date.

Actions:

- Switch.
- Pause.
- Archive.

Primary:

**New Study Plan**

---

# 13.5 Screen 91 — Study Plan Details

Show:

- Name.
- Type.
- Start date.
- Target date.
- Planning mode.
- Daily intensity.
- Max workload.
- Revision buffer.
- Status.

Actions:

- Edit.
- Pause.
- Archive.
- Delete.

---

# 13.6 Screen 92 — New Study Plan

Same core flow as onboarding but condensed.

Steps:

1. Plan details.
2. Exam.
3. Subjects.
4. Availability.
5. Generate plan.

---

# 13.7 Screen 93 — Archived Plans

Cards:

- Name.
- Date range.
- Final progress.
- Total study time.

Actions:

- View.
- Restore.
- Delete.

---

# 13.8 Screen 94 — Notification Settings

Toggles:

- Daily plan.
- Study session.
- Revision.
- Exam countdown.
- Missed task.
- Evening review.

For enabled reminders:

- Time picker.
- Frequency where relevant.

---

# 13.9 Screen 95 — Study Settings

Settings:

- Planning mode.
- Max daily workload.
- Default session length.
- Planning buffer.
- Revision policy.
- Auto-replan.
- First day of week.
- Default daily intensity.

---

# 13.10 Screen 96 — Appearance

Options:

- Light.
- Dark.
- System.

Additional future:

- Text size.
- Reduced motion.
- High contrast.

---

# 13.11 Screen 97 — Language

Options:

- বাংলা.
- English.

Apply immediately.

---

# 13.12 Screen 98 — Data & Backup

Sections:

### Backup

- Export Backup.
- Import Backup.

### Reports

- Export Study History.
- Export Progress.

### Storage

- Database size.
- Backup size.

### Reset

- Reset Progress.
- Delete All Data.

---

# 13.13 Screen 99 — Export Backup

## Header

**Export Backup**

Options:

- Standard backup.
- Password-protected backup.

Show:

- Estimated size.
- Included data.

Primary:

**Export**

---

# 13.14 Screen 100 — Import Backup

## Header

**Import Backup**

Explain:

`Your current data will not be changed until the backup is validated.`

Primary:

**Choose Backup File**

---

# 13.15 Screen 101 — Backup Validation

Show progress:

- Reading file.
- Checking version.
- Checking integrity.
- Validating study data.

Success summary:

- Study plans.
- Subjects.
- Study sessions.
- Backup date.

Primary:

**Continue**

---

# 13.16 Screen 102 — Restore Confirmation

Warning:

**Restore this backup?**

Explain:

`Your current Pocket Tutor data will be replaced.`

Show backup date and summary.

Primary destructive:

**Restore Backup**

Secondary:

**Cancel**

---

# 13.17 Screen 103 — Restore Complete

Success:

**Backup restored successfully**

Show:

- Study plans restored.
- Study sessions restored.

Primary:

**Go to Today**

---

# 13.18 Screen 104 — Export Reports

Options:

- Study Plan PDF.
- Progress Report PDF.
- Study History CSV.
- Syllabus CSV.

Advanced feature.

---

# 13.19 Screen 105 — Storage Management

Show:

- App data.
- Backup files.
- Export files.

Actions:

- Manage exported files.
- Clear temporary files.

Do not provide destructive database cleanup without explanation.

---

# 13.20 Screen 106 — Privacy

Explain clearly:

- Core data stays on device.
- No account required.
- No backend needed.
- Backups only leave device when user exports them.
- Optional future online features require explicit consent.

---

# 13.21 Screen 107 — About

Show:

- App name.
- Version.
- Build.
- Product description.
- Privacy.
- Licenses.
- Feedback link if available.

---

# 14. I. Common UI States

# 14.1 Screen 108 — Initial Loading

Use:

- App logo or lightweight shell.
- Short progress indicator.

Avoid indefinite spinner.

---

# 14.2 Screen 109 — Skeleton Loading

Use skeletons for:

- Today task cards.
- Subject list.
- Progress cards.

Since data is local, skeleton should rarely last long.

---

# 14.3 Screen 110 — Empty Today

Message:

**আজকের কোনো পড়া বাকি নেই।**

Secondary:

`Tomorrow's plan is ready.`

Actions:

- View Tomorrow.
- Quick Study.

---

# 14.4 Screen 111 — Empty Subject List

Icon:

Book.

Title:

**No subjects yet**

Text:

`Add your first subject to start building your study plan.`

Primary:

**Add Subject**

---

# 14.5 Screen 112 — Empty Chapter List

Title:

**No chapters yet**

Text:

`Add chapters to estimate your syllabus and create a plan.`

Actions:

- Add Chapter.
- Bulk Add.

---

# 14.6 Screen 113 — No Search Results

Show query.

Example:

`No results for "Vector".`

Actions:

- Clear Filters.
- Try Another Search.

---

# 14.7 Screen 114 — Save in Progress

Inline progress whenever possible.

Disable duplicate submit.

Message:

**Saving...**

---

# 14.8 Screen 115 — Save Success

Use subtle snackbar/banner.

Example:

**Changes saved**

Do not interrupt with modal.

---

# 14.9 Screen 116 — Save Failed

Message:

**We couldn't save these changes.**

Actions:

- Retry.
- Cancel.

Preserve entered data.

---

# 14.10 Screen 117 — Delete Confirmation

Dynamic warning.

Example:

**Delete Physics?**

This will remove:

- 12 chapters.
- 34 future tasks.

If study history will also be deleted, say so explicitly.

Actions:

- Cancel.
- Delete.

---

# 14.11 Screen 118 — Delete Failed

Message:

**Couldn't delete this item.**

Action:

**Retry**

---

# 14.12 Screen 119 — Unsaved Changes

Dialog:

**Discard your changes?**

Actions:

- Keep Editing.
- Discard.

---

# 14.13 Screen 120 — Permission Denied

Generic reusable state.

Explain:

- What permission.
- Why it is useful.
- How to enable.

Actions:

- Open Settings.
- Not Now.

---

# 14.14 Screen 121 — Notification Denied

Message:

**Notifications are turned off**

Text:

`Your study plan still works normally. You just won't receive reminders.`

Actions:

- Open Settings.
- Continue Without Notifications.

---

# 14.15 Screen 122 — Planner Generating

Header:

**Creating your study plan...**

Steps:

- Checking syllabus.
- Calculating available time.
- Balancing subjects.
- Adding revision.

Use subtle animated progress.

---

# 14.16 Screen 123 — Planner Failed

Message:

**We couldn't create a valid plan.**

Reasons may include:

- No study availability.
- Missing exam/target date.
- Invalid chapter estimates.

Actions:

- Review Setup.
- Retry.

---

# 14.17 Screen 124 — Database Migration

Show only when migration takes noticeable time.

Message:

**Updating Pocket Tutor**

Text:

`Your study data is being prepared for this version.`

Do not offer cancel.

---

# 14.18 Screen 125 — Backup Failed

Message:

**Backup couldn't be created.**

Actions:

- Retry.
- Choose Another Location.

---

# 14.19 Screen 126 — Restore Failed

Message:

**Restore couldn't be completed.**

Text:

`Your current data has not been changed.`

Actions:

- Retry.
- Choose Another Backup.

---

# 14.20 Screen 127 — Corrupt Backup

Title:

**This backup can't be opened**

Possible reasons:

- File is damaged.
- Wrong password.
- Unsupported version.

Actions:

- Choose Another File.
- Try Password Again.

---

# 14.21 Screen 128 — Storage Nearly Full

Title:

**Your device is running low on storage**

Text:

`Pocket Tutor may not be able to create backups until storage is freed.`

Actions:

- Manage Storage.
- Later.

---

# 15. Common Components

# 15.1 Screen 129 — Date Picker

Requirements:

- Localized month/day names.
- Highlight exam dates where relevant.
- Prevent invalid past date when creating future exam.
- Allow quick Today action.

---

# 15.2 Screen 130 — Duration Picker

Preset chips:

- 15 min.
- 30 min.
- 45 min.
- 60 min.
- 90 min.

Custom:

Hours + minutes.

---

# 15.3 Screen 131 — Confidence Selector

Five-level visual selector:

1. Very Low.
2. Low.
3. Medium.
4. High.
5. Very High.

Use text + icon.

Do not rely only on color.

---

# 15.4 Screen 132 — Difficulty Selector

Five levels:

- Very Easy.
- Easy.
- Moderate.
- Difficult.
- Very Difficult.

May use segmented buttons or list.

---

# 15.5 Screen 133 — Priority Selector

Options:

- Low.
- Normal.
- High.
- Critical.

Critical should be used sparingly.

---

# 15.6 Screen 134 — Subject Selector

Searchable bottom sheet.

Each row:

- Color.
- Subject.
- Progress.

Support recent subjects at top.

---

# 15.7 Screen 135 — Chapter Selector

Searchable bottom sheet.

Grouped by subject.

Each row:

- Chapter number.
- Title.
- Progress.

---

# 15.8 Screen 136 — Search & Filter Sheet

Components:

- Search field.
- Filter chips.
- Sort.
- Reset.

Bottom actions:

- Clear.
- Apply.

---

# 15.9 Screen 137 — Confirmation Bottom Sheet

Reusable for lightweight confirmations.

Structure:

- Icon.
- Title.
- One-sentence explanation.
- Primary action.
- Secondary action.

Avoid full-screen dialogs unless necessary.

---

# 16. Empty State Copy Examples

## Today

**আজকের সব পড়া শেষ।**

`চাইলে আগামীকালের পরিকল্পনা দেখতে পারেন।`

## Subjects

**এখনও কোনো বিষয় যোগ করা হয়নি।**

`প্রথম বিষয় যোগ করলে Pocket Tutor আপনার পড়ার পরিকল্পনা তৈরি করতে পারবে।`

## Chapters

**এখনও কোনো অধ্যায় যোগ করা হয়নি।**

`অধ্যায় যোগ করুন বা একসাথে একাধিক অধ্যায় লিখে দিন।`

## Revision

**আজ কোনো পুনরাবৃত্তি বাকি নেই।**

## Backlog

**কোনো বাকি পড়া নেই।**

`আপনি সময়সূচি অনুযায়ী এগোচ্ছেন।`

---

# 17. Important Interaction Rules

## 17.1 Completing a Task

Maximum interaction:

1. Tap Complete.
2. Optional confidence.
3. Save.

Do not force timer or notes.

---

## 17.2 Starting a Task

Should take one tap from Today unless user enabled confirmation.

---

## 17.3 Editing Generated Tasks

Clearly mark auto-generated tasks.

Show if editing may affect planning.

---

## 17.4 Automatic Replanning

Never silently move:

- Locked tasks.
- Manual protected tasks.

Major replan must show preview.

---

## 17.5 Back Navigation

Forms with changes:

Show unsaved changes prompt.

Simple read-only screens:

Return immediately.

---

# 18. Accessibility Requirements

All screens must support:

- Dynamic text.
- Large fonts.
- TalkBack.
- VoiceOver.
- High contrast.
- Minimum touch target size.
- Semantic labels.
- Reduced motion where practical.

Status must include text.

Example:

Not just green dot.

Use:

`✓ On Track`

---

# 19. Bangla Localization Guidelines

## 19.1 Keep Terms Consistent

Recommended:

- Today → আজ
- Plan → পরিকল্পনা
- Syllabus → সিলেবাস
- Progress → অগ্রগতি
- Subject → বিষয়
- Chapter → অধ্যায়
- Topic → বিষয়বস্তু / টপিক depending context
- Revision → পুনরাবৃত্তি
- Backlog → বাকি পড়া
- Confidence → আত্মবিশ্বাস
- Difficulty → কঠিনতার মাত্রা

---

## 19.2 Avoid Literal Translation Where Awkward

Prefer natural app language.

Example:

Instead of overly formal language:

`অধ্যয়ন কার্য সম্পাদন করুন`

Use:

`পড়া শুরু করুন`

---

# 20. Responsive Layout Rules

Pocket Tutor is mobile-first.

Support:

- Small Android phones.
- Standard phones.
- Large phones.
- iPhone compact sizes.
- iPhone Max sizes.

Rules:

- Avoid fixed-height forms.
- Use scrolling.
- Ensure bottom buttons remain accessible above keyboard.
- Charts should adapt to width.
- Long Bangla text must wrap safely.

Tablet layout can remain single-column in MVP.

---

# 21. Dark Mode

All screens must support:

- Light.
- Dark.
- System.

Ensure:

- Subject colors remain distinguishable.
- Warning/success contrast remains accessible.
- Charts work in both modes.
- Skeletons do not become overly bright.

---

# 22. Suggested Bottom Navigation Behavior

## Today

Default landing tab.

## Plan

Retain last view:

- Day.
- Week.
- Calendar.

## Syllabus

Retain last subject/filter.

## Progress

Retain selected time range.

## More

Standard settings navigation.

---

# 23. UX Priority by Release

## MVP Required Screens

Must be complete before release:

- 1–13 Onboarding.
- 14–26 Today and execution.
- 27–41 Plan.
- 42–51 Syllabus core.
- 57–62 Exams core.
- 66–73 Revision/backlog.
- 74–83 Progress core.
- 87–103 Settings/backup.
- 108–137 Common states/components.

## Phase 2

Can follow later:

- Topic screens.
- Monthly summary.
- Advanced analytics.
- Export reports.
- Advanced search.
- What-if planning.
- Academic templates.

## Phase 3

Later:

- Multi-plan advanced workflows.
- Cloud backup.
- Widgets.
- AI-assisted syllabus parsing.
- Cross-device sync.

---

# 24. Core Daily UX Flow

The ideal daily user experience should be:

```text
Open Pocket Tutor
↓
See today's study immediately
↓
Tap Start
↓
Study
↓
Finish
↓
Record result
↓
Progress updates
↓
Remaining plan adjusts if needed
```

This flow must remain faster and simpler than manually planning study in a notebook.

---

# 25. Core Planning UX Flow

```text
Add subject
↓
Add chapters
↓
Set exam
↓
Set available study time
↓
Generate plan
↓
Review summary
↓
Use plan
```

The user should never need to understand the internal scheduling algorithm.

---

# 26. Core Recovery UX Flow

```text
Miss study task
↓
Pocket Tutor detects backlog
↓
Shows impact
↓
Suggests catch-up
↓
User applies or adjusts
↓
Future plan updates safely
```

Avoid punishment language.

Use:

- "Behind schedule"
- "Catch-up plan"
- "Recovery"

Avoid:

- "Failed"
- "Bad performance"
- "You broke your streak"

---

# 27. Final UX Recommendation

Pocket Tutor should feel like a quiet study coordinator rather than a complex productivity system.

The strongest screens should be:

1. Today Dashboard.
2. Initial Plan Preview.
3. Study Session.
4. Syllabus Dashboard.
5. Backlog Dashboard.
6. Revision Queue.
7. Progress Dashboard.
8. Exam Details.

The entire UX should reinforce one promise:

> **Open the app, know what to study, finish it, and stay on track for your exam.**
