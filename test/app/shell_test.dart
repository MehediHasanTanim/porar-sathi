import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/app/app.dart';
import 'package:porar_sathi/app/theme/app_typography.dart';
import 'package:porar_sathi/features/settings/data/settings_repository_provider.dart';
import 'package:porar_sathi/features/settings/data/shared_preferences_settings_repository.dart';
import 'package:porar_sathi/features/settings/domain/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('language and theme switch without restarting', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesSettingsRepository(
      preferences,
      deviceLocale: const Locale('en'),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(repository),
        ],
        child: const PorarSathiApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Choose your language'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.text('Choose your language'))).textTheme.bodyMedium?.fontFamilyFallback,
      contains(AppFonts.bengali),
    );

    await tester.tap(find.text('বাংলা'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('চালিয়ে যান'), findsOneWidget);

    await tester.tap(find.text('চালিয়ে যান'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('আজ'), findsOneWidget);

    await tester.tap(find.text('আরও'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    await tester.tap(find.text('চেহারা'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    await tester.tap(find.text('ডার্ক'));
    await tester.pumpAndSettle();

    final context = tester.element(find.text('ডার্ক'));
    expect(Theme.of(context).brightness, Brightness.dark);

    final stored = await repository.load();
    expect(stored.language, AppLanguage.bangla);
    expect(stored.theme, AppThemePreference.dark);
    expect(stored.onboardingComplete, isTrue);
  });
}
