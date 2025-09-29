import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();
  static ThemeData lighTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        backgroundColor: Colors.blue,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      secondary: Colors.purple,
      onSecondary: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        backgroundColor: Colors.blue,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      onPrimary: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      secondary: Colors.purple,
      onSecondary: Colors.white,
    ),
  );
}
