import 'package:flutter/material.dart';

const surfaceColor = Color.fromARGB(255, 43, 43, 43);
const primaryColor = Color.fromARGB(255, 47, 215, 185);
const Color primaryColorWithOpacity = Color.fromRGBO(69, 255, 221, 1);
const glowColor = Color.fromRGBO(0, 255, 209, 0.74);
const innerGlowColor = Colors.white;

const greyColor = Color.fromARGB(255, 191, 191, 191);
const Color greyColorWithOpacity = Color.fromRGBO(245, 245, 245, 1);

const yellowColor = Color.fromRGBO(255, 217, 119, 1);

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      iconTheme: const IconThemeData(
        size: 14,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      colorScheme: const ColorScheme.dark(
        surface: surfaceColor,
        primaryContainer: Color.fromARGB(255, 56, 56, 56),
        primary: primaryColor,
        onPrimary: Colors.white,
        secondaryContainer: Color.fromRGBO(70, 70, 70, 1),
        error: Color.fromARGB(255, 252, 67, 67),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          fontFamily: 'Fixel',
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Fixel',
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: 'Fixel',
          color: Colors.white,
        ),
        labelSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Fixel',
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: 'Fixel',
          color: greyColor,
        ),
        bodySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
          fontFamily: 'Fixel',
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(greyColor),
        ),
      ),
      checkboxTheme: const CheckboxThemeData(
        fillColor: WidgetStatePropertyAll(Colors.white),
        checkColor: WidgetStatePropertyAll(primaryColor),
        splashRadius: 10,
        side: BorderSide(
          color: primaryColor, // колір обводки
          width: 2,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
