import 'package:report_dashboard_with_getx/constant/api_constants.dart';
import 'package:report_dashboard_with_getx/model/task_model.dart';

class UserModel {
  int? id;
  String? name;
  String? profilePhoto;
  int? yesterdayLength;
  bool? isActiveToday;
  String? lastTaskToday;

  UserModel({
    this.id,
    this.name,
    this.profilePhoto,
    this.yesterdayLength,
    this.isActiveToday,
    this.lastTaskToday,
  });

  UserModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    name = element['name'];
    profilePhoto = ApiUrlConstants.baseUrl + element['profile_photo'];
    yesterdayLength = element['yesterday_length'];
    isActiveToday = element['is_active_today'];
    lastTaskToday = element['last_task_today'];
  }
}
