import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/constant/my_colors.dart';
import 'package:report_dashboard_with_getx/controller/profile_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controller/theme_controller.dart';
import '../model/profile_model.dart';
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
    RxInt clickedOn = 0.obs;
    RxBool isBoxVisible = false.obs;
    RxDouble animatedContainerHeight = 200.0.obs;
    RxBool isTextExpanded = false.obs;
    return GetX<ProfileController>(
        init: ProfileController(uniqueName: user.uniqueName!),
        builder: (controller) {
          return Scaffold(
              body: /*controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  :*/
                  Skeletonizer(
            enabled: controller.isLoading.value,
            child: buildSingleChildScrollView(
                textTheme,
                colorScheme,
                controller.profile,
                userClickedOnX,
                userClickedOnY,
                clickedOn,
                isBoxVisible,
                pageWidth,
                pageHeight,
                animatedContainerHeight,
                isTextExpanded,
                controller),
          ));
        });
  }

  SingleChildScrollView buildSingleChildScrollView(
      TextTheme textTheme,
      ColorScheme colorScheme,
      ProfileModel profile,
      RxDouble userClickedOnX,
      RxDouble userClickedOnY,
      RxInt clickedOn,
      RxBool isBoxVisible,
      double pageWidth,
      double pageHeight,
      RxDouble animatedContainerHeight,
      RxBool isTextExpanded,
      ProfileController controller) {
    var maxDayLength = profile.days!.values.reduce((a, b) => a > b ? a : b);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // const SizedBox(height: 48.0),
          const SizedBox(height: 4.0),
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
                itemCount: profile.days!.length,
                itemBuilder: (context, index) {
                  var maxSizeForCol = 199.0;
                  // create random number
                  // var rand = Random().nextInt(20) % 6;
                  // var rand = index % 3;
                  // var sizeOfCol = maxSizeForCol / (rand + 1);
                  var sizeOfCol = maxSizeForCol;
                  var thisDayLength = profile.days!.values.toList()[index];
                  if (thisDayLength != 0) {
                    sizeOfCol = ((maxSizeForCol - 25) * thisDayLength / maxDayLength) + 25;
                  }
                  return Column(
                    children: [
                      SizedBox(height: maxSizeForCol - sizeOfCol + 25),
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          userClickedOnX.value = details.globalPosition.dx;
                          userClickedOnY.value = details.globalPosition.dy;
                          clickedOn.value = index;
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
                              colors:
                                  Get.find<ThemeController>().isDarkMode.value
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
                          convertToPersianNumber(
                              profile.days!.keys.toList()[index]),
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
            Obx(() {
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
                    painter:
                        ShapePainter(color: colorScheme.outline, side: side),
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
                      child: Center(
                          child: Text(
                        ProfileModel.convertLengthToHHMM(profile.days!.values
                                .toList()[clickedOn.value]) +
                            '  ساعت',
                        style: TextStyle(
                          color: colorScheme.onBackground,
                          fontSize: 16,
                        ),
                      )),
                    ),
                  ),
                ),
              );
            }),
          ]),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(56),
                    child: Image.network(
                      user.profilePhoto!,
                      fit: BoxFit.cover,
                      width: 72,
                      height: 72,
                    )),
                Card(
                  elevation: 0,
                  color: colorScheme.background,
                  child: Container(
                    height: 96,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!,
                          style: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.onBackground,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          user.role!,
                          style: textTheme.bodySmall!.copyWith(
                            color: colorScheme.onBackground,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // this.monthLength,
          // this.monthTasks,
          // this.averageLength,
          // this.absentCount,
          // this.maxLength,
          // this.minLength,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildInfoCard(
                  colorScheme,
                  pageWidth,
                  textTheme,
                  profile,
                  Icons.timer,
                  'ساعت‌کار ماه اخیر',
                  '${profile.monthLength!} ساعت'),
              buildInfoCard(colorScheme, pageWidth, textTheme, profile,
                  Icons.task, 'تسک‌های ماه اخیر', '${profile.monthTasks!} عدد'),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildInfoCard(
                  colorScheme,
                  pageWidth,
                  textTheme,
                  profile,
                  Icons.align_vertical_bottom,
                  'میانگین روزانه ماه اخیر',
                  '${profile.averageLength!} ساعت'),
              buildInfoCard(
                  colorScheme,
                  pageWidth,
                  textTheme,
                  profile,
                  Icons.person_remove,
                  'غیبت‌های ماه اخیر',
                  '${profile.absentCount!} غیبت'),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildInfoCard(
                  colorScheme,
                  pageWidth,
                  textTheme,
                  profile,
                  Icons.keyboard_double_arrow_up_sharp,
                  'بیشترین ساعت کار',
                  '${profile.maxLength!} ساعت'),
              buildInfoCard(
                  colorScheme,
                  pageWidth,
                  textTheme,
                  profile,
                  Icons.keyboard_double_arrow_down_sharp,
                  'کمترین ساعت کار',
                  '${profile.minLength!} ساعت'),
            ],
          ),
          // show ai Text
          Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                  Card(
                elevation: 5,
                shadowColor: colorScheme.shadow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: colorScheme.background,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.ease,
                  width: double.infinity,
                  // height: animatedContainerHeight.value,
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: colorScheme.onBackground.withOpacity(0.5),
                              size: 24,
                            ),
                          ],
                        ),
                        Text(
                          'تحلیل هوش مصنوعی',
                          style: textTheme.headlineMedium!.copyWith(
                            color: colorScheme.onBackground,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          profile.aiText!,
                          style: textTheme.bodySmall!.copyWith(
                            color: colorScheme.onBackground,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         isTextExpanded.value = !isTextExpanded.value;
                        //         if (isTextExpanded.value) {
                        //           showText.value = profile.aiText!;
                        //           animatedContainerHeight.value = 460;
                        //         } else {
                        //           showText.value =
                        //               '${profile.aiText!.substring(0, 140)}...';
                        //           animatedContainerHeight.value = 200;
                        //         }
                        //       },
                        //       child: Text(
                        //         isTextExpanded.value ? 'بستن' : 'ادامه مطلب',
                        //         style: textTheme.bodySmall!.copyWith(
                        //           color: colorScheme.primary,
                        //           fontSize: 18,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Card buildInfoCard(
      ColorScheme colorScheme,
      double pageWidth,
      TextTheme textTheme,
      ProfileModel profile,
      IconData icon,
      String title,
      String data) {
    return Card(
      elevation: 5,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: colorScheme.background,
      child: Container(
        width: pageWidth / 2 - 24,
        // height: 96,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  icon,
                  color: colorScheme.onBackground.withOpacity(0.5),
                  size: 24,
                ),
              ],
            ),
            Text(
              title,
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onBackground,
                fontSize: 16,
              ),
            ),
            Text(
              data,
              style: textTheme.bodyLarge!.copyWith(
                color: colorScheme.onBackground,
                fontSize: 24,
              ),
            ),
          ],
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
