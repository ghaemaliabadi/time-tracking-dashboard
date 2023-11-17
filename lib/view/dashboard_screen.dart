import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:report_dashboard_with_getx/view/profile_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controller/dashboard_controller.dart';
import '../controller/theme_controller.dart';
import '../model/user_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    var pageWidth = MediaQuery.of(context).size.width;
    return GetX<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
              body: /*controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : */
                  buildSingleChildScrollView(textTheme, colorScheme, pageWidth,
                      controller.users, context, controller));
        });
  }

  SingleChildScrollView buildSingleChildScrollView(
      TextTheme textTheme,
      ColorScheme colorScheme,
      double pageWidth,
      List<UserModel> users,
      BuildContext context,
      DashboardController controller) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // const SizedBox(height: 60.0),
          const SizedBox(height: 8.0),
          Skeletonizer(
            enabled: controller.isLoading.value,
            child: Row(
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.find<ThemeController>().toggleTheme();
                    },
                    icon: Skeleton.ignore(
                      child: Icon(
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
                ),
              ],
            ),
          ),
          // const SizedBox(height: 16.0),
          Skeletonizer(
            enabled: controller.isLoading.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      Text('آمار و تحلیل گزارشکارهای تاج‌کنکور',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: colorScheme.primary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Skeletonizer(
            enabled: controller.isLoading.value,
            child: Padding(
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
                              style: textTheme.headlineLarge),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          mostActiveYesterdayColumnBuilder(
                              colorScheme, pageWidth, textTheme, users[0]),
                          const SizedBox(
                            width: 2,
                          ),
                          mostActiveYesterdayColumnBuilder(
                              colorScheme, pageWidth, textTheme, users[1]),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )),
            ),
          ),
          Skeletonizer(
            enabled: controller.isLoading.value,
            containersColor: colorScheme.secondary,
            child: Padding(
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
                              style: textTheme.headlineMedium
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LinearPercentIndicator(
                            // active users today / all users
                            percent: users
                                    .where((element) => element.isActiveToday!)
                                    .length /
                                users.length,
                            width: MediaQuery.sizeOf(context).width * 0.68,
                            lineHeight: 16,
                            animation: true,
                            animateFromLastPercent: true,
                            progressColor: Colors.white,
                            backgroundColor: Colors.white70,
                            barRadius: const Radius.circular(50),
                            padding: EdgeInsets.zero,
                          ),
                          Text(
                              convertToPersianNumber(
                                  "${users.where((element) => element.isActiveToday!).length}/${users.length}"),
                              style: textTheme.headlineMedium
                                  ?.copyWith(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Skeletonizer(
            enabled: controller.isLoading.value,
            child: Padding(
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
                          Text('لیست کل اعضا', style: textTheme.headlineLarge),
                        ],
                      ),
                      // build a listview of users
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: Duration(seconds: 1),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ProfileScreen(
                                        user: users[index],
                                      ),
                                      arguments: users[index],
                                      transition: Transition.zoom,
                                      duration:
                                          const Duration(milliseconds: 350),
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 12, 8, 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  users[index].profilePhoto!,
                                                  fit: BoxFit.cover,
                                                  width: 48,
                                                  height: 48,
                                                )),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(users[index].name!,
                                                    style:
                                                        textTheme.bodyMedium),
                                                Text(users[index].role!,
                                                    style: textTheme.bodySmall
                                                        ?.copyWith(
                                                            color: colorScheme
                                                                .primary,
                                                            fontSize: 16)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // is active today
                                        users[index].isActiveToday!
                                            ? Text('فعال',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: colorScheme
                                                            .tertiary))
                                            : Text('غیرفعال',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: colorScheme
                                                            .primary)),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: colorScheme.outline,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  Column mostActiveYesterdayColumnBuilder(ColorScheme colorScheme,
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

  convertToPersianNumber(String input) {
    var result = input;
    result = result.replaceAll('0', '۰');
    result = result.replaceAll('1', '۱');
    result = result.replaceAll('2', '۲');
    result = result.replaceAll('3', '۳');
    result = result.replaceAll('4', '۴');
    result = result.replaceAll('5', '۵');
    result = result.replaceAll('6', '۶');
    result = result.replaceAll('7', '۷');
    result = result.replaceAll('8', '۸');
    result = result.replaceAll('9', '۹');
    return result;
  }
}
