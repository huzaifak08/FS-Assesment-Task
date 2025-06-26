import 'package:flutter/material.dart';
import 'package:fs_task_assesment/helpers/colors.dart';

final TextTheme lightTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
  labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  ),
  labelSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  ),
);

final TextTheme darkTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  ),
  labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  ),
  labelSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  ),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.grey,
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    tertiary: Colors.grey[100],
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black, // Black text for app bar
    elevation: 0,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.primaryColor,
    cursorColor: Colors.grey,
    selectionHandleColor: AppColors.primaryColor,
  ),
  textTheme: lightTextTheme,
  iconTheme: IconThemeData(
    color: AppColors.primaryColor, // Icon color
  ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.grey,
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    secondary: Colors.white,
    tertiary: Colors.grey[800],
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white, // White text for app bar
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.primaryColor,
    cursorColor: Colors.white,
    selectionHandleColor: AppColors.primaryColor,
  ),
  textTheme: darkTextTheme,
  iconTheme: IconThemeData(
    color: AppColors.primaryColor, // Icon color
  ),
);
