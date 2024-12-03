import 'package:flutter/material.dart';

const surfaceColor = Color.fromARGB(255, 43, 43, 43);
const primaryColor = Color.fromARGB(255, 47, 215, 185);

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        surface: surfaceColor,
        primaryContainer: Color.fromARGB(255, 56, 56, 56),
        primary: primaryColor,
        onPrimary: Colors.white,
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
          )),
    );
  }
}
