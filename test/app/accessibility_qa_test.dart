import 'dart:io';
import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/app/theme/app_theme.dart';
import 'package:porar_sathi/app/widgets/primary_button.dart';
import 'package:porar_sathi/app/widgets/selection_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a selectable row exposes a button name for screen readers', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: SelectionCard(
            title: 'Physics',
            subtitle: 'On track',
            selected: true,
            onTap: () {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(SelectionCard));
    expect(semantics.label, 'Physics. On track');
    expect(semantics.flagsCollection.isButton, isTrue);
    expect(semantics.flagsCollection.isSelected, Tristate.isTrue);
  });

  testWidgets('the primary action is a named button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(reducedMotion: true),
        home: Scaffold(
          body: PrimaryButton(label: 'Start studying', onPressed: () {}),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Start studying'), findsOneWidget);
    final semantics = tester.getSemantics(find.byType(FilledButton));
    expect(semantics.flagsCollection.isButton, isTrue);
  });

  test('phones stay portrait and iPad keeps its wider orientations', () {
    final android = File('android/app/src/main/AndroidManifest.xml')
        .readAsStringSync();
    final ios = File('ios/Runner/Info.plist').readAsStringSync();
    expect(android, contains('android:screenOrientation="portrait"'));
    expect(
      ios,
      contains(
        '<key>UISupportedInterfaceOrientations</key>\n'
        '\t<array>\n'
        '\t\t<string>UIInterfaceOrientationPortrait</string>\n'
        '\t</array>',
      ),
    );
    expect(ios, contains('UIInterfaceOrientationLandscapeLeft'));
    expect(ios, contains('UISupportedInterfaceOrientations~ipad'));
  });
}
