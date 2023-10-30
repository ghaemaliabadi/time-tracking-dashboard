import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
  );
  static ThemeData darkTheme =
      ThemeData.dark().copyWith(
          primaryColor: Colors.red
      );
}
