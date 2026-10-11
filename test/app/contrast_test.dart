import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porar_sathi/app/theme/app_colors.dart';

void main() {
  test('status and text colors meet WCAG AA on their surfaces', () {
    final pairs = [
      (AppSemanticColors.light.success, Colors.white, 4.5),
      (AppSemanticColors.light.warning, Colors.white, 4.5),
      (AppSemanticColors.light.danger, Colors.white, 4.5),
      (AppSemanticColors.light.muted, Colors.white, 4.5),
      (AppPalette.primary, Colors.white, 4.5),
      (AppPalette.onSurface, Colors.white, 4.5),
      (Colors.white, const Color(0xFF047857), 4.5),
      (AppSemanticColors.dark.success, AppPalette.surfaceDark, 4.5),
      (AppSemanticColors.dark.warning, AppPalette.surfaceDark, 4.5),
      (AppSemanticColors.dark.danger, AppPalette.surfaceDark, 4.5),
      (AppSemanticColors.dark.muted, AppPalette.surfaceDark, 4.5),
      (AppPalette.onSurfaceDark, AppPalette.surfaceDark, 4.5),
    ];

    for (final (foreground, background, minimum) in pairs) {
      expect(
        _contrast(foreground, background),
        greaterThanOrEqualTo(minimum),
        reason: '$foreground on $background',
      );
    }
  });
}

double _contrast(Color foreground, Color background) {
  final lighter = _luminance(foreground) > _luminance(background)
      ? foreground
      : background;
  final darker = lighter == foreground ? background : foreground;
  return (_luminance(lighter) + 0.05) / (_luminance(darker) + 0.05);
}

double _luminance(Color color) {
  double channel(double value) {
    return value <= 0.04045
        ? value / 12.92
        : math.pow((value + 0.055) / 1.055, 2.4).toDouble();
  }

  final red = channel(color.r);
  final green = channel(color.g);
  final blue = channel(color.b);
  return 0.2126 * red + 0.7152 * green + 0.0722 * blue;
}
