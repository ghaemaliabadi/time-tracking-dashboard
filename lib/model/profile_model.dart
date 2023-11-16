import 'package:report_dashboard_with_getx/constant/api_constants.dart';

class ProfileModel {
  String? uniqueName;
  String? name;
  String? profilePhoto;
  String? monthLength;
  String? monthTasks;
  String? averageLength;
  String? absentCount;
  String? maxLength;
  String? minLength;
  String? aiText;

  ProfileModel(
      {this.uniqueName,
      this.name,
      this.profilePhoto,
      this.monthLength,
      this.monthTasks,
      this.averageLength,
      this.absentCount,
      this.maxLength,
      this.minLength,
      this.aiText});

  ProfileModel.fromJson(Map<String, dynamic> element) {
    uniqueName = element['unique_name'];
    name = element['name'];
    profilePhoto = ApiUrlConstants.baseUrl + element['profile_photo'];
    monthLength = convertToPersianNumber(element['month_length']);
    monthTasks = convertToPersianNumber(element['month_tasks']);
    averageLength = convertToPersianNumber(element['average_length']);
    absentCount = convertToPersianNumber(element['absent_count']);
    maxLength = convertToPersianNumber(element['max_length']);
    minLength = convertToPersianNumber(element['min_length']);
    aiText = element['ai_text'];
  }

  // convert english number to persian number
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
