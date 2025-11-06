import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightScaffold,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardColor: AppColors.lightBackground,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14),
      titleMedium: TextStyle(
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkScaffold,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkScaffold,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    cardColor: AppColors.darkBackground,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
      titleMedium: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
