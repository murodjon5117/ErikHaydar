import 'package:erik_haydar/data/repository/auth_repo.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:erik_haydar/main.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/model/response/body/user_info_model.dart';

class LoginProvider extends ChangeNotifier {
  AuthRepo repo;

  LoginProvider({required this.repo});

  //for login
  Future<BaseResponse> login(String phone, String password, String deviceId,
      String deviceName, String? deviceToken) async {
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

    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse = BaseResponse<UserInfoData>.fromJson(
          apiResponse.response?.data, (data) => UserInfoData.fromJson(data));
      Provider.of<UserDataProvider>(MyApp.navigatorKey.currentState!.context,
              listen: false)
          .saveUserData(
              baseResponse.data?.authKey ?? '',
              baseResponse.data?.firstname ?? '',
              baseResponse.data?.lastname ?? '',
              baseResponse.data?.username ?? '');
    }
    notifyListeners();
    return baseResponse;
  }
}
