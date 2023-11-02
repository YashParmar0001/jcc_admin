
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/theme/texts.dart';

class AppTheme {
  static ThemeData getTheme(){
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.darkMidnightBlue),
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: const TextTheme(
        displayLarge: AppTexts.displayLarge,
        displayMedium: AppTexts.displayMedium,
        headlineLarge: AppTexts.headlineLarge,
        headlineMedium: AppTexts.headlineMedium,
        headlineSmall: AppTexts.headlineSmall,
        titleLarge: AppTexts.titleLarge,
        titleMedium: AppTexts.titleMedium,
      ),
    );
  }
}