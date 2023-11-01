import 'package:flutter/material.dart';
import 'package:report_dashboard_with_getx/gen/fonts.gen.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: FontFamily.kalameh,
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
  );
  static ThemeData darkTheme =
      ThemeData.dark().copyWith(
          primaryColor: Colors.red
      );
}
