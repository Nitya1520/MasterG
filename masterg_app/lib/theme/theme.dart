import 'package:flutter/material.dart';

class AppTheme {
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient accentGradient = LinearGradient(
    colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient flameGradient = LinearGradient(
    colors: [Color(0xFFF97316), Color(0xFFEF4444)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient goldGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient warmGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const double cardRadius = 22.0;
  static const double buttonRadius = 14.0;
  static const double inputRadius = 14.0;

  static final BorderRadius cardBorderRadius = BorderRadius.circular(cardRadius);
  static final BorderRadius buttonBorderRadius = BorderRadius.circular(buttonRadius);
  static final BorderRadius inputBorderRadius = BorderRadius.circular(inputRadius);

  static List<BoxShadow> getCardShadow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.25)
            : const Color(0xFF6366F1).withValues(alpha: 0.08),
        blurRadius: 20.0,
        spreadRadius: 0,
        offset: const Offset(0, 8),
      ),
    ];
  }

  static List<BoxShadow> getSoftShadow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.15)
            : Colors.black.withValues(alpha: 0.04),
        blurRadius: 12.0,
        offset: const Offset(0, 4),
      ),
    ];
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        primary: const Color(0xFF6366F1),
        secondary: const Color(0xFF8B5CF6),
        tertiary: const Color(0xFFEC4899),
        surface: Colors.white,
        error: const Color(0xFFEF4444),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: cardBorderRadius,
          side: BorderSide(color: const Color(0xFFE2E8F0).withValues(alpha: 0.8), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
          backgroundColor: const Color(0xFF6366F1),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF1E293B)),
        titleTextStyle: TextStyle(
          color: Color(0xFF1E293B),
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w800, fontSize: 30, letterSpacing: -0.5),
        headlineMedium: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w700, fontSize: 24, letterSpacing: -0.2),
        titleLarge: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.w700, fontSize: 20),
        titleMedium: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w600, fontSize: 16),
        bodyLarge: TextStyle(color: Color(0xFF475569), fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(color: Color(0xFF64748B), fontSize: 14),
        bodySmall: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xFF8B5CF6),
        primary: const Color(0xFF818CF8),
        secondary: const Color(0xFFA78BFA),
        tertiary: const Color(0xFFF472B6),
        surface: const Color(0xFF1E293B),
        error: const Color(0xFFF87171),
      ),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: cardBorderRadius,
          side: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(borderRadius: inputBorderRadius, borderSide: const BorderSide(color: Color(0xFF334155), width: 1.5)),
        enabledBorder: OutlineInputBorder(borderRadius: inputBorderRadius, borderSide: const BorderSide(color: Color(0xFF334155), width: 1.5)),
        focusedBorder: OutlineInputBorder(borderRadius: inputBorderRadius, borderSide: const BorderSide(color: Color(0xFF818CF8), width: 2.0)),
        errorBorder: OutlineInputBorder(borderRadius: inputBorderRadius, borderSide: const BorderSide(color: Color(0xFFF87171), width: 1.5)),
        hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 15),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
          backgroundColor: const Color(0xFF818CF8),
          foregroundColor: const Color(0xFF0F172A),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30, letterSpacing: -0.5),
        headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24, letterSpacing: -0.2),
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        titleMedium: TextStyle(color: Color(0xFFE2E8F0), fontWeight: FontWeight.w600, fontSize: 16),
        bodyLarge: TextStyle(color: Color(0xFFCBD5E1), fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
        bodySmall: TextStyle(color: Color(0xFF64748B), fontSize: 12),
      ),
    );
  }
}
