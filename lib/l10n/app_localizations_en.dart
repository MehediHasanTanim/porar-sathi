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
}
