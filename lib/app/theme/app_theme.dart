import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/config/app_environment.dart';
import '../../core/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData build(AppEnvironment environment) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryRose,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primaryRose,
      onPrimary: Colors.white,
      secondary: AppColors.primaryRoseDark,
      surface: Colors.white,
      onSurface: AppColors.textPrimary,
      outline: AppColors.border,
      error: AppColors.danger,
    );
    final textTheme = GoogleFonts.promptTextTheme(
      const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.15,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          height: 1.45,
        ),
        labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.prompt().fontFamily,
      scaffoldBackgroundColor: AppColors.canvas,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: GoogleFonts.prompt(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        shadowColor: AppColors.primaryRose.withValues(alpha: 0.08),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: EdgeInsets.zero,
      ),
      dividerColor: AppColors.border,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryRose,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryRoseDark,
          side: const BorderSide(color: AppColors.border),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.roseTint,
        selectedColor: AppColors.primaryRose,
        secondarySelectedColor: AppColors.primaryRose,
        labelStyle: const TextStyle(
          color: AppColors.primaryRoseDark,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      extensions: <ThemeExtension<dynamic>>[
        _EnvironmentTheme(isProduction: environment.isProduction),
      ],
    );
  }
}

class _EnvironmentTheme extends ThemeExtension<_EnvironmentTheme> {
  const _EnvironmentTheme({required this.isProduction});

  final bool isProduction;

  @override
  ThemeExtension<_EnvironmentTheme> copyWith({bool? isProduction}) {
    return _EnvironmentTheme(isProduction: isProduction ?? this.isProduction);
  }

  @override
  ThemeExtension<_EnvironmentTheme> lerp(
    covariant ThemeExtension<_EnvironmentTheme>? other,
    double t,
  ) {
    if (other is! _EnvironmentTheme) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}
