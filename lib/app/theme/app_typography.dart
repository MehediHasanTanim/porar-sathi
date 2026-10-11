import 'package:flutter/material.dart';

abstract final class AppFonts {
  static const latin = 'Inter';
  static const bengali = 'NotoSansBengali';
  static const fallback = <String>[bengali];
}

abstract final class AppTypography {
  static TextStyle _style({
    required double size,
    required FontWeight weight,
    required double height,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: AppFonts.latin,
      fontFamilyFallback: AppFonts.fallback,
      fontSize: size,
      fontWeight: weight,
      height: height,
      color: color,
    );
  }

  static TextTheme textTheme(Color color) {
    return TextTheme(
      displaySmall: _style(size: 32, weight: FontWeight.w700, height: 1.2, color: color),
      headlineMedium: _style(size: 28, weight: FontWeight.w700, height: 1.25, color: color),
      headlineSmall: _style(size: 22, weight: FontWeight.w700, height: 1.3, color: color),
      titleLarge: _style(size: 18, weight: FontWeight.w600, height: 1.35, color: color),
      titleMedium: _style(size: 16, weight: FontWeight.w600, height: 1.35, color: color),
      bodyLarge: _style(size: 16, weight: FontWeight.w400, height: 1.45, color: color),
      bodyMedium: _style(size: 15, weight: FontWeight.w400, height: 1.45, color: color),
      bodySmall: _style(size: 13, weight: FontWeight.w400, height: 1.4, color: color),
      labelLarge: _style(size: 16, weight: FontWeight.w600, height: 1.2, color: color),
      labelMedium: _style(size: 12, weight: FontWeight.w500, height: 1.2, color: color),
    );
  }
}
