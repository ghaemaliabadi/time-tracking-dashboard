import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/themes/app_themes.dart';

import '../controller/theme_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      'داشبورد',
                      style: textTheme.displayLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IconButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.find<ThemeController>().toggleTheme();
                      },
                      icon: Icon(
                        size: 36.0,
                        shadows: [
                          BoxShadow(
                            color: colorScheme.surfaceVariant,
                            blurRadius: 2.0,
                            offset: const Offset(0.0, 1.0),
                          ),
                        ],
                        Get.isDarkMode
                            ? Icons.wb_sunny
                            : Icons.nightlight_round,
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text('آمار و تحلیل گزارش‌کارهای تاج‌کنکور',
                        style: textTheme.bodyMedium
                            ?.copyWith(color: colorScheme.primary)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
