import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkPrimary = Color(0xff1F6B50);
  static const Color primary = Color(0xff2F8F62);
  static const Color accent = Color(0xff4CC38A);

  static const Color darkBg = Color(0xFF1E1E1E);
  static const Color darkGrey = Color(0xFFB5B5B5);
  static const Color darkSurface = Color(0xff2a2a2a);


  static const Color lightGrey = Color(0xFF657069);
  static const Color lightBg = Color(0xFFF3F5EF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFF4F1EA);


  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Roboto',

      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: lightSurface,
        surface: lightBg,
        onSurface: Colors.black,
        tertiary: lightGrey
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkPrimary,
      foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          )
  ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: accent, width: 1.2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      )
    ),
      elevatedButtonTheme:ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: darkPrimary,
              foregroundColor: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              )
          )
      )
  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Roboto',

      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: darkSurface,
        surface: darkBg,
        onSurface: Colors.white,
          tertiary: darkGrey,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkPrimary,
      foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )
  ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: accent, width: 1.2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
      checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )
      ),
    elevatedButtonTheme:ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        )
      )
    )
  );
}