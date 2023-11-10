import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/constant/api_constants.dart';
import 'package:report_dashboard_with_getx/constant/my_colors.dart';
import '../controller/theme_controller.dart';
import '../model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    var pageWidth = MediaQuery.of(context).size.width;
    var pageHeight = MediaQuery.of(context).size.height;
    RxDouble userClickedOnX = 0.0.obs;
    RxDouble userClickedOnY = 0.0.obs;
    RxBool isBoxVisible = false.obs;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios, size: 26),
                    ),
                    const Spacer(),
                    Text(
                      'پروفایل',
                      style: textTheme.bodyLarge!.copyWith(
                        color: colorScheme.onBackground,
                        fontSize: 28,
                      ),
                    ),
                    // change theme
                    const Spacer(),
                    Obx(
                      () => IconButton(
                        onPressed: () {
                          Get.find<ThemeController>().toggleTheme();
                        },
                        icon: Icon(
                          Get.find<ThemeController>().isDarkMode.value
                              ? Icons.wb_sunny
                              : Icons.nightlight_round,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Stack(children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 55,
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: colorScheme.onBackground.withOpacity(0.04),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: colorScheme.onBackground.withOpacity(0.04),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: colorScheme.onBackground.withOpacity(0.04),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: colorScheme.onBackground.withOpacity(0.1),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  alignment: Alignment.center,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      var maxSizeForCol = 219;
                      // create random number
                      // var rand = Random().nextInt(20) % 6;
                      var rand = index % 3;
                      var sizeOfCol = maxSizeForCol / (rand + 1);
                      return Column(
                        children: [
                          SizedBox(height: maxSizeForCol - sizeOfCol),
                          GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              userClickedOnX.value = details.globalPosition.dx;
                              print('x: ${details.globalPosition.dx}');
                              userClickedOnY.value = details.globalPosition.dy;
                              print('y: ${details.globalPosition.dy}');
                              isBoxVisible.value = true;
                              // make it invisible after 1 second
                              Future.delayed(const Duration(seconds: 1), () {
                                isBoxVisible.value = false;
                              });
                            },
                            child: Container(
                              // round on top
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: Get.find<ThemeController>().isDarkMode.value
                                      ? GradientColors.chartContainerRed
                                      : GradientColors.chartContainerBlue,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(32),
                                  topLeft: Radius.circular(32),
                                ),
                              ),
                              width: pageWidth / 20,
                              height: sizeOfCol, // max height for user
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${21 - index}/7',
                              style: textTheme.bodySmall!.copyWith(
                                color: colorScheme.onBackground,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: isBoxVisible.value,
                    child: Positioned(
                      top: (userClickedOnY.value - 150 > 0) ? userClickedOnY.value - 150 : 130 - userClickedOnY.value,
                      left: (userClickedOnX.value - 100 > 0) ? userClickedOnX.value - 100 : userClickedOnX.value,
                      child: Container( // TODO: design this box
                        width: 100,
                        height: 50,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
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
