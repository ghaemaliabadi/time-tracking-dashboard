import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/themes/app_themes.dart';
import 'package:report_dashboard_with_getx/view/dashboard_screen.dart';

import 'controller/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Report Dashboard',
      locale: const Locale('fa', 'IR'),
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: Get.find<ThemeController>().isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      home: DashboardScreen(),
    );
  }
}