// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xff6C63FF);
  static const primaryLight = Color(0xFFDDDEFB);
  static const background = Color(0xFFF4F5FF);
  static const cardBg = Color(0xFFE8E9F8);
  static const white = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF8A8AB0);
  static const navBg = Color(0xFF5B5FEF);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
    );
  }
}
