import 'package:erik_haydar/data/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../helper/api_checker.dart';

class LoginProvider extends ChangeNotifier {
  AuthRepo repo;
  SharedPreferences sharedPreferences;

    LoginProvider({required this.repo, required this.sharedPreferences});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //for login
  Future<BaseResponse> login(String phone, String password, String deviceId,
      String deviceName,String deviceToken, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    var data = {
      'username': phone,
      'password': password,
      'device_id': deviceId,
      'device_name': deviceName,
      'device_token': deviceToken
    };
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await repo.login(data);

    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
    return baseResponse;
  }
}
