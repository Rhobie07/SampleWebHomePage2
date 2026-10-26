import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData build() {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.forest,
        primary: AppColors.forest,
        surface: AppColors.cream,
        onSurface: AppColors.ink,
      ),
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: const TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 112,
          height: .95,
          fontWeight: FontWeight.w400,
          letterSpacing: -3,
          color: AppColors.ink,
        ),
        headlineLarge: const TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 64,
          height: 1.02,
          fontWeight: FontWeight.w400,
          letterSpacing: -1.8,
          color: AppColors.ink,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 34,
          height: 1.12,
          fontWeight: FontWeight.w400,
          letterSpacing: -.5,
          color: AppColors.ink,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 16,
          height: 1.85,
          color: AppColors.muted,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 14,
          height: 1.75,
          color: AppColors.muted,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: .55),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        labelStyle: const TextStyle(fontSize: 13, color: AppColors.muted),
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.olive, width: 2),
        ),
      ),
      dividerColor: AppColors.line,
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
