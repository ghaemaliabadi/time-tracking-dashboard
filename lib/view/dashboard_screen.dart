import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:report_dashboard_with_getx/themes/app_themes.dart';

import '../controller/theme_controller.dart';
import '../model/user_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserModel> users = [
      UserModel(
        name: 'عرفان حسن‌پور',
        profilePhoto: 'erfan.jpg',
        yesterdayLength: 195,
        isActiveToday: true,
        lastTaskToday: 'آخرین تسک تستی دیروز عرفان',
      ),
      UserModel(
        name: 'هدی لطفی',
        profilePhoto: 'hoda.jpg',
        yesterdayLength: 205,
        isActiveToday: true,
        lastTaskToday: 'آخرین تسک تستی دیروز هدی',
      ),
      UserModel(
        name: 'حنانه اشراقی',
        profilePhoto: 'hana.jpg',
        yesterdayLength: 125,
        isActiveToday: true,
        lastTaskToday: 'آخرین تسک تستی دیروز حنا',
      ),
      UserModel(
        name: 'هانیه حیدری',
        profilePhoto: 'hana.jpg',
        yesterdayLength: 140,
        isActiveToday: true,
        lastTaskToday: 'آخرین تسک تستی دیروز هانیه',
      ),
      UserModel(
        name: 'قائم علی‌آبادی',
        profilePhoto: 'ghaem.jpg',
        yesterdayLength: 155,
        isActiveToday: true,
        lastTaskToday: 'آخرین تسک تستی دیروز قائم',
      ),
      UserModel(
        name: 'مبینا هاشمیان',
        profilePhoto: 'mobina.jpg',
        yesterdayLength: 100,
        isActiveToday: true,
        lastTaskToday: 'آخرین تسک تستی دیروز مبینا',
      ),
    ];
    // sort users by yesterdayLength
    users.sort((a, b) => b.yesterdayLength!.compareTo(a.yesterdayLength!));
    Get.put(ThemeController());
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: colorScheme.secondary,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: colorScheme.shadow,
                          offset: const Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            Text('فعال‌ترین‌های دیروز',
                                style: textTheme.displaySmall),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MostActiveYesterdayColumnBuilder(
                                colorScheme, pageWidth, textTheme, users[0]),
                            MostActiveYesterdayColumnBuilder(
                                colorScheme, pageWidth, textTheme, users[1]),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: colorScheme.tertiary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: colorScheme.shadow,
                        offset: const Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('تعداد اعضای فعال امروز',
                                style: textTheme.headlineLarge
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LinearPercentIndicator(
                              percent: 2 / 7,
                              width: MediaQuery.sizeOf(context).width * 0.75,
                              lineHeight: 16,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: Colors.white,
                              backgroundColor: Colors.white70,
                              barRadius: Radius.circular(50),
                              padding: EdgeInsets.zero,
                            ),
                            Text('7/2',
                                style: textTheme.headlineMedium
                                    ?.copyWith(color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column MostActiveYesterdayColumnBuilder(ColorScheme colorScheme,
      double pageWidth, TextTheme textTheme, UserModel user) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: colorScheme.shadow,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user.profilePhoto!,
                fit: BoxFit.cover,
                width: pageWidth / 2 - 80,
                height: pageWidth / 2 - 80,
              )),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(user.name!, style: textTheme.bodyMedium),
        Text(user.userLengthString + ' ساعت',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.primary)),
      ],
    );
  }
}
