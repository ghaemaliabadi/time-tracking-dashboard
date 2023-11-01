import 'package:flutter/material.dart';
import 'package:report_dashboard_with_getx/gen/fonts.gen.dart';

class AppThemes {
  static const darkTheme = ColorScheme.dark(
    background: Color(0xFF111926),
    onBackground: Color(0xFF0d121d),
    primary: Color(0xffbebec0),
    surfaceVariant: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
  );

  static ColorScheme lightTheme = const ColorScheme.light(
    background: Color(0xFFE1E0E0),
    onBackground: Color(0xFFE1E0E0),
    primary: Color(0xFF49454F),
    surfaceVariant: Color(0xFF57545B),
    onSurfaceVariant: Color(0xFF757575),
  );
  static const displayLargeSize = 32.0 + 8;
  static const displayMediumSize = 28.0 + 8;
  static const displaySmallSize = 24.0 + 8;
  static const headlineLargeSize = 20.0 + 8;
  static const headlineMediumSize = 16.0 + 8;
  static const headlineSmallSize = 14.0 + 8;
  static const bodyLargeSize = 18.0 + 8;
  static const bodyMediumSize = 14.0 + 8;
  static const bodySmallSize = 12.0 + 8;
  static final light = ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.kalameh,
    colorScheme: lightTheme,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: displayLargeSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: displayMediumSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: displaySmallSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: headlineLargeSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: headlineMediumSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: headlineSmallSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: bodyLargeSize,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: bodyMediumSize,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: bodySmallSize,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    )
  );
  static final dark = ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.kalameh,
    colorScheme: darkTheme,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: displayLargeSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: displayMediumSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: displaySmallSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: headlineLargeSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: headlineMediumSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: headlineSmallSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: bodyLargeSize,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: bodyMediumSize,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: bodySmallSize,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    )
  );
}
