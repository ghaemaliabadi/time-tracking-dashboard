import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/constant/api_constants.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

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
