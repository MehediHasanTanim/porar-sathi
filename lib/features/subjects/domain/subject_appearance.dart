import 'package:flutter/material.dart';

/// Color and icon tokens stored on a subject. The syllabus board uses these
/// hues for Physics, Chemistry, Math, Biology, Bangla, and English.
abstract final class SubjectAppearance {
  static const colorTokens = [
    'blue',
    'green',
    'orange',
    'teal',
    'pink',
    'purple',
    'red',
  ];

  static const iconTokens = [
    'science',
    'biotech',
    'calculate',
    'menu_book',
    'translate',
    'language',
    'school',
  ];

  static Color colorFor(String token) {
    return switch (token) {
      'green' => const Color(0xFF12B981),
      'orange' => const Color(0xFFF59E0B),
      'teal' => const Color(0xFF14B8A6),
      'pink' => const Color(0xFFEC4899),
      'purple' => const Color(0xFF7C5CFC),
      'red' => const Color(0xFFEF4444),
      _ => const Color(0xFF2F6FED),
    };
  }

  static IconData iconFor(String token) {
    return switch (token) {
      'biotech' => Icons.biotech,
      'calculate' => Icons.calculate_outlined,
      'menu_book' => Icons.menu_book_outlined,
      'translate' => Icons.translate,
      'language' => Icons.language,
      'school' => Icons.school_outlined,
      _ => Icons.science_outlined,
    };
  }
}
