import 'package:erik_haydar/data/repository/auth_repo.dart';
import 'package:erik_haydar/helper/shared_pres.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/model/response/body/user_info_model.dart';
import '../helper/api_checker.dart';

class LoginProvider extends ChangeNotifier {
  AuthRepo repo;
  SharedPreferences sharedPreferences;

  LoginProvider({required this.repo, required this.sharedPreferences});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //for login
  Future<BaseResponse> login(String phone, String password, String deviceId,
      String deviceName, String deviceToken) async {
    _isLoading = true;
    notifyListeners();
    var data = {
      'username': phone,
      'password': password,
      'device_id': deviceId,
      'device_name': deviceName,
      'device_token': deviceToken
    };
    BaseResponse<UserInfoData> baseResponse = BaseResponse();
    ApiResponse apiResponse = await repo.login(data);

    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      baseResponse = BaseResponse<UserInfoData>.fromJson(
          apiResponse.response?.data, (data) => UserInfoData.fromJson(data));
      SharedPref().save(AppConstants.USER_DATA, baseResponse.data?.toJson());
      sharedPreferences.setString(
          AppConstants.TOKEN, baseResponse.data?.authKey ?? '');
      print(baseResponse.data?.toJson());
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
    return baseResponse;
  }
}
