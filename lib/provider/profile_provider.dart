import 'package:erik_haydar/data/model/response/body/info_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/repository/profile_repo.dart';
import '../helper/api_checker.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileRepo repo;
  SharedPreferences sharedPreferences;

  ProfileProvider({required this.repo, required this.sharedPreferences});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserInfoModelProfile _userInfo = UserInfoModelProfile();
  UserInfoModelProfile get userInfo => _userInfo;
  Future<void> getUserInfo(
    BuildContext context,
  ) async {
    _isLoading = true;
    ApiResponse apiResponse = await repo.getUserInfo();
    _userInfo = UserInfoModelProfile();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<UserInfoModelProfile>.fromJson(
          apiResponse.response?.data,
          (data) => UserInfoModelProfile.fromJson(data));
      _userInfo = response.data ?? UserInfoModelProfile();
    } else {
      ApiChecker.checkApi(apiResponse, context);
    }
    _isLoading = false;
    notifyListeners();
  }
}
