// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'পড়ার সাথী';

  @override
  String get appNameBangla => 'পড়ার সাথী';

  @override
  String get splashTagline => 'পরিকল্পিত পড়াশোনা, উজ্জ্বল আগামী';

  @override
  String get loadingStudySpace => 'পড়ার জায়গা তৈরি হচ্ছে...';

  @override
  String get offlineStudyPlanner => 'অফলাইন স্টাডি প্ল্যানার';

  @override
  String get navToday => 'আজ';

  @override
  String get navPlan => 'পরিকল্পনা';

  @override
  String get navSyllabus => 'সিলেবাস';

  @override
  String get navProgress => 'অগ্রগতি';

  @override
  String get navMore => 'আরও';

  @override
  String get actionContinue => 'চালিয়ে যান';

  @override
  String get actionSkip => 'এড়িয়ে যান';

  @override
  String get actionSave => 'সংরক্ষণ করুন';

  @override
  String get actionCancel => 'বাতিল';

  @override
  String get actionRetry => 'আবার চেষ্টা করুন';

  @override
  String get actionDone => 'শেষ';

  @override
  String get actionBack => 'পেছনে';

  @override
  String get actionGetStarted => 'শুরু করি';

  @override
  String get actionNotNow => 'এখন নয়';

  @override
  String get stateLoading => 'লোড হচ্ছে...';

  @override
  String get stateSaving => 'সংরক্ষণ হচ্ছে...';

  @override
  String get stateCreatingPlan => 'আপনার পড়ার পরিকল্পনা তৈরি হচ্ছে...';

  @override
  String get errorGeneric => 'কিছু একটা সমস্যা হয়েছে। আবার চেষ্টা করুন।';

  @override
  String get errorSaveFailed => 'পরিবর্তনগুলো সংরক্ষণ করা যায়নি।';

  @override
  String get errorSessionDuration =>
      'পড়ার সময় ১ থেকে ২৪০ মিনিটের মধ্যে হতে হবে।';

  @override
  String get errorPlanningBuffer =>
      'পরিকল্পনার বাফার ০ থেকে ৫০ শতাংশের মধ্যে হতে হবে।';

  @override
  String get errorCompletionPercent =>
      'সম্পন্নতার হার ০ থেকে ১০০ শতাংশের মধ্যে হতে হবে।';

  @override
  String get errorAvailability => 'পড়ার সময় ০ থেকে ২৪ ঘণ্টার মধ্যে হতে হবে।';

  @override
  String get errorExamDate => 'পরীক্ষার তারিখ আজকের আগে হতে পারে না।';

  @override
  String get chooseLanguage => 'আপনার ভাষা বেছে নিন';

  @override
  String get chooseLanguageSubtitle => 'সেটিংস থেকে যেকোনো সময় বদলাতে পারবেন।';

  @override
  String get banglaTitle => 'বাংলা';

  @override
  String get banglaSubtitle => 'বাংলায় পড়ার সাথী ব্যবহার করুন';

  @override
  String get englishTitle => 'English';

  @override
  String get englishSubtitle => 'ইংরেজিতে পড়ার সাথী ব্যবহার করুন';

  @override
  String get welcomeTitle => 'কী পড়বেন ভাববেন কম, পড়বেন বেশি।';

  @override
  String get welcomeBody =>
      'বিষয় আর সিলেবাস যোগ করুন, কখন পড়তে পারবেন বলুন, তারপর বাস্তবসম্মত দৈনিক পরিকল্পনা পান।';

  @override
  String get subjectsTitle => 'বিষয়';

  @override
  String get addSubject => 'বিষয় যোগ করুন';

  @override
  String get noSubjectsTitle => 'এখনও কোনো বিষয় যোগ করা হয়নি';

  @override
  String get noSubjectsBody =>
      'প্রথম বিষয় যোগ করলে পড়ার পরিকল্পনা তৈরি করা যাবে।';

  @override
  String get subjectName => 'বিষয়ের নাম';

  @override
  String get chaptersTitle => 'অধ্যায়';

  @override
  String get addChapter => 'অধ্যায় যোগ করুন';

  @override
  String get noChaptersTitle => 'এখনও কোনো অধ্যায় যোগ করা হয়নি';

  @override
  String get noChaptersBody =>
      'অধ্যায় যোগ করুন, তাহলে সিলেবাস আর পরিকল্পনা তৈরি করা যাবে।';

  @override
  String get examsTitle => 'পরীক্ষা';

  @override
  String get addExam => 'পরীক্ষা যোগ করুন';

  @override
  String get examDate => 'পরীক্ষার তারিখ';

  @override
  String daysRemaining(int count) {
    return '$count দিন বাকি';
  }

  @override
  String get studyPlan => 'পড়ার পরিকল্পনা';

  @override
  String get generatePlan => 'পরিকল্পনা তৈরি করুন';

  @override
  String get onTrack => 'ঠিক আছে';

  @override
  String get backlog => 'বাকি পড়া';

  @override
  String get revision => 'পুনরাবৃত্তি';

  @override
  String get todayStudy => 'আজকের পড়া';

  @override
  String get whyThisTask => 'কেন এই পড়া?';

  @override
  String get todayEmptyTitle => 'আজকের কোনো পড়া বাকি নেই';

  @override
  String get todayEmptyBody =>
      'সিলেবাস আর পরীক্ষার তারিখ যোগ করলে আজকের পড়া এখানে দেখা যাবে।';

  @override
  String get planEmptyBody =>
      'পরিকল্পনা তৈরি হলে দিন, সপ্তাহ আর ক্যালেন্ডার এখানে দেখা যাবে।';

  @override
  String get progressEmptyBody =>
      'সিলেবাস অগ্রগতি, পড়ার সময় আর প্রস্তুতি এখানে দেখা যাবে।';

  @override
  String get goodMorning => 'শুভ সকাল';

  @override
  String get goodAfternoon => 'শুভ বিকেল';

  @override
  String get goodEvening => 'শুভ সন্ধ্যা';

  @override
  String get goodNight => 'শুভ রাত্রি';

  @override
  String get moreTitle => 'আরও';

  @override
  String get appearanceTitle => 'চেহারা';

  @override
  String get languageTitle => 'ভাষা';

  @override
  String get studySettingsTitle => 'পড়ার সেটিংস';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get firstDayOfWeek => 'সপ্তাহের প্রথম দিন';

  @override
  String get saturday => 'শনিবার';

  @override
  String get sunday => 'রবিবার';

  @override
  String get monday => 'সোমবার';

  @override
  String get defaultSession => 'সাধারণ পড়ার সময়';

  @override
  String get planningBuffer => 'পরিকল্পনার বাফার';

  @override
  String get planningBufferHelp =>
      'একটু সময় খালি রাখলে পরিকল্পনা বাস্তবসম্মত থাকে।';

  @override
  String get autoReplan => 'স্বয়ংক্রিয় পুনঃপরিকল্পনা';

  @override
  String get autoReplanHelp =>
      'ছোট পরিবর্তন নিজে থেকে হবে। বড় পরিবর্তনের আগে আপনাকে জিজ্ঞাসা করা হবে।';

  @override
  String get settingsSaved => 'পরিবর্তন সংরক্ষিত হয়েছে';

  @override
  String durationMinutes(int count) {
    return '$count মিনিট';
  }

  @override
  String durationHours(int count) {
    return '$count ঘণ্টা';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours ঘণ্টা $minutes মিনিট';
  }

  @override
  String bufferPercent(int count) {
    return '$count%';
  }
}
