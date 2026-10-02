import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/core.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final primary = AppConfig.primaryColor;
    final background = AppConfig.scaffoldBackground;

    final baseTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
    );

    // Apply Google Font Kantumruy Pro for crisp English and Khmer typography
    return baseTheme.copyWith(
      textTheme: GoogleFonts.kantumruyProTextTheme(baseTheme.textTheme),
    );
  }

  static ThemeData get darkTheme {
    final primary = AppConfig.primaryColor;

    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        brightness: Brightness.dark,
        surface: const Color(0xFF1E1E1E),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey.shade500,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.kantumruyProTextTheme(baseTheme.textTheme),
    );
  }
}
