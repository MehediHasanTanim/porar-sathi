import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Porar Sathi'**
  String get appName;

  /// No description provided for @appNameBangla.
  ///
  /// In en, this message translates to:
  /// **'পড়ার সাথী'**
  String get appNameBangla;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Plan today. Finish on time.'**
  String get splashTagline;

  /// No description provided for @loadingStudySpace.
  ///
  /// In en, this message translates to:
  /// **'Loading your study space...'**
  String get loadingStudySpace;

  /// No description provided for @offlineStudyPlanner.
  ///
  /// In en, this message translates to:
  /// **'Offline Study Planner'**
  String get offlineStudyPlanner;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get navPlan;

  /// No description provided for @navSyllabus.
  ///
  /// In en, this message translates to:
  /// **'Syllabus'**
  String get navSyllabus;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get actionGetStarted;

  /// No description provided for @actionNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get actionNotNow;

  /// No description provided for @stateLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get stateLoading;

  /// No description provided for @stateSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get stateSaving;

  /// No description provided for @stateCreatingPlan.
  ///
  /// In en, this message translates to:
  /// **'Creating your study plan...'**
  String get stateCreatingPlan;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t save these changes.'**
  String get errorSaveFailed;

  /// No description provided for @errorSessionDuration.
  ///
  /// In en, this message translates to:
  /// **'Session length must be between 1 and 240 minutes.'**
  String get errorSessionDuration;

  /// No description provided for @errorPlanningBuffer.
  ///
  /// In en, this message translates to:
  /// **'Planning buffer must be between 0 and 50 percent.'**
  String get errorPlanningBuffer;

  /// No description provided for @errorCompletionPercent.
  ///
  /// In en, this message translates to:
  /// **'Completion must be between 0 and 100 percent.'**
  String get errorCompletionPercent;

  /// No description provided for @errorAvailability.
  ///
  /// In en, this message translates to:
  /// **'Available time must be between 0 and 24 hours.'**
  String get errorAvailability;

  /// No description provided for @errorExamDate.
  ///
  /// In en, this message translates to:
  /// **'Exam date cannot be in the past.'**
  String get errorExamDate;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @chooseLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime from Settings.'**
  String get chooseLanguageSubtitle;

  /// No description provided for @banglaTitle.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get banglaTitle;

  /// No description provided for @banglaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use Porar Sathi in Bangla'**
  String get banglaSubtitle;

  /// No description provided for @englishTitle.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishTitle;

  /// No description provided for @englishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use Porar Sathi in English'**
  String get englishSubtitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan less. Study better.'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Add your subjects and syllabus, tell Porar Sathi when you can study, and get a realistic daily plan.'**
  String get welcomeBody;

  /// No description provided for @subjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjectsTitle;

  /// No description provided for @addSubject.
  ///
  /// In en, this message translates to:
  /// **'Add Subject'**
  String get addSubject;

  /// No description provided for @noSubjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'No subjects yet'**
  String get noSubjectsTitle;

  /// No description provided for @noSubjectsBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first subject to start building your study plan.'**
  String get noSubjectsBody;

  /// No description provided for @subjectName.
  ///
  /// In en, this message translates to:
  /// **'Subject name'**
  String get subjectName;

  /// No description provided for @chaptersTitle.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chaptersTitle;

  /// No description provided for @addChapter.
  ///
  /// In en, this message translates to:
  /// **'Add Chapter'**
  String get addChapter;

  /// No description provided for @noChaptersTitle.
  ///
  /// In en, this message translates to:
  /// **'No chapters yet'**
  String get noChaptersTitle;

  /// No description provided for @noChaptersBody.
  ///
  /// In en, this message translates to:
  /// **'Add chapters to estimate your syllabus and create a plan.'**
  String get noChaptersBody;

  /// No description provided for @examsTitle.
  ///
  /// In en, this message translates to:
  /// **'Exams'**
  String get examsTitle;

  /// No description provided for @addExam.
  ///
  /// In en, this message translates to:
  /// **'Add Exam'**
  String get addExam;

  /// No description provided for @examDate.
  ///
  /// In en, this message translates to:
  /// **'Exam date'**
  String get examDate;

  /// No description provided for @daysRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} days remaining'**
  String daysRemaining(int count);

  /// No description provided for @studyPlan.
  ///
  /// In en, this message translates to:
  /// **'Study Plan'**
  String get studyPlan;

  /// No description provided for @generatePlan.
  ///
  /// In en, this message translates to:
  /// **'Generate My Plan'**
  String get generatePlan;

  /// No description provided for @onTrack.
  ///
  /// In en, this message translates to:
  /// **'On Track'**
  String get onTrack;

  /// No description provided for @backlog.
  ///
  /// In en, this message translates to:
  /// **'Backlog'**
  String get backlog;

  /// No description provided for @revision.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get revision;

  /// No description provided for @todayStudy.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Study'**
  String get todayStudy;

  /// No description provided for @whyThisTask.
  ///
  /// In en, this message translates to:
  /// **'Why this task?'**
  String get whyThisTask;

  /// No description provided for @todayEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No study tasks for today'**
  String get todayEmptyTitle;

  /// No description provided for @todayEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Your daily plan will show up here after you add a syllabus and an exam.'**
  String get todayEmptyBody;

  /// No description provided for @planEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Your week, day, and calendar will show the generated plan.'**
  String get planEmptyBody;

  /// No description provided for @progressEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Syllabus progress, study time, and readiness will show here.'**
  String get progressEmptyBody;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good night'**
  String get goodNight;

  /// No description provided for @moreTitle.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreTitle;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @studySettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Study Settings'**
  String get studySettingsTitle;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @firstDayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'First day of week'**
  String get firstDayOfWeek;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @defaultSession.
  ///
  /// In en, this message translates to:
  /// **'Default session length'**
  String get defaultSession;

  /// No description provided for @planningBuffer.
  ///
  /// In en, this message translates to:
  /// **'Planning buffer'**
  String get planningBuffer;

  /// No description provided for @planningBufferHelp.
  ///
  /// In en, this message translates to:
  /// **'Leave a little free time so the plan stays realistic.'**
  String get planningBufferHelp;

  /// No description provided for @autoReplan.
  ///
  /// In en, this message translates to:
  /// **'Auto replan'**
  String get autoReplan;

  /// No description provided for @autoReplanHelp.
  ///
  /// In en, this message translates to:
  /// **'Small schedule updates can apply on their own. Big changes still ask you first.'**
  String get autoReplanHelp;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved'**
  String get settingsSaved;

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String durationMinutes(int count);

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String durationHours(int count);

  /// No description provided for @durationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String durationHoursMinutes(int hours, int minutes);

  /// No description provided for @bufferPercent.
  ///
  /// In en, this message translates to:
  /// **'{count}%'**
  String bufferPercent(int count);

  /// No description provided for @onboardingProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String onboardingProgress(int current, int total);

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Know exactly what to study every day'**
  String get welcomeHeadline;

  /// No description provided for @welcomeBenefitPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily study plan'**
  String get welcomeBenefitPlanTitle;

  /// No description provided for @welcomeBenefitPlanBody.
  ///
  /// In en, this message translates to:
  /// **'Add your syllabus, exam dates and available study time. Porar Sathi turns them into a realistic daily plan.'**
  String get welcomeBenefitPlanBody;

  /// No description provided for @welcomeBenefitSyllabusTitle.
  ///
  /// In en, this message translates to:
  /// **'Track your syllabus'**
  String get welcomeBenefitSyllabusTitle;

  /// No description provided for @welcomeBenefitSyllabusBody.
  ///
  /// In en, this message translates to:
  /// **'Know how much is done and what\'s left.'**
  String get welcomeBenefitSyllabusBody;

  /// No description provided for @welcomeBenefitTrackTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay on track'**
  String get welcomeBenefitTrackTitle;

  /// No description provided for @welcomeBenefitTrackBody.
  ///
  /// In en, this message translates to:
  /// **'Miss a day? Porar Sathi adjusts the plan.'**
  String get welcomeBenefitTrackBody;

  /// No description provided for @actionSetUpPlan.
  ///
  /// In en, this message translates to:
  /// **'Set Up My Study Plan'**
  String get actionSetUpPlan;

  /// No description provided for @studyTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'What are you preparing for?'**
  String get studyTypeTitle;

  /// No description provided for @studyTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll tailor the setup to your study style.'**
  String get studyTypeSubtitle;

  /// No description provided for @studyTypeSsc.
  ///
  /// In en, this message translates to:
  /// **'SSC'**
  String get studyTypeSsc;

  /// No description provided for @studyTypeSscBody.
  ///
  /// In en, this message translates to:
  /// **'Secondary School Certificate'**
  String get studyTypeSscBody;

  /// No description provided for @studyTypeHsc.
  ///
  /// In en, this message translates to:
  /// **'HSC'**
  String get studyTypeHsc;

  /// No description provided for @studyTypeHscBody.
  ///
  /// In en, this message translates to:
  /// **'Higher Secondary Certificate'**
  String get studyTypeHscBody;

  /// No description provided for @studyTypeUniversity.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get studyTypeUniversity;

  /// No description provided for @studyTypeUniversityBody.
  ///
  /// In en, this message translates to:
  /// **'Semester, midterm or final'**
  String get studyTypeUniversityBody;

  /// No description provided for @studyTypeAdmission.
  ///
  /// In en, this message translates to:
  /// **'Admission Test'**
  String get studyTypeAdmission;

  /// No description provided for @studyTypeAdmissionBody.
  ///
  /// In en, this message translates to:
  /// **'University, medical, engineering'**
  String get studyTypeAdmissionBody;

  /// No description provided for @studyTypeDiploma.
  ///
  /// In en, this message translates to:
  /// **'Diploma / Polytechnic'**
  String get studyTypeDiploma;

  /// No description provided for @studyTypeDiplomaBody.
  ///
  /// In en, this message translates to:
  /// **'Polytechnic courses'**
  String get studyTypeDiplomaBody;

  /// No description provided for @studyTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get studyTypeOther;

  /// No description provided for @studyTypeOtherBody.
  ///
  /// In en, this message translates to:
  /// **'Custom setup'**
  String get studyTypeOtherBody;

  /// No description provided for @studyTypeFootnote.
  ///
  /// In en, this message translates to:
  /// **'You can change this later.'**
  String get studyTypeFootnote;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'A little about you'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps personalize your study plan. No account is required.'**
  String get profileSubtitle;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get profileName;

  /// No description provided for @optionalHint.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optionalHint;

  /// No description provided for @profileYear.
  ///
  /// In en, this message translates to:
  /// **'Academic session (optional)'**
  String get profileYear;

  /// No description provided for @profileInstitution.
  ///
  /// In en, this message translates to:
  /// **'Your institution (optional)'**
  String get profileInstitution;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Stored only on this device.'**
  String get profilePrivacy;

  /// No description provided for @actionSkipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get actionSkipForNow;

  /// No description provided for @skippedStudentName.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get skippedStudentName;

  /// No description provided for @planTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your first study plan'**
  String get planTitle;

  /// No description provided for @planSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Give this plan a name so it\'s easy to recognize later.'**
  String get planSubtitle;

  /// No description provided for @planName.
  ///
  /// In en, this message translates to:
  /// **'Plan name'**
  String get planName;

  /// No description provided for @planType.
  ///
  /// In en, this message translates to:
  /// **'Study goal'**
  String get planType;

  /// No description provided for @planStart.
  ///
  /// In en, this message translates to:
  /// **'Plan start date'**
  String get planStart;

  /// No description provided for @planEnd.
  ///
  /// In en, this message translates to:
  /// **'Target end date'**
  String get planEnd;

  /// No description provided for @planTypeBoard.
  ///
  /// In en, this message translates to:
  /// **'Board Exam'**
  String get planTypeBoard;

  /// No description provided for @planTypeSemester.
  ///
  /// In en, this message translates to:
  /// **'Semester'**
  String get planTypeSemester;

  /// No description provided for @planTypeAdmission.
  ///
  /// In en, this message translates to:
  /// **'Admission'**
  String get planTypeAdmission;

  /// No description provided for @planTypeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get planTypeCustom;

  /// No description provided for @examTitle.
  ///
  /// In en, this message translates to:
  /// **'When is your exam?'**
  String get examTitle;

  /// No description provided for @examSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Porar Sathi uses the exam date to decide how much you need to study each day.'**
  String get examSubtitle;

  /// No description provided for @examName.
  ///
  /// In en, this message translates to:
  /// **'Exam name'**
  String get examName;

  /// No description provided for @examType.
  ///
  /// In en, this message translates to:
  /// **'Exam type'**
  String get examType;

  /// No description provided for @examEnd.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get examEnd;

  /// No description provided for @examImportance.
  ///
  /// In en, this message translates to:
  /// **'Importance'**
  String get examImportance;

  /// No description provided for @importanceNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get importanceNormal;

  /// No description provided for @importanceImportant.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get importanceImportant;

  /// No description provided for @importanceVeryImportant.
  ///
  /// In en, this message translates to:
  /// **'Very Important'**
  String get importanceVeryImportant;

  /// No description provided for @actionAddAnotherExam.
  ///
  /// In en, this message translates to:
  /// **'Add another exam'**
  String get actionAddAnotherExam;

  /// No description provided for @examNoDate.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have the exam date yet'**
  String get examNoDate;

  /// No description provided for @daysFromToday.
  ///
  /// In en, this message translates to:
  /// **'{count} days from today'**
  String daysFromToday(int count);

  /// No description provided for @examTypeBoard.
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get examTypeBoard;

  /// No description provided for @examTypeMidterm.
  ///
  /// In en, this message translates to:
  /// **'Midterm'**
  String get examTypeMidterm;

  /// No description provided for @examTypeFinal.
  ///
  /// In en, this message translates to:
  /// **'Final'**
  String get examTypeFinal;

  /// No description provided for @examTypeAdmission.
  ///
  /// In en, this message translates to:
  /// **'Admission'**
  String get examTypeAdmission;

  /// No description provided for @examTypeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get examTypeCustom;

  /// No description provided for @availabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'How much time can you study each day?'**
  String get availabilityTitle;

  /// No description provided for @availabilitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose realistic study time. Your plan will leave some buffer instead of filling every minute.'**
  String get availabilitySubtitle;

  /// No description provided for @preset1h.
  ///
  /// In en, this message translates to:
  /// **'1 hr/day'**
  String get preset1h;

  /// No description provided for @preset2h.
  ///
  /// In en, this message translates to:
  /// **'2 hr/day'**
  String get preset2h;

  /// No description provided for @preset3h.
  ///
  /// In en, this message translates to:
  /// **'3 hr/day'**
  String get preset3h;

  /// No description provided for @presetCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get presetCustom;

  /// No description provided for @weeklyStudyTime.
  ///
  /// In en, this message translates to:
  /// **'Weekly study time'**
  String get weeklyStudyTime;

  /// No description provided for @averagePerStudyDay.
  ///
  /// In en, this message translates to:
  /// **'Average {duration} per study day'**
  String averagePerStudyDay(String duration);

  /// No description provided for @offDay.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get offDay;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @studyTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'When do you prefer to study?'**
  String get studyTimeTitle;

  /// No description provided for @studyTimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This is optional. Your plan will still work if your daily timing changes.'**
  String get studyTimeSubtitle;

  /// No description provided for @periodMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get periodMorning;

  /// No description provided for @periodMorningTime.
  ///
  /// In en, this message translates to:
  /// **'6 AM – 10 AM'**
  String get periodMorningTime;

  /// No description provided for @periodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get periodAfternoon;

  /// No description provided for @periodAfternoonTime.
  ///
  /// In en, this message translates to:
  /// **'12 PM – 4 PM'**
  String get periodAfternoonTime;

  /// No description provided for @periodEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get periodEvening;

  /// No description provided for @periodEveningTime.
  ///
  /// In en, this message translates to:
  /// **'5 PM – 9 PM'**
  String get periodEveningTime;

  /// No description provided for @periodNight.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get periodNight;

  /// No description provided for @periodNightTime.
  ///
  /// In en, this message translates to:
  /// **'9 PM – 12 AM'**
  String get periodNightTime;

  /// No description provided for @preferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'How should Porar Sathi build your plan?'**
  String get preferencesTitle;

  /// No description provided for @planningMode.
  ///
  /// In en, this message translates to:
  /// **'Planning style'**
  String get planningMode;

  /// No description provided for @modeBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get modeBalanced;

  /// No description provided for @modeBalancedBody.
  ///
  /// In en, this message translates to:
  /// **'Spread daily time across subjects while respecting your urgency.'**
  String get modeBalancedBody;

  /// No description provided for @modeWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak Subject Focus'**
  String get modeWeak;

  /// No description provided for @modeWeakBody.
  ///
  /// In en, this message translates to:
  /// **'Give extra attention to difficult topics and low-confidence subjects.'**
  String get modeWeakBody;

  /// No description provided for @modeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get modeLight;

  /// No description provided for @modeLightBody.
  ///
  /// In en, this message translates to:
  /// **'Keep daily workload lighter and more sustainable.'**
  String get modeLightBody;

  /// No description provided for @modeCrunch.
  ///
  /// In en, this message translates to:
  /// **'Exam Crunch'**
  String get modeCrunch;

  /// No description provided for @modeCrunchBody.
  ///
  /// In en, this message translates to:
  /// **'Prioritize urgent exam work and revision.'**
  String get modeCrunchBody;

  /// No description provided for @studyIntensity.
  ///
  /// In en, this message translates to:
  /// **'Study intensity'**
  String get studyIntensity;

  /// No description provided for @intensityLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get intensityLight;

  /// No description provided for @intensityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get intensityNormal;

  /// No description provided for @intensityFocused.
  ///
  /// In en, this message translates to:
  /// **'Focused'**
  String get intensityFocused;

  /// No description provided for @maxSession.
  ///
  /// In en, this message translates to:
  /// **'Maximum study session'**
  String get maxSession;

  /// No description provided for @revisionBuffer.
  ///
  /// In en, this message translates to:
  /// **'Revision buffer'**
  String get revisionBuffer;

  /// No description provided for @revisionDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String revisionDays(int count);

  /// No description provided for @actionCreatePlan.
  ///
  /// In en, this message translates to:
  /// **'Generate My Plan'**
  String get actionCreatePlan;

  /// No description provided for @summaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your study plan is ready'**
  String get summaryTitle;

  /// No description provided for @summaryFinish.
  ///
  /// In en, this message translates to:
  /// **'Expected syllabus finish'**
  String get summaryFinish;

  /// No description provided for @summaryFinishPending.
  ///
  /// In en, this message translates to:
  /// **'Add chapters to forecast a finish date.'**
  String get summaryFinishPending;

  /// No description provided for @summaryExam.
  ///
  /// In en, this message translates to:
  /// **'Exam'**
  String get summaryExam;

  /// No description provided for @summaryNoExam.
  ///
  /// In en, this message translates to:
  /// **'No exam date yet'**
  String get summaryNoExam;

  /// No description provided for @summaryRevisionBuffer.
  ///
  /// In en, this message translates to:
  /// **'Revision buffer'**
  String get summaryRevisionBuffer;

  /// No description provided for @firstDays.
  ///
  /// In en, this message translates to:
  /// **'Your first few days'**
  String get firstDays;

  /// No description provided for @summaryNoTasks.
  ///
  /// In en, this message translates to:
  /// **'Daily tasks appear after you add subjects and chapters.'**
  String get summaryNoTasks;

  /// No description provided for @actionUsePlan.
  ///
  /// In en, this message translates to:
  /// **'Use This Plan'**
  String get actionUsePlan;

  /// No description provided for @actionAdjustAvailability.
  ///
  /// In en, this message translates to:
  /// **'Adjust Availability'**
  String get actionAdjustAvailability;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Get gentle study reminders'**
  String get notificationsTitle;

  /// No description provided for @notificationsBody.
  ///
  /// In en, this message translates to:
  /// **'Pocket Tutor can remind you about:'**
  String get notificationsBody;

  /// No description provided for @notificationsBenefitPlan.
  ///
  /// In en, this message translates to:
  /// **'Today\'s plan'**
  String get notificationsBenefitPlan;

  /// No description provided for @notificationsBenefitRevision.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get notificationsBenefitRevision;

  /// No description provided for @notificationsBenefitExam.
  ///
  /// In en, this message translates to:
  /// **'Upcoming exams'**
  String get notificationsBenefitExam;

  /// No description provided for @notificationsBenefitEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening review'**
  String get notificationsBenefitEvening;

  /// No description provided for @actionEnableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get actionEnableReminders;

  /// No description provided for @completeTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re ready to study'**
  String get completeTitle;

  /// No description provided for @completeBody.
  ///
  /// In en, this message translates to:
  /// **'Your first plan is ready. Porar Sathi will adjust it as your progress changes.'**
  String get completeBody;

  /// No description provided for @actionSeeToday.
  ///
  /// In en, this message translates to:
  /// **'See Today\'s Study'**
  String get actionSeeToday;

  /// No description provided for @completeNoTasks.
  ///
  /// In en, this message translates to:
  /// **'Add subjects and chapters to fill today\'s plan.'**
  String get completeNoTasks;

  /// No description provided for @subjectCode.
  ///
  /// In en, this message translates to:
  /// **'Subject code'**
  String get subjectCode;

  /// No description provided for @paperName.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get paperName;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @priorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get priorityNormal;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @priorityCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get priorityCritical;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @difficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// No description provided for @difficultyModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get difficultyModerate;

  /// No description provided for @difficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Difficult'**
  String get difficultyHard;

  /// No description provided for @confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get confidence;

  /// No description provided for @confidenceLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get confidenceLow;

  /// No description provided for @confidenceMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get confidenceMedium;

  /// No description provided for @confidenceHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get confidenceHigh;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @archiveSubject.
  ///
  /// In en, this message translates to:
  /// **'Archive subject'**
  String get archiveSubject;

  /// No description provided for @deleteSubject.
  ///
  /// In en, this message translates to:
  /// **'Delete subject'**
  String get deleteSubject;

  /// No description provided for @deleteSubjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String deleteSubjectTitle(String name);

  /// No description provided for @deleteSubjectBody.
  ///
  /// In en, this message translates to:
  /// **'This removes its chapters and future tasks.'**
  String get deleteSubjectBody;

  /// No description provided for @deleteHistoryBody.
  ///
  /// In en, this message translates to:
  /// **'Study history exists. Delete that history too?'**
  String get deleteHistoryBody;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionDeleteHistory.
  ///
  /// In en, this message translates to:
  /// **'Delete history'**
  String get actionDeleteHistory;

  /// No description provided for @editSubject.
  ///
  /// In en, this message translates to:
  /// **'Edit subject'**
  String get editSubject;

  /// No description provided for @chaptersProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} chapters'**
  String chaptersProgress(int done, int total);

  /// No description provided for @syllabusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Syllabus completed'**
  String get syllabusCompleted;

  /// No description provided for @chapterTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Chapter title'**
  String get chapterTitleLabel;

  /// No description provided for @chapterNumber.
  ///
  /// In en, this message translates to:
  /// **'Chapter number'**
  String get chapterNumber;

  /// No description provided for @estimatedTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated study time'**
  String get estimatedTime;

  /// No description provided for @chapterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get chapterStatus;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @editChapter.
  ///
  /// In en, this message translates to:
  /// **'Edit chapter'**
  String get editChapter;

  /// No description provided for @bulkAddChapters.
  ///
  /// In en, this message translates to:
  /// **'Add multiple chapters'**
  String get bulkAddChapters;

  /// No description provided for @bulkPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter one chapter per line'**
  String get bulkPlaceholder;

  /// No description provided for @createChapters.
  ///
  /// In en, this message translates to:
  /// **'Create {count} chapters'**
  String createChapters(int count);

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get notStarted;

  /// No description provided for @revisionDue.
  ///
  /// In en, this message translates to:
  /// **'Revision due'**
  String get revisionDue;

  /// No description provided for @skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get skipped;

  /// No description provided for @editExam.
  ///
  /// In en, this message translates to:
  /// **'Edit exam'**
  String get editExam;

  /// No description provided for @examDateChangeWarning.
  ///
  /// In en, this message translates to:
  /// **'Your study plan may need to be updated.'**
  String get examDateChangeWarning;

  /// No description provided for @upcomingExams.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcomingExams;

  /// No description provided for @completedExams.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedExams;

  /// No description provided for @noExamsTitle.
  ///
  /// In en, this message translates to:
  /// **'No exams yet'**
  String get noExamsTitle;

  /// No description provided for @noExamsBody.
  ///
  /// In en, this message translates to:
  /// **'Add an exam date so the plan knows what you\'re preparing for.'**
  String get noExamsBody;

  /// No description provided for @linkSyllabus.
  ///
  /// In en, this message translates to:
  /// **'Map syllabus'**
  String get linkSyllabus;

  /// No description provided for @syllabusMappingTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s included in this exam?'**
  String get syllabusMappingTitle;

  /// No description provided for @availabilityEdit.
  ///
  /// In en, this message translates to:
  /// **'Weekly availability'**
  String get availabilityEdit;

  /// No description provided for @addException.
  ///
  /// In en, this message translates to:
  /// **'Add exception'**
  String get addException;

  /// No description provided for @exceptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar exceptions'**
  String get exceptionsTitle;

  /// No description provided for @exceptionDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get exceptionDate;

  /// No description provided for @exceptionReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get exceptionReason;

  /// No description provided for @exceptionMinutes.
  ///
  /// In en, this message translates to:
  /// **'Available minutes'**
  String get exceptionMinutes;

  /// No description provided for @exceptionType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get exceptionType;

  /// No description provided for @noStudyDay.
  ///
  /// In en, this message translates to:
  /// **'No study day'**
  String get noStudyDay;

  /// No description provided for @reducedAvailability.
  ///
  /// In en, this message translates to:
  /// **'Reduced availability'**
  String get reducedAvailability;

  /// No description provided for @extraStudyDay.
  ///
  /// In en, this message translates to:
  /// **'Extra study day'**
  String get extraStudyDay;

  /// No description provided for @saveOverride.
  ///
  /// In en, this message translates to:
  /// **'Save override'**
  String get saveOverride;

  /// No description provided for @todayCapacity.
  ///
  /// In en, this message translates to:
  /// **'Today\'s study time'**
  String get todayCapacity;

  /// No description provided for @schedulableCapacity.
  ///
  /// In en, this message translates to:
  /// **'Time the planner can schedule'**
  String get schedulableCapacity;

  /// No description provided for @capacityBuffer.
  ///
  /// In en, this message translates to:
  /// **'Planning buffer'**
  String get capacityBuffer;

  /// No description provided for @noExceptions.
  ///
  /// In en, this message translates to:
  /// **'No calendar exceptions yet.'**
  String get noExceptions;

  /// No description provided for @exceptionSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved. The planner can schedule {duration} that day.'**
  String exceptionSaved(String duration);

  /// No description provided for @averageDailyStudy.
  ///
  /// In en, this message translates to:
  /// **'Average daily study'**
  String get averageDailyStudy;

  /// No description provided for @tasksGenerated.
  ///
  /// In en, this message translates to:
  /// **'{count} tasks'**
  String tasksGenerated(int count);

  /// No description provided for @paceAhead.
  ///
  /// In en, this message translates to:
  /// **'Ahead'**
  String get paceAhead;

  /// No description provided for @paceOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On Track'**
  String get paceOnTrack;

  /// No description provided for @paceSlightlyBehind.
  ///
  /// In en, this message translates to:
  /// **'Slightly Behind'**
  String get paceSlightlyBehind;

  /// No description provided for @paceBehind.
  ///
  /// In en, this message translates to:
  /// **'Behind'**
  String get paceBehind;

  /// No description provided for @paceAtRisk.
  ///
  /// In en, this message translates to:
  /// **'At Risk'**
  String get paceAtRisk;

  /// No description provided for @riskLabel.
  ///
  /// In en, this message translates to:
  /// **'Risk'**
  String get riskLabel;

  /// No description provided for @riskNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get riskNone;

  /// No description provided for @riskLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get riskLow;

  /// No description provided for @riskMedium.
  ///
  /// In en, this message translates to:
  /// **'Tight'**
  String get riskMedium;

  /// No description provided for @riskHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get riskHigh;

  /// No description provided for @riskImpossible.
  ///
  /// In en, this message translates to:
  /// **'Impossible'**
  String get riskImpossible;

  /// No description provided for @planShortfall.
  ///
  /// In en, this message translates to:
  /// **'Required {requiredTime}, available {availableTime}, shortfall {shortfallTime}.'**
  String planShortfall(
    String requiredTime,
    String availableTime,
    String shortfallTime,
  );

  /// No description provided for @subjectAllocation.
  ///
  /// In en, this message translates to:
  /// **'Subject allocation'**
  String get subjectAllocation;

  /// No description provided for @suggestionIncreaseAvailability.
  ///
  /// In en, this message translates to:
  /// **'Add more study time'**
  String get suggestionIncreaseAvailability;

  /// No description provided for @suggestionIncreaseIntensity.
  ///
  /// In en, this message translates to:
  /// **'Increase daily intensity'**
  String get suggestionIncreaseIntensity;

  /// No description provided for @suggestionReduceBuffer.
  ///
  /// In en, this message translates to:
  /// **'Reduce the revision buffer'**
  String get suggestionReduceBuffer;

  /// No description provided for @suggestionPrioritize.
  ///
  /// In en, this message translates to:
  /// **'Mark lower-priority chapters optional'**
  String get suggestionPrioritize;

  /// No description provided for @suggestionEstimates.
  ///
  /// In en, this message translates to:
  /// **'Change estimated duration'**
  String get suggestionEstimates;

  /// No description provided for @suggestionExamDate.
  ///
  /// In en, this message translates to:
  /// **'Change the exam date'**
  String get suggestionExamDate;

  /// No description provided for @todayTarget.
  ///
  /// In en, this message translates to:
  /// **'Today\'s target'**
  String get todayTarget;

  /// No description provided for @tasksDone.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} tasks done'**
  String tasksDone(int done, int total);

  /// No description provided for @syllabusProgress.
  ///
  /// In en, this message translates to:
  /// **'Syllabus {percent}%'**
  String syllabusProgress(int percent);

  /// No description provided for @revisionDueCount.
  ///
  /// In en, this message translates to:
  /// **'{count} revisions due'**
  String revisionDueCount(int count);

  /// No description provided for @actionReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get actionReview;

  /// No description provided for @backlogBehind.
  ///
  /// In en, this message translates to:
  /// **'{duration} behind schedule'**
  String backlogBehind(String duration);

  /// No description provided for @actionViewBacklog.
  ///
  /// In en, this message translates to:
  /// **'View backlog'**
  String get actionViewBacklog;

  /// No description provided for @actionQuickStudy.
  ///
  /// In en, this message translates to:
  /// **'Quick Study'**
  String get actionQuickStudy;

  /// No description provided for @todayAllDone.
  ///
  /// In en, this message translates to:
  /// **'Today\'s study is done.'**
  String get todayAllDone;

  /// No description provided for @tomorrowReady.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow\'s plan is ready.'**
  String get tomorrowReady;

  /// No description provided for @actionViewTomorrow.
  ///
  /// In en, this message translates to:
  /// **'View tomorrow'**
  String get actionViewTomorrow;

  /// No description provided for @actionStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get actionStart;

  /// No description provided for @actionStartTimer.
  ///
  /// In en, this message translates to:
  /// **'Start Timer'**
  String get actionStartTimer;

  /// No description provided for @actionStudyWithoutTimer.
  ///
  /// In en, this message translates to:
  /// **'Study Without Timer'**
  String get actionStudyWithoutTimer;

  /// No description provided for @actionComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark Complete'**
  String get actionComplete;

  /// No description provided for @actionPartial.
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get actionPartial;

  /// No description provided for @actionMove.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get actionMove;

  /// No description provided for @actionPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get actionPause;

  /// No description provided for @actionResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get actionResume;

  /// No description provided for @actionFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get actionFinish;

  /// No description provided for @actionFinishNow.
  ///
  /// In en, this message translates to:
  /// **'Finish Now'**
  String get actionFinishNow;

  /// No description provided for @sessionPaused.
  ///
  /// In en, this message translates to:
  /// **'Session paused'**
  String get sessionPaused;

  /// No description provided for @plannedLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned: {duration}'**
  String plannedLabel(String duration);

  /// No description provided for @finishTitle.
  ///
  /// In en, this message translates to:
  /// **'How did this session go?'**
  String get finishTitle;

  /// No description provided for @resultFully.
  ///
  /// In en, this message translates to:
  /// **'Fully completed'**
  String get resultFully;

  /// No description provided for @resultMostly.
  ///
  /// In en, this message translates to:
  /// **'Mostly completed'**
  String get resultMostly;

  /// No description provided for @resultPartial.
  ///
  /// In en, this message translates to:
  /// **'Partially completed'**
  String get resultPartial;

  /// No description provided for @resultCouldNot.
  ///
  /// In en, this message translates to:
  /// **'Could not study'**
  String get resultCouldNot;

  /// No description provided for @actualTime.
  ///
  /// In en, this message translates to:
  /// **'Actual time'**
  String get actualTime;

  /// No description provided for @confidenceNow.
  ///
  /// In en, this message translates to:
  /// **'How confident do you feel now?'**
  String get confidenceNow;

  /// No description provided for @wantRevision.
  ///
  /// In en, this message translates to:
  /// **'I want to revise this later'**
  String get wantRevision;

  /// No description provided for @actionSaveSession.
  ///
  /// In en, this message translates to:
  /// **'Save Session'**
  String get actionSaveSession;

  /// No description provided for @partialTitle.
  ///
  /// In en, this message translates to:
  /// **'How much did you finish?'**
  String get partialTitle;

  /// No description provided for @aboutRemain.
  ///
  /// In en, this message translates to:
  /// **'About {duration} remain.'**
  String aboutRemain(String duration);

  /// No description provided for @actionSaveReplan.
  ///
  /// In en, this message translates to:
  /// **'Save & Replan Remaining'**
  String get actionSaveReplan;

  /// No description provided for @actionSaveWithoutReplan.
  ///
  /// In en, this message translates to:
  /// **'Save Without Replanning'**
  String get actionSaveWithoutReplan;

  /// No description provided for @skipTitle.
  ///
  /// In en, this message translates to:
  /// **'Skip this task?'**
  String get skipTitle;

  /// No description provided for @skipToday.
  ///
  /// In en, this message translates to:
  /// **'Skip only today'**
  String get skipToday;

  /// No description provided for @skipRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from plan'**
  String get skipRemove;

  /// No description provided for @skipReschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule automatically'**
  String get skipReschedule;

  /// No description provided for @moveTitle.
  ///
  /// In en, this message translates to:
  /// **'Move study task'**
  String get moveTitle;

  /// No description provided for @capacityFree.
  ///
  /// In en, this message translates to:
  /// **'{duration} free'**
  String capacityFree(String duration);

  /// No description provided for @capacityTight.
  ///
  /// In en, this message translates to:
  /// **'This day is shorter than the task.'**
  String get capacityTight;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'High priority'**
  String get highPriority;

  /// No description provided for @confidenceLowReason.
  ///
  /// In en, this message translates to:
  /// **'Confidence is low'**
  String get confidenceLowReason;

  /// No description provided for @highPriorityChapter.
  ///
  /// In en, this message translates to:
  /// **'High-priority chapter'**
  String get highPriorityChapter;

  /// No description provided for @quickStudyTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Study'**
  String get quickStudyTitle;

  /// No description provided for @actionLogCompleted.
  ///
  /// In en, this message translates to:
  /// **'Log Completed Study'**
  String get actionLogCompleted;

  /// No description provided for @resumeSession.
  ///
  /// In en, this message translates to:
  /// **'Resume study'**
  String get resumeSession;

  /// No description provided for @taskPlanned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get taskPlanned;

  /// No description provided for @taskMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get taskMissed;

  /// No description provided for @taskNewStudy.
  ///
  /// In en, this message translates to:
  /// **'New study'**
  String get taskNewStudy;

  /// No description provided for @taskContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get taskContinue;

  /// No description provided for @taskRevision.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get taskRevision;

  /// No description provided for @taskPractice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get taskPractice;

  /// No description provided for @revisionQueue.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get revisionQueue;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due Today'**
  String get dueToday;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @revisionEmpty.
  ///
  /// In en, this message translates to:
  /// **'No revisions in this list.'**
  String get revisionEmpty;

  /// No description provided for @actionStartRevision.
  ///
  /// In en, this message translates to:
  /// **'Start Revision'**
  String get actionStartRevision;

  /// No description provided for @lastStudied.
  ///
  /// In en, this message translates to:
  /// **'Last studied {date}'**
  String lastStudied(String date);

  /// No description provided for @previousRevisions.
  ///
  /// In en, this message translates to:
  /// **'{count} previous revisions'**
  String previousRevisions(int count);

  /// No description provided for @actionReschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get actionReschedule;

  /// No description provided for @revisionCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Revision complete'**
  String get revisionCompleteTitle;

  /// No description provided for @needAnotherRevision.
  ///
  /// In en, this message translates to:
  /// **'Need another revision?'**
  String get needAnotherRevision;

  /// No description provided for @nextRevision.
  ///
  /// In en, this message translates to:
  /// **'Next revision: {date}'**
  String nextRevision(String date);

  /// No description provided for @backlogTitle.
  ///
  /// In en, this message translates to:
  /// **'Backlog'**
  String get backlogTitle;

  /// No description provided for @overdueTasks.
  ///
  /// In en, this message translates to:
  /// **'{count} overdue tasks'**
  String overdueTasks(int count);

  /// No description provided for @oldestMissed.
  ///
  /// In en, this message translates to:
  /// **'Oldest missed task'**
  String get oldestMissed;

  /// No description provided for @recoveryEstimate.
  ///
  /// In en, this message translates to:
  /// **'You can recover this backlog in {days} days.'**
  String recoveryEstimate(int days);

  /// No description provided for @actionBuildCatchUp.
  ///
  /// In en, this message translates to:
  /// **'Build Catch-Up Plan'**
  String get actionBuildCatchUp;

  /// No description provided for @catchUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Catch-up plan'**
  String get catchUpTitle;

  /// No description provided for @extraStudy.
  ///
  /// In en, this message translates to:
  /// **'Suggested extra study'**
  String get extraStudy;

  /// No description provided for @actionApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get actionApply;

  /// No description provided for @catchUpAdded.
  ///
  /// In en, this message translates to:
  /// **'Catch-up plan added'**
  String get catchUpAdded;

  /// No description provided for @actionViewUpdatedPlan.
  ///
  /// In en, this message translates to:
  /// **'View updated plan'**
  String get actionViewUpdatedPlan;

  /// No description provided for @replanTitle.
  ///
  /// In en, this message translates to:
  /// **'Your plan needs an update'**
  String get replanTitle;

  /// No description provided for @replanMoved.
  ///
  /// In en, this message translates to:
  /// **'{count} tasks moved'**
  String replanMoved(int count);

  /// No description provided for @replanAdded.
  ///
  /// In en, this message translates to:
  /// **'{count} tasks added'**
  String replanAdded(int count);

  /// No description provided for @replanRemoved.
  ///
  /// In en, this message translates to:
  /// **'{count} tasks removed'**
  String replanRemoved(int count);

  /// No description provided for @finishChange.
  ///
  /// In en, this message translates to:
  /// **'Expected finish changed'**
  String get finishChange;

  /// No description provided for @actionApplyChanges.
  ///
  /// In en, this message translates to:
  /// **'Apply Changes'**
  String get actionApplyChanges;

  /// No description provided for @actionKeepPlan.
  ///
  /// In en, this message translates to:
  /// **'Keep Current Plan'**
  String get actionKeepPlan;

  /// No description provided for @planUpdated.
  ///
  /// In en, this message translates to:
  /// **'Study plan updated'**
  String get planUpdated;

  /// No description provided for @actionViewToday.
  ///
  /// In en, this message translates to:
  /// **'View Today'**
  String get actionViewToday;

  /// No description provided for @actionUpdatePlan.
  ///
  /// In en, this message translates to:
  /// **'Update plan'**
  String get actionUpdatePlan;

  /// No description provided for @planNeedsUpdate.
  ///
  /// In en, this message translates to:
  /// **'Your plan needs an update'**
  String get planNeedsUpdate;

  /// No description provided for @daysOverdue.
  ///
  /// In en, this message translates to:
  /// **'{count} days overdue'**
  String daysOverdue(int count);

  /// No description provided for @actionStudyNow.
  ///
  /// In en, this message translates to:
  /// **'Study Now'**
  String get actionStudyNow;

  /// No description provided for @actionRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get actionRemove;

  /// No description provided for @noBacklog.
  ///
  /// In en, this message translates to:
  /// **'No missed study is waiting.'**
  String get noBacklog;

  /// No description provided for @rangeWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get rangeWeek;

  /// No description provided for @rangeMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get rangeMonth;

  /// No description provided for @rangeAll.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get rangeAll;

  /// No description provided for @studyTime.
  ///
  /// In en, this message translates to:
  /// **'Study time'**
  String get studyTime;

  /// No description provided for @taskCompletion.
  ///
  /// In en, this message translates to:
  /// **'Task completion'**
  String get taskCompletion;

  /// No description provided for @tasksFraction.
  ///
  /// In en, this message translates to:
  /// **'{done} / {total}'**
  String tasksFraction(int done, int total);

  /// No description provided for @revisionCompletion.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get revisionCompletion;

  /// No description provided for @revisionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{count} completed'**
  String revisionsCompleted(int count);

  /// No description provided for @consistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get consistency;

  /// No description provided for @consistencyOf.
  ///
  /// In en, this message translates to:
  /// **'{studied} of {available} days'**
  String consistencyOf(int studied, int available);

  /// No description provided for @consistencyNote.
  ///
  /// In en, this message translates to:
  /// **'Configured no-study days are not counted against you.'**
  String get consistencyNote;

  /// No description provided for @subjectBalance.
  ///
  /// In en, this message translates to:
  /// **'Subject balance'**
  String get subjectBalance;

  /// No description provided for @preparationReadiness.
  ///
  /// In en, this message translates to:
  /// **'Preparation Readiness'**
  String get preparationReadiness;

  /// No description provided for @readinessDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is a preparation indicator, not an exam-score prediction.'**
  String get readinessDisclaimer;

  /// No description provided for @paceBecause.
  ///
  /// In en, this message translates to:
  /// **'{status} because:'**
  String paceBecause(String status);

  /// No description provided for @remainingWork.
  ///
  /// In en, this message translates to:
  /// **'{duration} remaining'**
  String remainingWork(String duration);

  /// No description provided for @capacityBeforeExam.
  ///
  /// In en, this message translates to:
  /// **'{duration} capacity before exam'**
  String capacityBeforeExam(String duration);

  /// No description provided for @dailySummary.
  ///
  /// In en, this message translates to:
  /// **'Daily summary'**
  String get dailySummary;

  /// No description provided for @weeklySummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly summary'**
  String get weeklySummary;

  /// No description provided for @mostStudied.
  ///
  /// In en, this message translates to:
  /// **'Most studied'**
  String get mostStudied;

  /// No description provided for @mostImproved.
  ///
  /// In en, this message translates to:
  /// **'Most improved'**
  String get mostImproved;

  /// No description provided for @needsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get needsAttention;

  /// No description provided for @syllabusChange.
  ///
  /// In en, this message translates to:
  /// **'Syllabus change'**
  String get syllabusChange;

  /// No description provided for @targetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get targetLabel;

  /// No description provided for @studiedLabel.
  ///
  /// In en, this message translates to:
  /// **'Studied'**
  String get studiedLabel;

  /// No description provided for @chaptersCompleted.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} chapters'**
  String chaptersCompleted(int done, int total);

  /// No description provided for @pendingTasks.
  ///
  /// In en, this message translates to:
  /// **'{count} pending'**
  String pendingTasks(int count);

  /// No description provided for @balancedStudy.
  ///
  /// In en, this message translates to:
  /// **'Study time is balanced.'**
  String get balancedStudy;

  /// No description provided for @noStudyYet.
  ///
  /// In en, this message translates to:
  /// **'No study recorded yet.'**
  String get noStudyYet;

  /// No description provided for @notificationsDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off'**
  String get notificationsDeniedTitle;

  /// No description provided for @notificationsDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Your study plan still works normally. You just won\'t receive reminders.'**
  String get notificationsDeniedBody;

  /// No description provided for @actionOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get actionOpenSettings;

  /// No description provided for @actionContinueWithoutNotifications.
  ///
  /// In en, this message translates to:
  /// **'Continue Without Notifications'**
  String get actionContinueWithoutNotifications;

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationSettingsTitle;

  /// No description provided for @remindersEnabled.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersEnabled;

  /// No description provided for @dailyPlanReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily plan'**
  String get dailyPlanReminder;

  /// No description provided for @revisionReminder.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get revisionReminder;

  /// No description provided for @examCountdownReminder.
  ///
  /// In en, this message translates to:
  /// **'Exam countdown'**
  String get examCountdownReminder;

  /// No description provided for @missedTaskReminder.
  ///
  /// In en, this message translates to:
  /// **'Missed task'**
  String get missedTaskReminder;

  /// No description provided for @eveningReviewReminder.
  ///
  /// In en, this message translates to:
  /// **'Evening review'**
  String get eveningReviewReminder;

  /// No description provided for @studySessionReminder.
  ///
  /// In en, this message translates to:
  /// **'Study session'**
  String get studySessionReminder;

  /// No description provided for @reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get reminderTime;

  /// No description provided for @examThresholdsLabel.
  ///
  /// In en, this message translates to:
  /// **'Countdown'**
  String get examThresholdsLabel;

  /// No description provided for @dailyReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s study'**
  String get dailyReminderTitle;

  /// No description provided for @dailyReminderBody.
  ///
  /// In en, this message translates to:
  /// **'You have {count} study tasks today — {duration} in total.'**
  String dailyReminderBody(String count, String duration);

  /// No description provided for @revisionReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Revision is due'**
  String get revisionReminderTitle;

  /// No description provided for @revisionReminderBody.
  ///
  /// In en, this message translates to:
  /// **'A revision is due today.'**
  String get revisionReminderBody;

  /// No description provided for @examReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Exam coming up'**
  String get examReminderTitle;

  /// No description provided for @examReminderBody.
  ///
  /// In en, this message translates to:
  /// **'{name} is in {days} days.'**
  String examReminderBody(String name, String days);

  /// No description provided for @missedReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Still some study left'**
  String get missedReminderTitle;

  /// No description provided for @missedReminderBody.
  ///
  /// In en, this message translates to:
  /// **'{count} tasks are still open today.'**
  String missedReminderBody(String count);

  /// No description provided for @eveningReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Evening review'**
  String get eveningReminderTitle;

  /// No description provided for @eveningReminderBody.
  ///
  /// In en, this message translates to:
  /// **'{done} finished, {remaining} still open.'**
  String eveningReminderBody(String done, String remaining);

  /// No description provided for @sessionReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to study'**
  String get sessionReminderTitle;

  /// No description provided for @sessionReminderBody.
  ///
  /// In en, this message translates to:
  /// **'{title}'**
  String sessionReminderBody(String title);

  /// No description provided for @reminderDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes'**
  String reminderDurationMinutes(String count);

  /// No description provided for @reminderDurationHours.
  ///
  /// In en, this message translates to:
  /// **'{count} hours'**
  String reminderDurationHours(String count);

  /// No description provided for @reminderDurationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours {minutes} minutes'**
  String reminderDurationHoursMinutes(String hours, String minutes);

  /// No description provided for @dataBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Data & Backup'**
  String get dataBackupTitle;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export Backup'**
  String get exportBackup;

  /// No description provided for @importBackup.
  ///
  /// In en, this message translates to:
  /// **'Import Backup'**
  String get importBackup;

  /// No description provided for @backupStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard backup'**
  String get backupStandard;

  /// No description provided for @backupEncrypted.
  ///
  /// In en, this message translates to:
  /// **'Password-protected backup'**
  String get backupEncrypted;

  /// No description provided for @backupIncluded.
  ///
  /// In en, this message translates to:
  /// **'Included data'**
  String get backupIncluded;

  /// No description provided for @backupIncludedBody.
  ///
  /// In en, this message translates to:
  /// **'Study plans, subjects, chapters, exams, tasks, sessions, and revisions.'**
  String get backupIncludedBody;

  /// No description provided for @backupContainsStudyData.
  ///
  /// In en, this message translates to:
  /// **'This file contains your study data.'**
  String get backupContainsStudyData;

  /// No description provided for @backupNotEncrypted.
  ///
  /// In en, this message translates to:
  /// **'A standard backup is not encrypted.'**
  String get backupNotEncrypted;

  /// No description provided for @backupPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get backupPassword;

  /// No description provided for @backupPasswordAgain.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get backupPasswordAgain;

  /// No description provided for @backupPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get backupPasswordMismatch;

  /// No description provided for @backupPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters.'**
  String get backupPasswordShort;

  /// No description provided for @actionExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get actionExport;

  /// No description provided for @actionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get actionShare;

  /// No description provided for @backupEstimate.
  ///
  /// In en, this message translates to:
  /// **'Estimated size: {size}'**
  String backupEstimate(String size);

  /// No description provided for @importBackupBody.
  ///
  /// In en, this message translates to:
  /// **'Your current data will not be changed until the backup is validated.'**
  String get importBackupBody;

  /// No description provided for @actionChooseBackup.
  ///
  /// In en, this message translates to:
  /// **'Choose Backup File'**
  String get actionChooseBackup;

  /// No description provided for @backupReading.
  ///
  /// In en, this message translates to:
  /// **'Reading file'**
  String get backupReading;

  /// No description provided for @backupCheckingVersion.
  ///
  /// In en, this message translates to:
  /// **'Checking version'**
  String get backupCheckingVersion;

  /// No description provided for @backupCheckingIntegrity.
  ///
  /// In en, this message translates to:
  /// **'Checking integrity'**
  String get backupCheckingIntegrity;

  /// No description provided for @backupValidatingData.
  ///
  /// In en, this message translates to:
  /// **'Validating study data'**
  String get backupValidatingData;

  /// No description provided for @backupSummaryPlans.
  ///
  /// In en, this message translates to:
  /// **'{count} study plans'**
  String backupSummaryPlans(int count);

  /// No description provided for @backupSummarySubjects.
  ///
  /// In en, this message translates to:
  /// **'{count} subjects'**
  String backupSummarySubjects(int count);

  /// No description provided for @backupSummarySessions.
  ///
  /// In en, this message translates to:
  /// **'{count} study sessions'**
  String backupSummarySessions(int count);

  /// No description provided for @backupDate.
  ///
  /// In en, this message translates to:
  /// **'Backup date'**
  String get backupDate;

  /// No description provided for @restoreConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore this backup?'**
  String get restoreConfirmTitle;

  /// No description provided for @restoreConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Your current Pocket Tutor data will be replaced.'**
  String get restoreConfirmBody;

  /// No description provided for @actionRestoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get actionRestoreBackup;

  /// No description provided for @restoreCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup restored successfully'**
  String get restoreCompleteTitle;

  /// No description provided for @actionGoToday.
  ///
  /// In en, this message translates to:
  /// **'Go to Today'**
  String get actionGoToday;

  /// No description provided for @backupFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup couldn\'t be created.'**
  String get backupFailedTitle;

  /// No description provided for @actionChooseAnotherLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Another Location'**
  String get actionChooseAnotherLocation;

  /// No description provided for @restoreFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore couldn\'t be completed.'**
  String get restoreFailedTitle;

  /// No description provided for @restoreFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Your current data has not been changed.'**
  String get restoreFailedBody;

  /// No description provided for @actionChooseAnotherBackup.
  ///
  /// In en, this message translates to:
  /// **'Choose Another Backup'**
  String get actionChooseAnotherBackup;

  /// No description provided for @corruptBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'This backup can\'t be opened'**
  String get corruptBackupTitle;

  /// No description provided for @corruptDamaged.
  ///
  /// In en, this message translates to:
  /// **'File is damaged.'**
  String get corruptDamaged;

  /// No description provided for @corruptPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password.'**
  String get corruptPassword;

  /// No description provided for @corruptVersion.
  ///
  /// In en, this message translates to:
  /// **'Unsupported version.'**
  String get corruptVersion;

  /// No description provided for @actionTryPassword.
  ///
  /// In en, this message translates to:
  /// **'Try Password Again'**
  String get actionTryPassword;

  /// No description provided for @storageDatabase.
  ///
  /// In en, this message translates to:
  /// **'Database size'**
  String get storageDatabase;

  /// No description provided for @storageBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup size'**
  String get storageBackup;

  /// No description provided for @storageNone.
  ///
  /// In en, this message translates to:
  /// **'No backup exported yet'**
  String get storageNone;

  /// No description provided for @resetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress'**
  String get resetProgress;

  /// No description provided for @resetProgressBody.
  ///
  /// In en, this message translates to:
  /// **'This clears study sessions, revision history, and completion. Your subjects and chapters stay.'**
  String get resetProgressBody;

  /// No description provided for @deletePlan.
  ///
  /// In en, this message translates to:
  /// **'Delete Study Plan'**
  String get deletePlan;

  /// No description provided for @deletePlanBody.
  ///
  /// In en, this message translates to:
  /// **'This deletes the current plan, its subjects, tasks, and study history.'**
  String get deletePlanBody;

  /// No description provided for @deleteAllData.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get deleteAllData;

  /// No description provided for @deleteAllDataBody.
  ///
  /// In en, this message translates to:
  /// **'This removes every study plan and starts setup again. Language and appearance stay.'**
  String get deleteAllDataBody;

  /// No description provided for @deleteSubjectHint.
  ///
  /// In en, this message translates to:
  /// **'To delete one subject, open it in Syllabus and choose Delete. Its chapters and future tasks are removed.'**
  String get deleteSubjectHint;

  /// No description provided for @reportsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Report files are not part of this version.'**
  String get reportsUnavailable;

  /// No description provided for @backupReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get backupReports;

  /// No description provided for @backupStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get backupStorage;

  /// No description provided for @backupReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get backupReset;

  /// No description provided for @maxDailyWorkload.
  ///
  /// In en, this message translates to:
  /// **'Max daily workload'**
  String get maxDailyWorkload;

  /// No description provided for @revisionPolicy.
  ///
  /// In en, this message translates to:
  /// **'Revision policy'**
  String get revisionPolicy;

  /// No description provided for @revisionStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get revisionStandard;

  /// No description provided for @revisionStandardHelp.
  ///
  /// In en, this message translates to:
  /// **'Review after 2 days, after 7 days, and the day before the exam.'**
  String get revisionStandardHelp;

  /// No description provided for @revisionLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get revisionLight;

  /// No description provided for @revisionLightHelp.
  ///
  /// In en, this message translates to:
  /// **'Review after 7 days and the day before the exam.'**
  String get revisionLightHelp;

  /// No description provided for @revisionFrequent.
  ///
  /// In en, this message translates to:
  /// **'Frequent'**
  String get revisionFrequent;

  /// No description provided for @revisionFrequentHelp.
  ///
  /// In en, this message translates to:
  /// **'Review after 1 day, 3 days, and 7 days.'**
  String get revisionFrequentHelp;

  /// No description provided for @reducedMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduced motion'**
  String get reducedMotion;

  /// No description provided for @reducedMotionHelp.
  ///
  /// In en, this message translates to:
  /// **'Use fewer animations. The system setting is also respected.'**
  String get reducedMotionHelp;

  /// No description provided for @searchSyllabus.
  ///
  /// In en, this message translates to:
  /// **'Search subjects and chapters'**
  String get searchSyllabus;

  /// No description provided for @searchChapters.
  ///
  /// In en, this message translates to:
  /// **'Search chapters'**
  String get searchChapters;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\".'**
  String noSearchResults(String query);

  /// No description provided for @actionClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get actionClearFilters;

  /// No description provided for @actionTryAnotherSearch.
  ///
  /// In en, this message translates to:
  /// **'Try Another Search'**
  String get actionTryAnotherSearch;

  /// No description provided for @actionClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get actionClear;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @discardChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard your changes?'**
  String get discardChangesTitle;

  /// No description provided for @discardChangesBody.
  ///
  /// In en, this message translates to:
  /// **'Your edits on this screen will be lost.'**
  String get discardChangesBody;

  /// No description provided for @actionKeepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep Editing'**
  String get actionKeepEditing;

  /// No description provided for @actionDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get actionDiscard;

  /// No description provided for @plannerFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t create a valid plan.'**
  String get plannerFailedTitle;

  /// No description provided for @plannerFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Check your study time, exam date, and chapter estimates.'**
  String get plannerFailedBody;

  /// No description provided for @actionReviewSetup.
  ///
  /// In en, this message translates to:
  /// **'Review Setup'**
  String get actionReviewSetup;

  /// No description provided for @migrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Updating Pocket Tutor'**
  String get migrationTitle;

  /// No description provided for @migrationBody.
  ///
  /// In en, this message translates to:
  /// **'Your study data is being prepared for this version.'**
  String get migrationBody;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @deleteFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete this item.'**
  String get deleteFailedTitle;

  /// No description provided for @changeStudyTime.
  ///
  /// In en, this message translates to:
  /// **'Change study time'**
  String get changeStudyTime;

  /// No description provided for @difficultyVeryEasy.
  ///
  /// In en, this message translates to:
  /// **'Very Easy'**
  String get difficultyVeryEasy;

  /// No description provided for @difficultyVeryDifficult.
  ///
  /// In en, this message translates to:
  /// **'Very Difficult'**
  String get difficultyVeryDifficult;

  /// No description provided for @confidenceVeryLow.
  ///
  /// In en, this message translates to:
  /// **'Very Low'**
  String get confidenceVeryLow;

  /// No description provided for @confidenceVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get confidenceVeryHigh;

  /// No description provided for @intensityIntensive.
  ///
  /// In en, this message translates to:
  /// **'Intensive'**
  String get intensityIntensive;

  /// No description provided for @settingsApplyToPlan.
  ///
  /// In en, this message translates to:
  /// **'Saved for this plan and for the next one.'**
  String get settingsApplyToPlan;

  /// No description provided for @statusPlanned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get statusPlanned;

  /// No description provided for @statusRevised.
  ///
  /// In en, this message translates to:
  /// **'Revised'**
  String get statusRevised;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
