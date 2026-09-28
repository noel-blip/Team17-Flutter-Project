import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color accent = Color(0xFFD63A2F);
  static const Color lightBackground = Color(0xFFF6F6F2);
  static const Color lightText = Color(0xFF111111);
  static const Color darkBackground = Color(0xFF101010);
  static const Color darkText = Color(0xFFF5F5F3);

  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: lightBackground,
        foreground: lightText,
        secondary: const Color(0xFF6F6F6B),
        divider: const Color(0xFFC9C9C3),
        buttonBackground: lightText,
        buttonForeground: lightBackground,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: darkBackground,
        foreground: darkText,
        secondary: const Color(0xFFA8A8A3),
        divider: const Color(0xFF353535),
        buttonBackground: const Color(0xFFF0F0EC),
        buttonForeground: const Color(0xFF111111),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color foreground,
    required Color secondary,
    required Color divider,
    required Color buttonBackground,
    required Color buttonForeground,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
    ).copyWith(
      primary: accent,
      error: accent,
      surface: background,
      onSurface: foreground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      dividerColor: divider,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      textTheme: TextTheme(
        displaySmall: TextStyle(
          color: foreground,
          fontSize: 34,
          height: 1.05,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
        ),
        bodyLarge: TextStyle(
          color: foreground,
          fontSize: 16,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: secondary,
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
        labelMedium: TextStyle(
          color: secondary,
          fontSize: 12,
          height: 1.2,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        labelSmall: TextStyle(
          color: secondary,
          fontSize: 11,
          height: 1.2,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBackground,
          foregroundColor: buttonForeground,
          elevation: 0,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondary,
          textStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
