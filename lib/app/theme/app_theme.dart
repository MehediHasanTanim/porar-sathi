import 'package:flutter/material.dart';

import 'package:porar_sathi/app/theme/app_colors.dart';
import 'package:porar_sathi/app/theme/app_spacing.dart';
import 'package:porar_sathi/app/theme/app_typography.dart';

abstract final class AppTheme {
  static ThemeData light({bool reducedMotion = false}) => _build(
    brightness: Brightness.light,
    semantic: AppSemanticColors.light,
    reducedMotion: reducedMotion,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppPalette.primary,
      onPrimary: Colors.white,
      secondary: Color(0xFF047857),
      onSecondary: Colors.white,
      error: Color(0xFFC62828),
      onError: Colors.white,
      surface: AppPalette.surface,
      onSurface: AppPalette.onSurface,
    ),
  );

  static ThemeData dark({bool reducedMotion = false}) => _build(
    brightness: Brightness.dark,
    semantic: AppSemanticColors.dark,
    reducedMotion: reducedMotion,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppPalette.primaryDark,
      onPrimary: Color(0xFF0E1218),
      secondary: Color(0xFF34D399),
      onSecondary: Color(0xFF0E1218),
      error: Color(0xFFF87171),
      onError: Color(0xFF0E1218),
      surface: AppPalette.surfaceDark,
      onSurface: AppPalette.onSurfaceDark,
    ),
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppSemanticColors semantic,
    required ColorScheme colorScheme,
    required bool reducedMotion,
  }) {
    final textTheme = AppTypography.textTheme(colorScheme.onSurface);
    final radius = BorderRadius.circular(AppSpacing.radiusMd);
    final outline = BorderSide(color: semantic.outline);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: semantic.canvas,
      fontFamily: AppFonts.latin,
      fontFamilyFallback: AppFonts.fallback,
      textTheme: textTheme,
      extensions: [semantic],
      pageTransitionsTheme: reducedMotion
          ? const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: NoMotionPageTransitionsBuilder(),
                TargetPlatform.iOS: NoMotionPageTransitionsBuilder(),
                TargetPlatform.macOS: NoMotionPageTransitionsBuilder(),
                TargetPlatform.linux: NoMotionPageTransitionsBuilder(),
                TargetPlatform.windows: NoMotionPageTransitionsBuilder(),
                TargetPlatform.fuchsia: NoMotionPageTransitionsBuilder(),
              },
            )
          : const PageTransitionsTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: semantic.canvas,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: outline,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, AppSpacing.buttonHeight),
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, AppSpacing.buttonHeight),
          foregroundColor: colorScheme.onSurface,
          textStyle: textTheme.labelLarge,
          side: outline,
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppPalette.primary,
          textStyle: textTheme.labelLarge,
          minimumSize: const Size(48, AppSpacing.minTapTarget),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface,
        selectedColor: semantic.primaryContainer,
        disabledColor: semantic.canvas,
        side: outline,
        labelStyle: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface),
        secondaryLabelStyle: textTheme.bodySmall,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: semantic.muted),
        labelStyle: textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: outline,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: outline,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppPalette.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppPalette.primary;
          }
          return null;
        }),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: colorScheme.surface,
        indicatorColor: semantic.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium?.copyWith(
            color: selected ? AppPalette.primary : semantic.muted,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppPalette.primary : semantic.muted,
            size: 24,
          );
        }),
      ),
      dividerTheme: DividerThemeData(color: semantic.outline, space: 1),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppPalette.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    );
  }
}

/// Route change with no slide or fade.
class NoMotionPageTransitionsBuilder extends PageTransitionsBuilder {
  const NoMotionPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
