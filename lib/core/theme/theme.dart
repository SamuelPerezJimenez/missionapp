import 'package:flutter/material.dart';

EdgeInsetsGeometry pagePadding = const EdgeInsets.symmetric(horizontal: 32);

class AppTheme {
  AppTheme._();

  // Colores base
  static const Color primaryColor = Color(0xFF373D58);
  static const Color backgroundColor = Color(0xFFE7E5E5);

  // Colores complementarios
  static const Color secondaryColor = Color(0xFF6F7D8C);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onBackgroundColor = Color(0xFF373D58);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      iconTheme: IconThemeData(
        color: onPrimaryColor,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: secondaryColor,
      onSecondary: onPrimaryColor,
      onError: onPrimaryColor,
      error: errorColor,
      onBackground: onBackgroundColor,
      background: backgroundColor,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: onBackgroundColor),
      bodyMedium: TextStyle(color: onBackgroundColor),
    ),
  );
}
