import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/themes/app_themes.dart';
import 'package:report_dashboard_with_getx/view/dashboard_screen.dart';
import 'package:report_dashboard_with_getx/view/profile_screen.dart';

import 'constant/api_constants.dart';
import 'controller/theme_controller.dart';
import 'model/user_model.dart';

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
      locale: const Locale('fa'),
      fallbackLocale: const Locale('en', 'US'),
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: Get.find<ThemeController>().isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      home: DashboardScreen(),
      // home: ProfileScreen(user: UserModel(
      //   uniqueName: 'hoda',
      //   name: 'هدی لطفی',
      //   role: 'مدیر محتوا',
      //   profilePhoto: '${ApiUrlConstants.baseUrl}hoda.jpg',
      //   yesterdayLength: 205,
      //   isActiveToday: true,
      //   lastTaskToday: 'آخرین تسک تستی دیروز هدی',
      // )),
    );
  }
}