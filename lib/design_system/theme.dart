import 'package:flutter/material.dart';
import 'package:shopwithme/design_system/buttons.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/borders.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.labelLarge,
        labelSmall: AppTypography.labelSmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonType.primary.style,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonType.outline.style,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonType.text.style,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppBorders.roundedSm,
          borderSide: const BorderSide(color: AppColors.neutral),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorders.roundedSm,
          borderSide: const BorderSide(color: AppColors.neutral),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorders.roundedSm,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppBorders.roundedSm,
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.roundedMd,
        ),
      ),
    );
  }
} 