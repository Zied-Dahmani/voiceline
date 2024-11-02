import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF161615),
    error: Color(0xFFEB4A5A),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF161615)),
  ),
  scaffoldBackgroundColor: Colors.white,
);
