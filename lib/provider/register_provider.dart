import 'dart:io';

import 'package:erik_haydar/data/model/response/body/cities_model.dart';
import 'package:erik_haydar/data/model/response/body/user_info_model.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:erik_haydar/main.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/repository/auth_repo.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  RegisterProvider({
    required this.authRepo,
  });

  String _firebaseToken = '';
  String get firebaseToken => _firebaseToken;

  void getFirebaseToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      _firebaseToken = value.toString();
    });
  }

  //for enter phone
  Future<BaseResponse> enterPhone(String phone) async {
    notifyListeners();
    var data = {'phone': phone};
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await authRepo.enterPhone(data);

    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
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

    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
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

    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<CitiesModel>.fromJson(
          apiResponse.response?.data, (data) => CitiesModel.fromJson(data));
      _cityList.addAll(response.data?.regions ?? []);
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
  ) async {
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
        _firebaseToken);
    if (IsEnableApiResponse(apiResponse).isValide()) {
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
    }
    notifyListeners();
    return status;
  }
}
