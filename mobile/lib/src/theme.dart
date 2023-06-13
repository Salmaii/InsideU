import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF011C2E);
  static const primaryLight = Color(0xff2c4357);
  static const primaryDark = Color(0xff000005);
  static const textLight = Color(0xffffffff);
  static const text = Color(0xffffffff);
  static const secondary = Color(0xffeeb210);
  static const divider = Color(0xff718792);
}

OutlinedButtonThemeData get _outlineButtonTheme => OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary)),
    );

ThemeData getTheme() {
  final theme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      outlinedButtonTheme: _outlineButtonTheme,
      colorScheme: const ColorScheme.light()
          .copyWith(
              primary: AppColors.primary,
              onPrimary: AppColors.textLight,
              primaryContainer: AppColors.primaryDark,
              onPrimaryContainer: AppColors.text,
              secondary: AppColors.secondary,
              onTertiary: AppColors.textLight)
          .copyWith(background: AppColors.primary));
  return theme;
}

const title =
    TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.black);
