// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Porar Sathi';

  @override
  String get appNameBangla => 'পড়ার সাথী';

  @override
  String get splashTagline => 'Plan today. Finish on time.';

  @override
  String get loadingStudySpace => 'Loading your study space...';

  @override
  String get offlineStudyPlanner => 'Offline Study Planner';

  @override
  String get navToday => 'Today';

  @override
  String get navPlan => 'Plan';

  @override
  String get navSyllabus => 'Syllabus';

  @override
  String get navProgress => 'Progress';

  @override
  String get navMore => 'More';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionSkip => 'Skip';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionDone => 'Done';

  @override
  String get actionBack => 'Back';

  @override
  String get actionGetStarted => 'Get Started';

  @override
  String get actionNotNow => 'Not Now';

  @override
  String get stateLoading => 'Loading...';

  @override
  String get stateSaving => 'Saving...';

  @override
  String get stateCreatingPlan => 'Creating your study plan...';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorSaveFailed => 'We couldn\'t save these changes.';

  @override
  String get errorSessionDuration =>
      'Session length must be between 1 and 240 minutes.';

  @override
  String get errorPlanningBuffer =>
      'Planning buffer must be between 0 and 50 percent.';

  @override
  String get errorCompletionPercent =>
      'Completion must be between 0 and 100 percent.';

  @override
  String get errorAvailability =>
      'Available time must be between 0 and 24 hours.';

  @override
  String get errorExamDate => 'Exam date cannot be in the past.';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get chooseLanguageSubtitle =>
      'You can change this anytime from Settings.';

  @override
  String get banglaTitle => 'বাংলা';

  @override
  String get banglaSubtitle => 'Use Porar Sathi in Bangla';

  @override
  String get englishTitle => 'English';

  @override
  String get englishSubtitle => 'Use Porar Sathi in English';

  @override
  String get welcomeTitle => 'Plan less. Study better.';

  @override
  String get welcomeBody =>
      'Add your subjects and syllabus, tell Porar Sathi when you can study, and get a realistic daily plan.';

  @override
  String get subjectsTitle => 'Subjects';

  @override
  String get addSubject => 'Add Subject';

  @override
  String get noSubjectsTitle => 'No subjects yet';

  @override
  String get noSubjectsBody =>
      'Add your first subject to start building your study plan.';

  @override
  String get subjectName => 'Subject name';

  @override
  String get chaptersTitle => 'Chapters';

  @override
  String get addChapter => 'Add Chapter';

  @override
  String get noChaptersTitle => 'No chapters yet';

  @override
  String get noChaptersBody =>
      'Add chapters to estimate your syllabus and create a plan.';

  @override
  String get examsTitle => 'Exams';

  @override
  String get addExam => 'Add Exam';

  @override
  String get examDate => 'Exam date';

  @override
  String daysRemaining(int count) {
    return '$count days remaining';
  }

  @override
  String get studyPlan => 'Study Plan';

  @override
  String get generatePlan => 'Generate My Plan';

  @override
  String get onTrack => 'On Track';

  @override
  String get backlog => 'Backlog';

  @override
  String get revision => 'Revision';

  @override
  String get todayStudy => 'Today\'s Study';

  @override
  String get whyThisTask => 'Why this task?';

  @override
  String get todayEmptyTitle => 'No study tasks for today';

  @override
  String get todayEmptyBody =>
      'Your daily plan will show up here after you add a syllabus and an exam.';

  @override
  String get planEmptyBody =>
      'Your week, day, and calendar will show the generated plan.';

  @override
  String get progressEmptyBody =>
      'Syllabus progress, study time, and readiness will show here.';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get goodNight => 'Good night';

  @override
  String get moreTitle => 'More';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get languageTitle => 'Language';

  @override
  String get studySettingsTitle => 'Study Settings';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get firstDayOfWeek => 'First day of week';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get monday => 'Monday';

  @override
  String get defaultSession => 'Default session length';

  @override
  String get planningBuffer => 'Planning buffer';

  @override
  String get planningBufferHelp =>
      'Leave a little free time so the plan stays realistic.';

  @override
  String get autoReplan => 'Auto replan';

  @override
  String get autoReplanHelp =>
      'Small schedule updates can apply on their own. Big changes still ask you first.';

  @override
  String get settingsSaved => 'Changes saved';

  @override
  String durationMinutes(int count) {
    return '$count min';
  }

  @override
  String durationHours(int count) {
    return '${count}h';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String bufferPercent(int count) {
    return '$count%';
  }

  @override
  String onboardingProgress(int current, int total) {
    return '$current of $total';
  }

  @override
  String get welcomeHeadline => 'Know exactly what to study every day';

  @override
  String get welcomeBenefitPlanTitle => 'Daily study plan';

  @override
  String get welcomeBenefitPlanBody =>
      'Add your syllabus, exam dates and available study time. Porar Sathi turns them into a realistic daily plan.';

  @override
  String get welcomeBenefitSyllabusTitle => 'Track your syllabus';

  @override
  String get welcomeBenefitSyllabusBody =>
      'Know how much is done and what\'s left.';

  @override
  String get welcomeBenefitTrackTitle => 'Stay on track';

  @override
  String get welcomeBenefitTrackBody =>
      'Miss a day? Porar Sathi adjusts the plan.';

  @override
  String get actionSetUpPlan => 'Set Up My Study Plan';

  @override
  String get studyTypeTitle => 'What are you preparing for?';

  @override
  String get studyTypeSubtitle =>
      'We\'ll tailor the setup to your study style.';

  @override
  String get studyTypeSsc => 'SSC';

  @override
  String get studyTypeSscBody => 'Secondary School Certificate';

  @override
  String get studyTypeHsc => 'HSC';

  @override
  String get studyTypeHscBody => 'Higher Secondary Certificate';

  @override
  String get studyTypeUniversity => 'University';

  @override
  String get studyTypeUniversityBody => 'Semester, midterm or final';

  @override
  String get studyTypeAdmission => 'Admission Test';

  @override
  String get studyTypeAdmissionBody => 'University, medical, engineering';

  @override
  String get studyTypeDiploma => 'Diploma / Polytechnic';

  @override
  String get studyTypeDiplomaBody => 'Polytechnic courses';

  @override
  String get studyTypeOther => 'Other';

  @override
  String get studyTypeOtherBody => 'Custom setup';

  @override
  String get studyTypeFootnote => 'You can change this later.';

  @override
  String get profileTitle => 'A little about you';

  @override
  String get profileSubtitle =>
      'This helps personalize your study plan. No account is required.';

  @override
  String get profileName => 'What should we call you?';

  @override
  String get optionalHint => 'Optional';

  @override
  String get profileYear => 'Academic session (optional)';

  @override
  String get profileInstitution => 'Your institution (optional)';

  @override
  String get profilePrivacy => 'Stored only on this device.';

  @override
  String get actionSkipForNow => 'Skip for now';

  @override
  String get skippedStudentName => 'Student';

  @override
  String get planTitle => 'Create your first study plan';

  @override
  String get planSubtitle =>
      'Give this plan a name so it\'s easy to recognize later.';

  @override
  String get planName => 'Plan name';

  @override
  String get planType => 'Study goal';

  @override
  String get planStart => 'Plan start date';

  @override
  String get planEnd => 'Target end date';

  @override
  String get planTypeBoard => 'Board Exam';

  @override
  String get planTypeSemester => 'Semester';

  @override
  String get planTypeAdmission => 'Admission';

  @override
  String get planTypeCustom => 'Custom';

  @override
  String get examTitle => 'When is your exam?';

  @override
  String get examSubtitle =>
      'Porar Sathi uses the exam date to decide how much you need to study each day.';

  @override
  String get examName => 'Exam name';

  @override
  String get examType => 'Exam type';

  @override
  String get examEnd => 'End date';

  @override
  String get examImportance => 'Importance';

  @override
  String get importanceNormal => 'Normal';

  @override
  String get importanceImportant => 'Important';

  @override
  String get importanceVeryImportant => 'Very Important';

  @override
  String get actionAddAnotherExam => 'Add another exam';

  @override
  String get examNoDate => 'I don\'t have the exam date yet';

  @override
  String daysFromToday(int count) {
    return '$count days from today';
  }

  @override
  String get examTypeBoard => 'Board';

  @override
  String get examTypeMidterm => 'Midterm';

  @override
  String get examTypeFinal => 'Final';

  @override
  String get examTypeAdmission => 'Admission';

  @override
  String get examTypeCustom => 'Custom';

  @override
  String get availabilityTitle => 'How much time can you study each day?';

  @override
  String get availabilitySubtitle =>
      'Choose realistic study time. Your plan will leave some buffer instead of filling every minute.';

  @override
  String get preset1h => '1 hr/day';

  @override
  String get preset2h => '2 hr/day';

  @override
  String get preset3h => '3 hr/day';

  @override
  String get presetCustom => 'Custom';

  @override
  String get weeklyStudyTime => 'Weekly study time';

  @override
  String averagePerStudyDay(String duration) {
    return 'Average $duration per study day';
  }

  @override
  String get offDay => 'Off';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get studyTimeTitle => 'When do you prefer to study?';

  @override
  String get studyTimeSubtitle =>
      'This is optional. Your plan will still work if your daily timing changes.';

  @override
  String get periodMorning => 'Morning';

  @override
  String get periodMorningTime => '6 AM – 10 AM';

  @override
  String get periodAfternoon => 'Afternoon';

  @override
  String get periodAfternoonTime => '12 PM – 4 PM';

  @override
  String get periodEvening => 'Evening';

  @override
  String get periodEveningTime => '5 PM – 9 PM';

  @override
  String get periodNight => 'Night';

  @override
  String get periodNightTime => '9 PM – 12 AM';

  @override
  String get preferencesTitle => 'How should Porar Sathi build your plan?';

  @override
  String get planningMode => 'Planning style';

  @override
  String get modeBalanced => 'Balanced';

  @override
  String get modeBalancedBody =>
      'Spread daily time across subjects while respecting your urgency.';

  @override
  String get modeWeak => 'Weak Subject Focus';

  @override
  String get modeWeakBody =>
      'Give extra attention to difficult topics and low-confidence subjects.';

  @override
  String get modeLight => 'Light';

  @override
  String get modeLightBody =>
      'Keep daily workload lighter and more sustainable.';

  @override
  String get modeCrunch => 'Exam Crunch';

  @override
  String get modeCrunchBody => 'Prioritize urgent exam work and revision.';

  @override
  String get studyIntensity => 'Study intensity';

  @override
  String get intensityLight => 'Light';

  @override
  String get intensityNormal => 'Normal';

  @override
  String get intensityFocused => 'Focused';

  @override
  String get maxSession => 'Maximum study session';

  @override
  String get revisionBuffer => 'Revision buffer';

  @override
  String revisionDays(int count) {
    return '$count days';
  }

  @override
  String get actionCreatePlan => 'Generate My Plan';

  @override
  String get summaryTitle => 'Your study plan is ready';

  @override
  String get summaryFinish => 'Expected syllabus finish';

  @override
  String get summaryFinishPending => 'Add chapters to forecast a finish date.';

  @override
  String get summaryExam => 'Exam';

  @override
  String get summaryNoExam => 'No exam date yet';

  @override
  String get summaryRevisionBuffer => 'Revision buffer';

  @override
  String get firstDays => 'Your first few days';

  @override
  String get summaryNoTasks =>
      'Daily tasks appear after you add subjects and chapters.';

  @override
  String get actionUsePlan => 'Use This Plan';

  @override
  String get actionAdjustAvailability => 'Adjust Availability';

  @override
  String get notificationsTitle => 'Stay on track with gentle reminders';

  @override
  String get notificationsBody =>
      'Porar Sathi can remind you about today\'s plan, revision, and upcoming exams.';

  @override
  String get actionEnableReminders => 'Enable Reminders';

  @override
  String get completeTitle => 'You\'re ready to study';

  @override
  String get completeBody =>
      'Your first plan is ready. Porar Sathi will adjust it as your progress changes.';

  @override
  String get actionSeeToday => 'See Today\'s Study';

  @override
  String get completeNoTasks =>
      'Add subjects and chapters to fill today\'s plan.';

  @override
  String get subjectCode => 'Subject code';

  @override
  String get paperName => 'Paper';

  @override
  String get priority => 'Priority';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityCritical => 'Critical';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyModerate => 'Moderate';

  @override
  String get difficultyHard => 'Difficult';

  @override
  String get confidence => 'Confidence';

  @override
  String get confidenceLow => 'Low';

  @override
  String get confidenceMedium => 'Medium';

  @override
  String get confidenceHigh => 'High';

  @override
  String get color => 'Color';

  @override
  String get icon => 'Icon';

  @override
  String get archiveSubject => 'Archive subject';

  @override
  String get deleteSubject => 'Delete subject';

  @override
  String deleteSubjectTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get deleteSubjectBody => 'This removes its chapters and future tasks.';

  @override
  String get deleteHistoryBody =>
      'Study history exists. Delete that history too?';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionDeleteHistory => 'Delete history';

  @override
  String get editSubject => 'Edit subject';

  @override
  String chaptersProgress(int done, int total) {
    return '$done of $total chapters';
  }

  @override
  String get syllabusCompleted => 'Syllabus completed';

  @override
  String get chapterTitleLabel => 'Chapter title';

  @override
  String get chapterNumber => 'Chapter number';

  @override
  String get estimatedTime => 'Estimated study time';

  @override
  String get chapterStatus => 'Status';

  @override
  String get notes => 'Notes';

  @override
  String get editChapter => 'Edit chapter';

  @override
  String get bulkAddChapters => 'Add multiple chapters';

  @override
  String get bulkPlaceholder => 'Enter one chapter per line';

  @override
  String createChapters(int count) {
    return 'Create $count chapters';
  }

  @override
  String get filterAll => 'All';

  @override
  String get completed => 'Completed';

  @override
  String get inProgress => 'In progress';

  @override
  String get notStarted => 'Not started';

  @override
  String get revisionDue => 'Revision due';

  @override
  String get skipped => 'Skipped';

  @override
  String get editExam => 'Edit exam';

  @override
  String get examDateChangeWarning => 'Your study plan may need to be updated.';

  @override
  String get upcomingExams => 'Upcoming';

  @override
  String get completedExams => 'Completed';

  @override
  String get noExamsTitle => 'No exams yet';

  @override
  String get noExamsBody =>
      'Add an exam date so the plan knows what you\'re preparing for.';

  @override
  String get linkSyllabus => 'Map syllabus';

  @override
  String get syllabusMappingTitle => 'What\'s included in this exam?';

  @override
  String get availabilityEdit => 'Weekly availability';

  @override
  String get addException => 'Add exception';

  @override
  String get exceptionsTitle => 'Calendar exceptions';

  @override
  String get exceptionDate => 'Date';

  @override
  String get exceptionReason => 'Reason';

  @override
  String get exceptionMinutes => 'Available minutes';

  @override
  String get exceptionType => 'Type';

  @override
  String get noStudyDay => 'No study day';

  @override
  String get reducedAvailability => 'Reduced availability';

  @override
  String get extraStudyDay => 'Extra study day';

  @override
  String get saveOverride => 'Save override';

  @override
  String get todayCapacity => 'Today\'s study time';

  @override
  String get schedulableCapacity => 'Time the planner can schedule';

  @override
  String get capacityBuffer => 'Planning buffer';

  @override
  String get noExceptions => 'No calendar exceptions yet.';

  @override
  String exceptionSaved(String duration) {
    return 'Saved. The planner can schedule $duration that day.';
  }

  @override
  String get averageDailyStudy => 'Average daily study';

  @override
  String tasksGenerated(int count) {
    return '$count tasks';
  }

  @override
  String get paceAhead => 'Ahead';

  @override
  String get paceOnTrack => 'On Track';

  @override
  String get paceSlightlyBehind => 'Slightly Behind';

  @override
  String get paceBehind => 'Behind';

  @override
  String get paceAtRisk => 'At Risk';

  @override
  String get riskLabel => 'Risk';

  @override
  String get riskNone => 'None';

  @override
  String get riskLow => 'Low';

  @override
  String get riskMedium => 'Tight';

  @override
  String get riskHigh => 'High';

  @override
  String get riskImpossible => 'Impossible';

  @override
  String planShortfall(
    String requiredTime,
    String availableTime,
    String shortfallTime,
  ) {
    return 'Required $requiredTime, available $availableTime, shortfall $shortfallTime.';
  }

  @override
  String get subjectAllocation => 'Subject allocation';

  @override
  String get suggestionIncreaseAvailability => 'Add more study time';

  @override
  String get suggestionIncreaseIntensity => 'Increase daily intensity';

  @override
  String get suggestionReduceBuffer => 'Reduce the revision buffer';

  @override
  String get suggestionPrioritize => 'Mark lower-priority chapters optional';

  @override
  String get suggestionEstimates => 'Change estimated duration';

  @override
  String get suggestionExamDate => 'Change the exam date';

  @override
  String get todayTarget => 'Today\'s target';

  @override
  String tasksDone(int done, int total) {
    return '$done of $total tasks done';
  }

  @override
  String syllabusProgress(int percent) {
    return 'Syllabus $percent%';
  }

  @override
  String revisionDueCount(int count) {
    return '$count revisions due';
  }

  @override
  String get actionReview => 'Review';

  @override
  String backlogBehind(String duration) {
    return '$duration behind schedule';
  }

  @override
  String get actionViewBacklog => 'View backlog';

  @override
  String get actionQuickStudy => 'Quick Study';

  @override
  String get todayAllDone => 'Today\'s study is done.';

  @override
  String get tomorrowReady => 'Tomorrow\'s plan is ready.';

  @override
  String get actionViewTomorrow => 'View tomorrow';

  @override
  String get actionStart => 'Start';

  @override
  String get actionStartTimer => 'Start Timer';

  @override
  String get actionStudyWithoutTimer => 'Study Without Timer';

  @override
  String get actionComplete => 'Mark Complete';

  @override
  String get actionPartial => 'Partial';

  @override
  String get actionMove => 'Move';

  @override
  String get actionPause => 'Pause';

  @override
  String get actionResume => 'Resume';

  @override
  String get actionFinish => 'Finish';

  @override
  String get actionFinishNow => 'Finish Now';

  @override
  String get sessionPaused => 'Session paused';

  @override
  String plannedLabel(String duration) {
    return 'Planned: $duration';
  }

  @override
  String get finishTitle => 'How did this session go?';

  @override
  String get resultFully => 'Fully completed';

  @override
  String get resultMostly => 'Mostly completed';

  @override
  String get resultPartial => 'Partially completed';

  @override
  String get resultCouldNot => 'Could not study';

  @override
  String get actualTime => 'Actual time';

  @override
  String get confidenceNow => 'How confident do you feel now?';

  @override
  String get wantRevision => 'I want to revise this later';

  @override
  String get actionSaveSession => 'Save Session';

  @override
  String get partialTitle => 'How much did you finish?';

  @override
  String aboutRemain(String duration) {
    return 'About $duration remain.';
  }

  @override
  String get actionSaveReplan => 'Save & Replan Remaining';

  @override
  String get actionSaveWithoutReplan => 'Save Without Replanning';

  @override
  String get skipTitle => 'Skip this task?';

  @override
  String get skipToday => 'Skip only today';

  @override
  String get skipRemove => 'Remove from plan';

  @override
  String get skipReschedule => 'Reschedule automatically';

  @override
  String get moveTitle => 'Move study task';

  @override
  String capacityFree(String duration) {
    return '$duration free';
  }

  @override
  String get capacityTight => 'This day is shorter than the task.';

  @override
  String get highPriority => 'High priority';

  @override
  String get confidenceLowReason => 'Confidence is low';

  @override
  String get highPriorityChapter => 'High-priority chapter';

  @override
  String get quickStudyTitle => 'Quick Study';

  @override
  String get actionLogCompleted => 'Log Completed Study';

  @override
  String get resumeSession => 'Resume study';

  @override
  String get taskPlanned => 'Planned';

  @override
  String get taskMissed => 'Missed';

  @override
  String get taskNewStudy => 'New study';

  @override
  String get taskContinue => 'Continue';

  @override
  String get taskRevision => 'Revision';

  @override
  String get taskPractice => 'Practice';

  @override
  String get revisionQueue => 'Revision';

  @override
  String get dueToday => 'Due Today';

  @override
  String get overdue => 'Overdue';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get revisionEmpty => 'No revisions in this list.';

  @override
  String get actionStartRevision => 'Start Revision';

  @override
  String lastStudied(String date) {
    return 'Last studied $date';
  }

  @override
  String previousRevisions(int count) {
    return '$count previous revisions';
  }

  @override
  String get actionReschedule => 'Reschedule';

  @override
  String get revisionCompleteTitle => 'Revision complete';

  @override
  String get needAnotherRevision => 'Need another revision?';

  @override
  String nextRevision(String date) {
    return 'Next revision: $date';
  }

  @override
  String get backlogTitle => 'Backlog';

  @override
  String overdueTasks(int count) {
    return '$count overdue tasks';
  }

  @override
  String get oldestMissed => 'Oldest missed task';

  @override
  String recoveryEstimate(int days) {
    return 'You can recover this backlog in $days days.';
  }

  @override
  String get actionBuildCatchUp => 'Build Catch-Up Plan';

  @override
  String get catchUpTitle => 'Catch-up plan';

  @override
  String get extraStudy => 'Suggested extra study';

  @override
  String get actionApply => 'Apply';

  @override
  String get catchUpAdded => 'Catch-up plan added';

  @override
  String get actionViewUpdatedPlan => 'View updated plan';

  @override
  String get replanTitle => 'Your plan needs an update';

  @override
  String replanMoved(int count) {
    return '$count tasks moved';
  }

  @override
  String replanAdded(int count) {
    return '$count tasks added';
  }

  @override
  String replanRemoved(int count) {
    return '$count tasks removed';
  }

  @override
  String get finishChange => 'Expected finish changed';

  @override
  String get actionApplyChanges => 'Apply Changes';

  @override
  String get actionKeepPlan => 'Keep Current Plan';

  @override
  String get planUpdated => 'Study plan updated';

  @override
  String get actionViewToday => 'View Today';

  @override
  String get actionUpdatePlan => 'Update plan';

  @override
  String get planNeedsUpdate => 'Your plan needs an update';

  @override
  String daysOverdue(int count) {
    return '$count days overdue';
  }

  @override
  String get actionStudyNow => 'Study Now';

  @override
  String get actionRemove => 'Remove';

  @override
  String get noBacklog => 'No missed study is waiting.';
}
