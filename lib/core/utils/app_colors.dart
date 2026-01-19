import 'package:flutter/material.dart';

class AppColors {
  // Secondary Colors
  static const Color secondaryLight = Color(0xFF3498DB);
  static const Color secondaryDark = Color(0xFF3498DB);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF1E1E1E);

  // Surface Colors
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF2C2C2C);

  // Error Colors
  static const Color errorLight = Colors.red;
  static const Color errorDark = Colors.redAccent;

  // Text Colors
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.white;

  static const Color onBackgroundLight = Colors.black;
  static const Color onBackgroundDark = Colors.white;

  static const Color onSurfaceLight = Colors.black;
  static const Color onSurfaceDark = Colors.white;

  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Colors.black;

  // Custom AMK Colors
  static const Color amkPrimary = Color(0xFF983256); // Approximate AMK Red/Pink
  static const Color amkLightPink = Color(0xFFFFEBF0);
  static const Color amkGray = Color(0xFFBDBDBD);
  static const Color amkGradientStart = Color(0xFFB03A5B);
  static const Color amkGradientEnd = Color(0xFF702336);

  static const Color white = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFFA53C6F);

  // Primary Colors - Custom brand color
  static const Color primaryLight = Color(0xFFD96FA0);
  static const Color primaryDark = Color(0xFF7A2A51);

  // Gradient Background Colors
  static const Color gradientStart = Color(0xFFB33071);
  static const Color gradientEnd = Color(0xFF852454);

  // Background Colors
  static const Color background = Color(0xFFF0F0F3);
  static const Color screenBackground =
      Color(0xFFFFF3F9); // Very light pink for screens
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F0F0);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF2196F3);

  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1F000000);

  // Button Colors
  static const Color buttonPrimary = primary;
  static const Color buttonDisabled = Color(0xFFA5A5A5);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocus = primary;

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkScreenBackground =
      Color(0xFF2D1A26); // Dark pink-tinted background for screens
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  // Account Type Colors
  static const Color checkingAccount = Color(0xFF1976D2);
  static const Color savingsAccount = Color(0xFF388E3C);
  static const Color creditCard = Color(0xFFD32F2F);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Color? grey = Color(0xFFBDBDBD);
}
