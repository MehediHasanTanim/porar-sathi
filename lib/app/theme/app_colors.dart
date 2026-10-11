import 'package:flutter/material.dart';

/// Semantic colors from the UX boards. Status never relies on color alone.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.muted,
    required this.outline,
    required this.primaryContainer,
    required this.canvas,
  });

  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final Color muted;
  final Color outline;
  final Color primaryContainer;
  final Color canvas;

  static const light = AppSemanticColors(
    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    danger: Color(0xFFDC3E3E),
    info: Color(0xFF2F6FED),
    muted: Color(0xFF667085),
    outline: Color(0xFFE4E9F2),
    primaryContainer: Color(0xFFE8F0FF),
    canvas: Color(0xFFF4F7FB),
  );

  static const dark = AppSemanticColors(
    success: Color(0xFF4ADE80),
    warning: Color(0xFFFBBF24),
    danger: Color(0xFFF87171),
    info: Color(0xFF8EB4FF),
    muted: Color(0xFF98A2B3),
    outline: Color(0xFF2A3344),
    primaryContainer: Color(0xFF1C2C4E),
    canvas: Color(0xFF0E1218),
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? muted,
    Color? outline,
    Color? primaryContainer,
    Color? canvas,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
      muted: muted ?? this.muted,
      outline: outline ?? this.outline,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      canvas: canvas ?? this.canvas,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) {
      return this;
    }
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      canvas: Color.lerp(canvas, other.canvas, t)!,
    );
  }
}

abstract final class AppPalette {
  static const primary = Color(0xFF2F6FED);
  static const primaryDark = Color(0xFF8EB4FF);
  static const secondary = Color(0xFF12B981);
  static const onSurface = Color(0xFF1B2430);
  static const onSurfaceDark = Color(0xFFF4F7FB);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF171C25);
}

extension AppSemanticColorsContext on BuildContext {
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>() ?? AppSemanticColors.light;
}
