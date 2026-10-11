import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/app/theme/app_theme.dart';
import 'package:porar_sathi/app/widgets/app_states.dart';
import 'package:porar_sathi/app/widgets/empty_state.dart';
import 'package:porar_sathi/features/settings/data/settings_repository_provider.dart';
import 'package:porar_sathi/features/settings/data/shared_preferences_settings_repository.dart';
import 'package:porar_sathi/features/settings/presentation/study_settings_screen.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Bangla study settings stay readable at large text', (tester) async {
    SharedPreferences.setMockInitialValues({'language': 'bn'});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesSettingsRepository(preferences);

    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          locale: const Locale('bn'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.6),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
          home: const StudySettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('পড়ার সেটিংস'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('পুনরাবৃত্তির নিয়ম'), 300);
    expect(find.text('পুনরাবৃত্তির নিয়ম'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('দিনে সর্বোচ্চ পড়া'), 300);
    expect(find.text('দিনে সর্বোচ্চ পড়া'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('স্বয়ংক্রিয় পুনঃপরিকল্পনা'), 300);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shared states scroll instead of overflowing in Bangla', (tester) async {
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
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(2),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const Scaffold(
          body: Column(
            children: [
              Expanded(
                child: EmptyState(
                  icon: Icons.menu_book_outlined,
                  title: 'এখনো কোনো বিষয় নেই',
                  body: 'প্রথম বিষয় যোগ করলে পড়ার পরিকল্পনা তৈরি করা যাবে।',
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('এখনো কোনো বিষয় নেই'), findsOneWidget);
    expect(find.byType(MigrationState), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('bn'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(reducedMotion: true),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(2),
              disableAnimations: true,
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const Scaffold(body: MigrationState()),
      ),
    );
    await tester.pump();
    expect(find.textContaining('পড়ার সাথী আপডেট হচ্ছে'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
