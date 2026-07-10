import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4D41DF);
  static const Color primaryDark = Color(0xFF3622CA);
  static const Color primaryContainer = Color(0xFF675DF9);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF59579A);
  static const Color secondaryContainer = Color(0xFFB7B4FF);

  static const Color background = Color(0xFFFCF8FF);
  static const Color surface = Color(0xFFFCF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F2FF);
  static const Color surfaceContainer = Color(0xFFF0ECF9);
  static const Color surfaceContainerHigh = Color(0xFFEAE6F3);
  static const Color surfaceContainerHighest = Color(0xFFE4E1EE);

  static const Color onSurface = Color(0xFF1B1B24);
  static const Color onSurfaceVariant = Color(0xFF464555);
  static const Color outline = Color(0xFF777587);
  static const Color outlineVariant = Color(0xFFC7C4D8);

  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryContainer],
  );

  static const LinearGradient loginGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );
}