import 'dart:convert';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/constant/api_constants.dart';
import 'package:http/http.dart' as http;

import '../model/profile_model.dart';

class ProfileController extends GetxController {
  String uniqueName;
  ProfileController({required this.uniqueName});
  ProfileModel profile = ProfileModel();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    for (var i = 0; i < 10; i++) {
      profile = ProfileModel(
          uniqueName: 'uniqueName',
          name: 'name',
          profilePhoto: 'https://simplyilm.com/wp-content/uploads/2017/08/temporary-profile-placeholder-1.jpg',
          monthLength: '03:00',
          monthTasks: '24',
          averageLength: '03:00',
          absentCount: '5',
          maxLength: '03:00',
          minLength: '03:00',
          aiText: 'aiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiTextaiText',
          days: {
            '7/1': 150 - 5 * 0,
            '7/2': 150 - 5 * 4,
            '7/3': 150 - 5 * 2,
            '7/4': 150 - 5 * 5,
            '7/5': 150 - 5 * 3,
            '7/6': 150 - 5 * 6,
            '7/26': 150 - 5 * 12,
            '7/27': 150 - 5 * 6,
            '7/28': 150 - 5 * 12,
            '7/29': 150 - 5 * 8,
            '7/30': 150 - 5 * 12,
            '7/31': 150 - 5 * 10,
          });
    }
    fetchData();
  }

  void fetchData() async {
    isLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      http.Response response = await http
          .get(Uri.parse('${ApiUrlConstants.apiUrl}?method=get_user_profile_$uniqueName'));
      var i = 0;
      while (response.statusCode != 200) {
        response = await http
            .get(Uri.parse('${ApiUrlConstants.apiUrl}?method=get_user_profile_$uniqueName'));
        i++;
        if (i == 5) {
          break;
        }
      }
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        profile = ProfileModel.fromJson(result);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
