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

  @override
  String onboardingProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get welcomeHeadline => 'প্রতিদিন কী পড়বেন, তা পরিষ্কার থাকবে';

  @override
  String get welcomeBenefitPlanTitle => 'প্রতিদিনের পড়ার পরিকল্পনা';

  @override
  String get welcomeBenefitPlanBody =>
      'সিলেবাস, পরীক্ষার তারিখ ও পড়ার সময় বলুন। পড়ার সাথী সেগুলো দিয়ে বাস্তবসম্মত দৈনিক পরিকল্পনা বানাবে।';

  @override
  String get welcomeBenefitSyllabusTitle => 'সিলেবাস ট্র্যাক করুন';

  @override
  String get welcomeBenefitSyllabusBody =>
      'কতটুকু শেষ, কতটুকু বাকি, তা জানা যাবে।';

  @override
  String get welcomeBenefitTrackTitle => 'পথে থাকুন';

  @override
  String get welcomeBenefitTrackBody =>
      'একদিন বাদ গেলে পরিকল্পনা নিজে থেকে মানিয়ে নেবে।';

  @override
  String get actionSetUpPlan => 'পড়ার পরিকল্পনা শুরু করি';

  @override
  String get studyTypeTitle => 'আপনি কীসের জন্য পড়ছেন?';

  @override
  String get studyTypeSubtitle => 'আপনার পড়ার ধরন অনুযায়ী সেটআপ সাজাব।';

  @override
  String get studyTypeSsc => 'এসএসসি';

  @override
  String get studyTypeSscBody => 'মাধ্যমিক স্কুল সার্টিফিকেট';

  @override
  String get studyTypeHsc => 'এইচএসসি';

  @override
  String get studyTypeHscBody => 'উচ্চ মাধ্যমিক সার্টিফিকেট';

  @override
  String get studyTypeUniversity => 'বিশ্ববিদ্যালয়';

  @override
  String get studyTypeUniversityBody => 'সেমিস্টার, মিডটার্ম বা ফাইনাল';

  @override
  String get studyTypeAdmission => 'ভর্তি পরীক্ষা';

  @override
  String get studyTypeAdmissionBody => 'বিশ্ববিদ্যালয়, মেডিকেল, ইঞ্জিনিয়ারিং';

  @override
  String get studyTypeDiploma => 'ডিপ্লোমা / পলিটেকনিক';

  @override
  String get studyTypeDiplomaBody => 'পলিটেকনিক কোর্স';

  @override
  String get studyTypeOther => 'অন্যান্য';

  @override
  String get studyTypeOtherBody => 'নিজের মতো সেটআপ';

  @override
  String get studyTypeFootnote => 'পরে এটা বদলাতে পারবেন।';

  @override
  String get profileTitle => 'আপনার সম্পর্কে একটু';

  @override
  String get profileSubtitle =>
      'এতে পরিকল্পনা আপনার মতো হবে। কোনো অ্যাকাউন্ট লাগবে না।';

  @override
  String get profileName => 'আপনাকে কী নামে ডাকব?';

  @override
  String get optionalHint => 'ঐচ্ছিক';

  @override
  String get profileYear => 'শিক্ষাবর্ষ (ঐচ্ছিক)';

  @override
  String get profileInstitution => 'প্রতিষ্ঠান (ঐচ্ছিক)';

  @override
  String get profilePrivacy => 'শুধু এই ডিভাইসে সংরক্ষিত থাকবে।';

  @override
  String get actionSkipForNow => 'এখন এড়িয়ে যান';

  @override
  String get skippedStudentName => 'শিক্ষার্থী';

  @override
  String get planTitle => 'প্রথম পড়ার পরিকল্পনা বানান';

  @override
  String get planSubtitle => 'পরে চিনতে সুবিধা হয়, এমন একটা নাম দিন।';

  @override
  String get planName => 'পরিকল্পনার নাম';

  @override
  String get planType => 'পড়ার লক্ষ্য';

  @override
  String get planStart => 'শুরুর তারিখ';

  @override
  String get planEnd => 'লক্ষ্য শেষের তারিখ';

  @override
  String get planTypeBoard => 'বোর্ড পরীক্ষা';

  @override
  String get planTypeSemester => 'সেমিস্টার';

  @override
  String get planTypeAdmission => 'ভর্তি';

  @override
  String get planTypeCustom => 'কাস্টম';

  @override
  String get examTitle => 'পরীক্ষা কবে?';

  @override
  String get examSubtitle =>
      'পরীক্ষার তারিখ দেখে প্রতিদিন কতটা পড়তে হবে, তা ঠিক হয়।';

  @override
  String get examName => 'পরীক্ষার নাম';

  @override
  String get examType => 'পরীক্ষার ধরন';

  @override
  String get examEnd => 'শেষ তারিখ';

  @override
  String get examImportance => 'গুরুত্ব';

  @override
  String get importanceNormal => 'সাধারণ';

  @override
  String get importanceImportant => 'গুরুত্বপূর্ণ';

  @override
  String get importanceVeryImportant => 'খুব গুরুত্বপূর্ণ';

  @override
  String get actionAddAnotherExam => 'আরেকটি পরীক্ষা যোগ করুন';

  @override
  String get examNoDate => 'এখনো পরীক্ষার তারিখ জানি না';

  @override
  String daysFromToday(int count) {
    return 'আজ থেকে $count দিন';
  }

  @override
  String get examTypeBoard => 'বোর্ড';

  @override
  String get examTypeMidterm => 'মিডটার্ম';

  @override
  String get examTypeFinal => 'ফাইনাল';

  @override
  String get examTypeAdmission => 'ভর্তি';

  @override
  String get examTypeCustom => 'কাস্টম';

  @override
  String get availabilityTitle => 'কোন দিনে কতক্ষণ পড়তে পারেন?';

  @override
  String get availabilitySubtitle =>
      'বাস্তবসম্মত সময় বেছে নিন। পরিকল্পনা পুরো সময় ভরিয়ে দেবে না।';

  @override
  String get preset1h => 'দিনে ১ ঘণ্টা';

  @override
  String get preset2h => 'দিনে ২ ঘণ্টা';

  @override
  String get preset3h => 'দিনে ৩ ঘণ্টা';

  @override
  String get presetCustom => 'নিজের মতো';

  @override
  String get weeklyStudyTime => 'সপ্তাহের মোট পড়ার সময়';

  @override
  String averagePerStudyDay(String duration) {
    return 'পড়ার দিনে গড়ে $duration';
  }

  @override
  String get offDay => 'বন্ধ';

  @override
  String get tuesday => 'মঙ্গলবার';

  @override
  String get wednesday => 'বুধবার';

  @override
  String get thursday => 'বৃহস্পতিবার';

  @override
  String get friday => 'শুক্রবার';

  @override
  String get studyTimeTitle => 'সাধারণত কখন পড়েন?';

  @override
  String get studyTimeSubtitle => 'এটা ঐচ্ছিক। সময় বদলালেও পরিকল্পনা চলবে।';

  @override
  String get periodMorning => 'সকাল';

  @override
  String get periodMorningTime => '৬টা – ১০টা';

  @override
  String get periodAfternoon => 'দুপুর';

  @override
  String get periodAfternoonTime => '১২টা – ৪টা';

  @override
  String get periodEvening => 'বিকেল';

  @override
  String get periodEveningTime => '৫টা – ৯টা';

  @override
  String get periodNight => 'রাত';

  @override
  String get periodNightTime => '৯টা – ১২টা';

  @override
  String get preferencesTitle => 'পড়ার সাথী কীভাবে পরিকল্পনা বানাবে?';

  @override
  String get planningMode => 'পরিকল্পনার ধরন';

  @override
  String get modeBalanced => 'ভারসাম্য';

  @override
  String get modeBalancedBody =>
      'জরুরি বিষয় মাথায় রেখে সময় বিষয়গুলোর মধ্যে ভাগ হবে।';

  @override
  String get modeWeak => 'দুর্বল বিষয়ে জোর';

  @override
  String get modeWeakBody => 'কঠিন ও কম আত্মবিশ্বাসের বিষয়ে বেশি সময়।';

  @override
  String get modeLight => 'হালকা';

  @override
  String get modeLightBody => 'প্রতিদিনের চাপ একটু কম থাকবে।';

  @override
  String get modeCrunch => 'পরীক্ষার চাপ';

  @override
  String get modeCrunchBody => 'জরুরি পরীক্ষা ও পুনরাবৃত্তি আগে আসবে।';

  @override
  String get studyIntensity => 'পড়ার তীব্রতা';

  @override
  String get intensityLight => 'হালকা';

  @override
  String get intensityNormal => 'স্বাভাবিক';

  @override
  String get intensityFocused => 'মনোযোগী';

  @override
  String get maxSession => 'একনাগাড়ে সর্বোচ্চ পড়া';

  @override
  String get revisionBuffer => 'পুনরাবৃত্তির সময়';

  @override
  String revisionDays(int count) {
    return '$count দিন';
  }

  @override
  String get actionCreatePlan => 'পরিকল্পনা তৈরি করুন';

  @override
  String get summaryTitle => 'পড়ার পরিকল্পনা তৈরি';

  @override
  String get summaryFinish => 'সিলেবাস শেষ হওয়ার সম্ভাব্য সময়';

  @override
  String get summaryFinishPending =>
      'শেষের তারিখ অনুমান করতে অধ্যায় যোগ করুন।';

  @override
  String get summaryExam => 'পরীক্ষা';

  @override
  String get summaryNoExam => 'এখনো পরীক্ষার তারিখ নেই';

  @override
  String get summaryRevisionBuffer => 'পুনরাবৃত্তির সময়';

  @override
  String get firstDays => 'প্রথম কয়েক দিন';

  @override
  String get summaryNoTasks =>
      'বিষয় ও অধ্যায় যোগ করলে প্রতিদিনের কাজ দেখা যাবে।';

  @override
  String get actionUsePlan => 'এই পরিকল্পনা ব্যবহার করি';

  @override
  String get actionAdjustAvailability => 'পড়ার সময় বদলান';

  @override
  String get notificationsTitle => 'হালকা মনে করিয়ে দিতে পারে';

  @override
  String get notificationsBody =>
      'আজকের পরিকল্পনা, পুনরাবৃত্তি ও আসন্ন পরীক্ষার কথা মনে করিয়ে দিতে পারে।';

  @override
  String get actionEnableReminders => 'রিমাইন্ডার চালু করুন';

  @override
  String get completeTitle => 'আপনি শুরু করতে প্রস্তুত';

  @override
  String get completeBody =>
      'প্রথম পরিকল্পনা তৈরি। এগোলে সেটা আপনার সাথে মিলিয়ে নেবে।';

  @override
  String get actionSeeToday => 'আজকের পড়া দেখুন';

  @override
  String get completeNoTasks => 'আজকের পড়া ভরতে বিষয় ও অধ্যায় যোগ করুন।';

  @override
  String get subjectCode => 'বিষয় কোড';

  @override
  String get paperName => 'পত্র';

  @override
  String get priority => 'অগ্রাধিকার';

  @override
  String get priorityLow => 'কম';

  @override
  String get priorityNormal => 'স্বাভাবিক';

  @override
  String get priorityHigh => 'বেশি';

  @override
  String get priorityCritical => 'খুব জরুরি';

  @override
  String get difficulty => 'কঠিনতা';

  @override
  String get difficultyEasy => 'সহজ';

  @override
  String get difficultyModerate => 'মাঝারি';

  @override
  String get difficultyHard => 'কঠিন';

  @override
  String get confidence => 'আত্মবিশ্বাস';

  @override
  String get confidenceLow => 'কম';

  @override
  String get confidenceMedium => 'মাঝারি';

  @override
  String get confidenceHigh => 'বেশি';

  @override
  String get color => 'রঙ';

  @override
  String get icon => 'আইকন';

  @override
  String get archiveSubject => 'বিষয় আর্কাইভ করুন';

  @override
  String get deleteSubject => 'বিষয় মুছুন';

  @override
  String deleteSubjectTitle(String name) {
    return '$name মুছবেন?';
  }

  @override
  String get deleteSubjectBody => 'এতে অধ্যায় ও সামনের কাজ মুছে যাবে।';

  @override
  String get deleteHistoryBody => 'পড়ার ইতিহাস আছে। সেটাও মুছবেন?';

  @override
  String get actionDelete => 'মুছুন';

  @override
  String get actionDeleteHistory => 'ইতিহাসসহ মুছুন';

  @override
  String get editSubject => 'বিষয় সম্পাদনা';

  @override
  String chaptersProgress(int done, int total) {
    return '$totalটির মধ্যে $doneটি অধ্যায়';
  }

  @override
  String get syllabusCompleted => 'সিলেবাস সম্পন্ন';

  @override
  String get chapterTitleLabel => 'অধ্যায়ের নাম';

  @override
  String get chapterNumber => 'অধ্যায় নম্বর';

  @override
  String get estimatedTime => 'আনুমানিক পড়ার সময়';

  @override
  String get chapterStatus => 'অবস্থা';

  @override
  String get notes => 'নোট';

  @override
  String get editChapter => 'অধ্যায় সম্পাদনা';

  @override
  String get bulkAddChapters => 'একসাথে কয়েকটি অধ্যায়';

  @override
  String get bulkPlaceholder => 'প্রতি লাইনে একটি অধ্যায় লিখুন';

  @override
  String createChapters(int count) {
    return '$countটি অধ্যায় তৈরি করুন';
  }

  @override
  String get filterAll => 'সব';

  @override
  String get completed => 'সম্পন্ন';

  @override
  String get inProgress => 'চলছে';

  @override
  String get notStarted => 'শুরু হয়নি';

  @override
  String get revisionDue => 'পুনরাবৃত্তি বাকি';

  @override
  String get skipped => 'বাদ দেওয়া';

  @override
  String get editExam => 'পরীক্ষা সম্পাদনা';

  @override
  String get examDateChangeWarning => 'পড়ার পরিকল্পনা হালনাগাদ লাগতে পারে।';

  @override
  String get upcomingExams => 'আসন্ন';

  @override
  String get completedExams => 'শেষ হয়েছে';

  @override
  String get noExamsTitle => 'এখনো কোনো পরীক্ষা নেই';

  @override
  String get noExamsBody =>
      'পরীক্ষার তারিখ যোগ করলে পরিকল্পনা বুঝবে আপনি কীসের জন্য তৈরি হচ্ছেন।';

  @override
  String get linkSyllabus => 'সিলেবাস যুক্ত করুন';

  @override
  String get syllabusMappingTitle => 'এই পরীক্ষায় কী আছে?';

  @override
  String get availabilityEdit => 'সাপ্তাহিক পড়ার সময়';

  @override
  String get addException => 'ব্যতিক্রম যোগ করুন';

  @override
  String get exceptionsTitle => 'ক্যালেন্ডার ব্যতিক্রম';

  @override
  String get exceptionDate => 'তারিখ';

  @override
  String get exceptionReason => 'কারণ';

  @override
  String get exceptionMinutes => 'যত মিনিট পড়া যাবে';

  @override
  String get exceptionType => 'ধরন';

  @override
  String get noStudyDay => 'পড়ার দিন নয়';

  @override
  String get reducedAvailability => 'কম সময়';

  @override
  String get extraStudyDay => 'অতিরিক্ত পড়ার দিন';

  @override
  String get saveOverride => 'সংরক্ষণ করুন';

  @override
  String get todayCapacity => 'আজকের পড়ার সময়';

  @override
  String get schedulableCapacity => 'পরিকল্পনায় বসানো যাবে';

  @override
  String get capacityBuffer => 'পরিকল্পনার বাফার';

  @override
  String get noExceptions => 'এখনো কোনো ব্যতিক্রম নেই।';

  @override
  String exceptionSaved(String duration) {
    return 'সংরক্ষিত। সেই দিন $duration পরিকল্পনায় বসানো যাবে।';
  }

  @override
  String get averageDailyStudy => 'গড় দৈনিক পড়া';

  @override
  String tasksGenerated(int count) {
    return '$countটি কাজ';
  }

  @override
  String get paceAhead => 'এগিয়ে';

  @override
  String get paceOnTrack => 'ঠিক পথে';

  @override
  String get paceSlightlyBehind => 'একটু পিছিয়ে';

  @override
  String get paceBehind => 'পিছিয়ে';

  @override
  String get paceAtRisk => 'ঝুঁকিতে';

  @override
  String get riskLabel => 'ঝুঁকি';

  @override
  String get riskNone => 'নেই';

  @override
  String get riskLow => 'কম';

  @override
  String get riskMedium => 'টাইট';

  @override
  String get riskHigh => 'বেশি';

  @override
  String get riskImpossible => 'সম্ভব নয়';

  @override
  String planShortfall(
    String requiredTime,
    String availableTime,
    String shortfallTime,
  ) {
    return 'লাগবে $requiredTime, আছে $availableTime, ঘাটতি $shortfallTime।';
  }

  @override
  String get subjectAllocation => 'বিষয়ভিত্তিক সময়';

  @override
  String get suggestionIncreaseAvailability => 'পড়ার সময় বাড়ান';

  @override
  String get suggestionIncreaseIntensity => 'দৈনিক তীব্রতা বাড়ান';

  @override
  String get suggestionReduceBuffer => 'পুনরাবৃত্তির সময় কমান';

  @override
  String get suggestionPrioritize => 'কম জরুরি অধ্যায় ঐচ্ছিক করুন';

  @override
  String get suggestionEstimates => 'আনুমানিক সময় বদলান';

  @override
  String get suggestionExamDate => 'পরীক্ষার তারিখ বদলান';
}
