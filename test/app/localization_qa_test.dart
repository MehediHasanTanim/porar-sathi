import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:porar_sathi/app/localization/locale_format.dart';
import 'package:porar_sathi/app/theme/app_theme.dart';
import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/features/settings/data/settings_repository_provider.dart';
import 'package:porar_sathi/features/settings/data/shared_preferences_settings_repository.dart';
import 'package:porar_sathi/features/settings/presentation/study_settings_screen.dart';
import 'package:porar_sathi/features/subjects/domain/subject.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';
import 'package:porar_sathi/features/syllabus/domain/syllabus_query.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('English and Bangla use the same message keys', () {
    final english = jsonDecode(
      File('lib/l10n/app_en.arb').readAsStringSync(),
    ) as Map<String, dynamic>;
    final bangla = jsonDecode(
      File('lib/l10n/app_bn.arb').readAsStringSync(),
    ) as Map<String, dynamic>;
    final englishKeys = english.keys
        .where((key) => !key.startsWith('@'))
        .toSet();
    final banglaKeys = bangla.keys.where((key) => !key.startsWith('@')).toSet();
    expect(banglaKeys, englishKeys);
    for (final key in banglaKeys) {
      expect(bangla[key], isA<String>());
      expect((bangla[key] as String).trim(), isNotEmpty);
      expect((english[key] as String).trim(), isNotEmpty);
    }
  });

  test('dates and numbers follow the active locale', () async {
    await initializeDateFormatting('en');
    await initializeDateFormatting('bn');
    final date = DateTime(2026, 10, 11);
    expect(
      LocaleFormat.formatDate(date, const Locale('en')),
      contains('October'),
    );
    expect(
      LocaleFormat.formatDate(date, const Locale('bn')),
      contains('অক্টোবর'),
    );
    expect(LocaleFormat.formatNumber(1200, const Locale('en')), '1,200');
    expect(
      LocaleFormat.formatNumber(1200, const Locale('bn')),
      matches(RegExp('[০-৯]')),
    );
  });

  test(
    'a mixed Bangla and English subject name is searchable in either language',
    () {
      final today = DateTime(2026, 10, 11);
      final subject = Subject(
        id: 'physics',
        studyPlanId: 'plan',
        name: 'Physics পদার্থবিজ্ঞান',
        colorToken: 'physics',
        iconToken: 'physics',
        priority: Priority.normal,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        status: SubjectStatus.active,
        sortOrder: 0,
        createdAt: today,
        updatedAt: today,
      );
      final chapter = Chapter(
        id: 'motion',
        subjectId: subject.id,
        title: 'Motion গতি',
        estimatedMinutes: 60,
        completedMinutes: 0,
        difficulty: Difficulty.moderate,
        confidence: Confidence.medium,
        priority: Priority.normal,
        examImportance: Priority.normal,
        status: ChapterStatus.notStarted,
        sortOrder: 0,
        createdAt: today,
        updatedAt: today,
      );
      final chapters = {
        subject.id: [chapter],
      };
      expect(
        searchSyllabus(
          subjects: [subject],
          chaptersBySubject: chapters,
          query: const SyllabusQuery(text: 'Physics'),
        ).single.subject.id,
        'physics',
      );
      expect(
        searchSyllabus(
          subjects: [subject],
          chaptersBySubject: chapters,
          query: const SyllabusQuery(text: 'পদার্থ'),
        ).single.subject.id,
        'physics',
      );
      expect(
        searchSyllabus(
          subjects: [subject],
          chaptersBySubject: chapters,
          query: const SyllabusQuery(text: 'গতি'),
        ).single.chapters.single.title,
        'Motion গতি',
      );
    },
  );

  testWidgets('English study settings use the English title', (tester) async {
    SharedPreferences.setMockInitialValues({'language': 'en'});
    final preferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(
            SharedPreferencesSettingsRepository(preferences),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light(),
          home: const StudySettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Study Settings'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a long Bangla label stays inside a narrow large-text layout', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('bn'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(2)),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: Scaffold(
          body: ListView(
            children: const [
              Text(
                'পড়ার সাথীতে আজকের পরিকল্পনা, পুনরাবৃত্তি, এবং পরীক্ষার প্রস্তুতি একসাথে দেখা যাচ্ছে।',
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
