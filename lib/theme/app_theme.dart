import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const _lightPrimaryColor = Colors.indigo;
  static const _lightScaffoldBackground = Color(0xFFFAFAFA);
  static const _lightCardColor = Colors.white;
  static const _lightTextColor = Colors.black87;

  // Dark Theme Colors
  static const _darkPrimaryColor = Colors.indigo;
  static const _darkScaffoldBackground = Color(0xFF121212);
  static const _darkCardColor = Color(0xFF1E1E1E);
  static const _darkTextColor = Colors.white;

  // Shared properties
  static const _cardRadius = 12.0;
  static const _inputBorderRadius = 12.0;
  static const _appBarElevation = 0.0;

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        surface: _lightScaffoldBackground,
      ),
      scaffoldBackgroundColor: _lightScaffoldBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _lightPrimaryColor,
        elevation: _appBarElevation,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: _lightTextColor),
        bodyMedium: TextStyle(color: _lightTextColor),
        titleMedium: TextStyle(color: _lightTextColor),
        titleLarge: TextStyle(color: _lightTextColor),
      ),
      cardTheme: CardThemeData(
        color: _lightCardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightCardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        surface: _darkScaffoldBackground,
      ),
      scaffoldBackgroundColor: _darkScaffoldBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _darkCardColor,
        elevation: _appBarElevation,
        titleTextStyle: const TextStyle(
          color: _darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: _darkTextColor),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: _darkTextColor),
        bodyMedium: TextStyle(color: _darkTextColor),
        titleMedium: TextStyle(color: _darkTextColor),
        titleLarge: TextStyle(color: _darkTextColor),
      ),
      cardTheme: CardThemeData(
        color: _darkCardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkCardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}