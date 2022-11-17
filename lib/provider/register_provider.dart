import 'dart:io';

import 'package:erik_haydar/data/model/response/body/cities_model.dart';
import 'package:erik_haydar/data/model/response/body/user_info_model.dart';
import 'package:erik_haydar/main.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/repository/auth_repo.dart';
import '../helper/api_checker.dart';
import '../util/app_constants.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  RegisterProvider({required this.authRepo, });

  //for enter phone
  Future<BaseResponse> enterPhone(String phone) async {
    notifyListeners();
    var data = {'phone': phone};
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await authRepo.enterPhone(data);

    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return baseResponse;
  }

  //sms verify
  Future<BaseResponse> verifyPhone(String phone, String smsCode) async {
    notifyListeners();
    var data = {'phone': phone, 'code': smsCode};
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await authRepo.verifyPhone(data);

    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return baseResponse;
  }

  //get cities
  final List<Regions> _cityList = [];
  List<Regions> get cityList => _cityList;

  Future<void> getCities() async {
    _cityList.clear();
    ApiResponse apiResponse = await authRepo.getCities();

    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<CitiesModel>.fromJson(
          apiResponse.response?.data, (data) => CitiesModel.fromJson(data));
      _cityList.addAll(response.data?.regions ?? []);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  int _genderId = 5;
  int get genderId => _genderId;

  void setGender(int id) {
    _genderId = id;
    notifyListeners();
  }

  int _cityId = 0;
  int get cityId => _cityId;

  void setCity(int id) {
    _cityId = id;
    notifyListeners();
  }

  //full registration
  Future<bool> savePhoto(
      File? img,
      String phone,
      String code,
      String firstName,
      String lastName,
      String password,
      String passwordRepeat,
      String bornDate,
      String deviceId,
      String deviceName,
      String deviceToken) async {
    bool status = false;
    ApiResponse apiResponse = await authRepo.fullRegistration(
        img,
        phone,
        code,
        firstName,
        lastName,
        password,
        passwordRepeat,
        bornDate,
        _cityId.toString(),
        _genderId.toString(),
        deviceId,
        deviceName,
        deviceToken);
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<UserInfoData>.fromJson(
          apiResponse.response?.data, (data) => UserInfoData.fromJson(data));
      Provider.of<UserDataProvider>(MyApp.navigatorKey.currentState!.context,
              listen: false)
          .saveUserData(
              response.data?.authKey ?? '',
              response.data?.firstname ?? '',
              response.data?.lastname ?? '',
              response.data?.username ?? '');
      status = true;
    } else {
      status = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return status;
  }
}
