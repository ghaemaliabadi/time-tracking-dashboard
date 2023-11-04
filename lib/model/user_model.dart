import 'package:report_dashboard_with_getx/constant/api_constants.dart';

class UserModel {
  // int? id;
  String? name;
  String? profilePhoto;
  int? yesterdayLength;
  bool? isActiveToday;
  String? lastTaskToday;

  UserModel({
    // this.id,
    this.name,
    this.profilePhoto,
    this.yesterdayLength,
    this.isActiveToday,
    this.lastTaskToday,
  });

  UserModel.fromJson(Map<String, dynamic> element) {
    // id = element['id'];
    name = element['name'];
    profilePhoto = ApiUrlConstants.baseUrl + element['profile_photo'];
    yesterdayLength = element['yesterday_length'];
    isActiveToday = element['is_active_today'];
    lastTaskToday = element['last_task_today'];
  }

  get userLengthString {
    if (yesterdayLength == null) {
      return '0';
    } else {
      var min = yesterdayLength! % 60;
      var hour = yesterdayLength! ~/ 60;
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
