import 'dart:convert';
import 'dart:io';

import 'package:erik_haydar/data/model/response/body/cities_model.dart';
import 'package:erik_haydar/data/model/response/body/user_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/repository/auth_repo.dart';
import '../helper/api_checker.dart';
import '../util/app_constants.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;
  RegisterProvider({required this.authRepo, required this.sharedPreferences});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //for enter phone
  Future<BaseResponse> enterPhone(String phone, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    var data = {'phone': phone};
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await authRepo.enterPhone(data);

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

  //sms verify
  Future<BaseResponse> verifyPhone(
    String phone,
    String smsCode,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();
    var data = {'phone': phone, 'code': smsCode};
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await authRepo.verifyPhone(data);

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

  //get cities
  final List<Regions> _cityList = [];
  List<Regions> get cityList => _cityList;

  Future<void> getCities(
    BuildContext context,
  ) async {
    _isLoading = true;
    _cityList.clear();
    ApiResponse apiResponse = await authRepo.getCities();

    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<CitiesModel>.fromJson(
          apiResponse.response?.data, (data) => CitiesModel.fromJson(data));
      _cityList.addAll(response.data?.regions ?? []);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
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
      BuildContext context,
      File img,
      String phone,
      String code,
      String firstName,
      String lastName,
      String password,
      String passwordRepeat,
      String regionId,
      String bornDate,
      String genderId,
      String deviceId,
      String deviceName,
      String deviceToken) async {
    _isLoading = true;
    notifyListeners();
    Map<String, String> userData = {
      'phone': phone,
      'code': code,
      'firstname': firstName,
      'lastname': lastName,
      'password': password,
      'password_repeat': passwordRepeat,
      'region_id': regionId,
      'born_date': bornDate,
      'gender_id': genderId,
      'device_id': deviceId,
      'device_name': deviceName,
      'device_token': deviceToken
    };
    bool status = false;
    http.StreamedResponse response =
        await authRepo.fullRegistration(img, userData);
    Map map = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200 && map['status'] == 200) {
      UserInfoData result = UserInfoData.fromJson(map['data']);
      print(result.toJson());
      status = true;
    } else {
      status = false;
      ApiChecker.checkApiForRegister(
          context, map['message'] ?? response.reasonPhrase.toString());
    }
    notifyListeners();
    return status;
  }
}
