import 'dart:convert';
import 'package:get/get.dart';
import 'package:report_dashboard_with_getx/constant/api_constants.dart';
import 'package:report_dashboard_with_getx/model/user_model.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  List<UserModel> users = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    for (var i = 0; i < 10; i++) {
      users.add(UserModel(
        uniqueName: 'uniqueName',
        name: 'name name name',
        role: 'role role role',
        profilePhoto: 'https://simplyilm.com/wp-content/uploads/2017/08/temporary-profile-placeholder-1.jpg',
        yesterdayLength: 1000,
        isActiveToday: false,
        lastTaskToday: 'lastTaskToday',
      ));
    }
    fetchData();
  }

  void fetchData() async {
    isLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      http.Response response = await http
          .get(Uri.parse('${ApiUrlConstants.apiUrl}?method=get_user_list'));
      var i = 0;
      while (response.statusCode != 200) {
        response = await http
            .get(Uri.parse('${ApiUrlConstants.apiUrl}?method=get_user_list'));
        i++;
        if (i == 5) {
          break;
        }
      }
      if (response.statusCode == 200) {
        users = (json.decode(response.body) as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
        users.sort((a, b) => b.yesterdayLength!.compareTo(a.yesterdayLength!));
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
