import 'package:amk_bank_project/core/shared/app_font.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Import your AppColors class

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
    fontFamily: AppFont.fontFamily,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: _getTextTheme(false),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      titleTextStyle: AppFont.bold(
        color: AppColors.onPrimaryLight,
        fontSizeValue: 20,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: _darkColorScheme,
    fontFamily: AppFont.fontFamily,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: _getTextTheme(true),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      titleTextStyle: AppFont.bold(
        color: AppColors.onPrimaryDark,
        fontSizeValue: 20,
      ),
    ),
  );

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryLight,
    onPrimary: AppColors.onPrimaryLight,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.onPrimaryLight,
    error: AppColors.errorLight,
    onError: AppColors.onErrorLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onSurfaceLight,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryDark,
    onPrimary: AppColors.onPrimaryDark,
    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.onPrimaryDark,
    error: AppColors.errorDark,
    onError: AppColors.onErrorDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
  );

  static TextTheme _getTextTheme(bool isDark) {
    double fontSize = 16;
    final color = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return TextTheme(
      displayLarge: AppFont.bold(fontSizeValue: fontSize + 41, color: color),
      displayMedium: AppFont.bold(fontSizeValue: fontSize + 29, color: color),
      displaySmall: AppFont.bold(fontSizeValue: fontSize + 20, color: color),
      headlineLarge: AppFont.bold(fontSizeValue: fontSize + 16, color: color),
      headlineMedium: AppFont.bold(fontSizeValue: fontSize + 12, color: color),
      headlineSmall: AppFont.bold(fontSizeValue: fontSize + 8, color: color),
      titleLarge: AppFont.semiBold(fontSizeValue: fontSize + 6, color: color),
      titleMedium: AppFont.semiBold(fontSizeValue: fontSize, color: color),
      titleSmall: AppFont.semiBold(fontSizeValue: fontSize - 2, color: color),
      bodyLarge: AppFont.regular(fontSizeValue: fontSize, color: color),
      bodyMedium: AppFont.regular(fontSizeValue: fontSize - 2, color: color),
      bodySmall: AppFont.regular(fontSizeValue: fontSize - 4, color: color),
      labelLarge: AppFont.medium(fontSizeValue: fontSize - 2, color: color),
      labelMedium: AppFont.medium(fontSizeValue: fontSize - 4, color: color),
      labelSmall: AppFont.medium(fontSizeValue: fontSize - 5, color: color),
    );
  }
}
