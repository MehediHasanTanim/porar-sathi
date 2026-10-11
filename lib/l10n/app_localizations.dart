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
