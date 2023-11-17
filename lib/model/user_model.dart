import 'package:report_dashboard_with_getx/constant/api_constants.dart';

class UserModel {
  String? uniqueName;
  String? name;
  String? role;
  String? profilePhoto;
  int? yesterdayLength;
  bool? isActiveToday;
  String? lastTaskToday;

  UserModel({
    this.uniqueName,
    this.name,
    this.role,
    this.profilePhoto,
    this.yesterdayLength,
    this.isActiveToday,
    this.lastTaskToday,
  });

  UserModel.fromJson(Map<String, dynamic> element) {
    uniqueName = element['unique_name'].toString();
    name = element['name'];
    role = element['role'];
    profilePhoto = ApiUrlConstants.baseUrl + element['profile_photo'];
    yesterdayLength = int.tryParse(element['yesterday_length'] ?? '0');
    isActiveToday = (element['is_active_today'].toString() == 'true') ? true : false;
    lastTaskToday = element['last_task_today'];
  }

  get userLengthString {
    if (yesterdayLength == null) {
      return '0';
    } else {
      var min = yesterdayLength! % 60;
      var hour = yesterdayLength! ~/ 60;
      if (min < 10 && hour < 10) {
        return convertToPersianNumber('0$hour:0$min');
      }
      if (min < 10) {
        return convertToPersianNumber('$hour:0$min');
      }
      if (hour < 10) {
        return convertToPersianNumber('0$hour:$min');
      }
      return convertToPersianNumber('$hour:$min');
    }
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
