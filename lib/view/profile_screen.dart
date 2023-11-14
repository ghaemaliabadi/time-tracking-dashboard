import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/constant/my_colors.dart';
import '../controller/theme_controller.dart';
import '../model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uniqueName = user.uniqueName;
    // TODO: get User Data From Back-End

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
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
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
                      var maxSizeForCol = 199;
                      // create random number
                      // var rand = Random().nextInt(20) % 6;
                      var rand = index % 3;
                      var sizeOfCol = maxSizeForCol / (rand + 1);
                      return Column(
                        children: [
                          SizedBox(height: maxSizeForCol - sizeOfCol + 25),
                          GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              userClickedOnX.value = details.globalPosition.dx;
                              userClickedOnY.value = details.globalPosition.dy;
                              isBoxVisible.value = true;
                            },
                            onTapUp: (TapUpDetails details) {
                              isBoxVisible.value = false;
                            },
                            onTapCancel: () {
                              isBoxVisible.value = false;
                            },
                            child: Container(
                              // round on top
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: Get.find<ThemeController>()
                                          .isDarkMode
                                          .value
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
                              convertToPersianNumber('7/${21 - index}'),
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
                  () {
                    var side = 'right';
                    return Visibility(
                      visible: isBoxVisible.value,
                      child: Positioned(
                        top: userClickedOnY.value - pageHeight / 9.1,
                        right: () {
                          if (userClickedOnX.value < 110) {
                            return null;
                          } else {
                            return pageWidth - userClickedOnX.value + 10;
                          }
                        }(),
                        left: () {
                          if (userClickedOnX.value < 110) {
                            side = 'left';
                            return userClickedOnX.value + 10;
                          } else {
                            return null;
                          }
                        }(),
                        child: CustomPaint(
                          painter: ShapePainter(
                              color: colorScheme.outline, side: side),
                          child: Container(
                          decoration: BoxDecoration(
                              color: colorScheme.outline,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            width: 100,
                            height: 50,
                            child: Center(child: Text(
                                '۱۳:۱۳  ساعت',
                                style: TextStyle(
                                  color: colorScheme.onBackground,
                                  fontSize: 16,
                                ),
                            )),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ]),
              const Text('سلام')
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

class ShapePainter extends CustomPainter {
  Color color;
  String side;

  // get color on constructor as ShapePainter() or ShapePainter(color: Colors.red)
  ShapePainter({this.color = Colors.white, this.side = 'right'});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    const double triangleH = 10;
    const double triangleW = 25.0;
    final double width = size.width;
    final double height = size.height;
    if (side == 'right') {
      // this path is for triangle on right of bubble
      final Path trianglePath = Path()
        ..moveTo(width, height / 2 - triangleW / 2)
        ..lineTo(width + triangleH, height / 2)
        ..lineTo(width, height / 2 + triangleW / 2)
        ..lineTo(width, height / 2 - triangleW / 2);
      canvas.drawPath(trianglePath, paint);
    } else {
      // this path is for triangle on left of bubble:
      final Path trianglePath = Path()
        ..moveTo(0, height / 2 - triangleW / 2)
        ..lineTo(-triangleH, height / 2)
        ..lineTo(0, height / 2 + triangleW / 2)
        ..lineTo(0, height / 2 - triangleW / 2);
      canvas.drawPath(trianglePath, paint);
    }
    final BorderRadius borderRadius = BorderRadius.circular(15);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
