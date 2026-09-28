import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color accent = Color(0xFFD63A2F);
  static const Color lightBackground = Color(0xFFF6F6F2);
  static const Color lightText = Color(0xFF111111);
  static const Color darkBackground = Color(0xFF101010);
  static const Color darkText = Color(0xFFF2F0EA);

  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: lightBackground,
        foreground: lightText,
        buttonBackground: lightText,
        buttonForeground: lightBackground,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: darkBackground,
        foreground: darkText,
        buttonBackground: darkText,
        buttonForeground: darkBackground,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color foreground,
    required Color buttonBackground,
    required Color buttonForeground,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
    ).copyWith(
      primary: accent,
      surface: background,
      error: accent,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
            bodyColor: foreground,
            displayColor: foreground,
          ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: foreground.withValues(alpha: 0.24),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: accent, width: 1.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: accent),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: accent, width: 1.5),
        ),
        labelStyle: TextStyle(
          color: foreground.withValues(alpha: 0.64),
        ),
        floatingLabelStyle: const TextStyle(color: accent),
        errorStyle: const TextStyle(color: accent),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          elevation: 0,
          backgroundColor: buttonBackground,
          foregroundColor: buttonForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.15,
          ),
        ),
      ),
    );
  }
}
