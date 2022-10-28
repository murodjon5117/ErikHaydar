import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../util/app_constants.dart';
import '../datasource/dio/dio_client.dart';
import '../datasource/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class AuthRepo {
  DioClient dioClient;
  SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> enterPhone(dynamic data) async {
    try {
      final response =
          await dioClient.post(AppConstants.ENTER_PHONE, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(dynamic data) async {
    try {
      final response = await dioClient.post(AppConstants.LOGIN, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(dynamic data) async {
    try {
      final response =
          await dioClient.post(AppConstants.VERIFY_PHONE, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCities() async {
    try {
      final response = await dioClient.get(
        AppConstants.GET_CITY,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> fullRegistration(
      File? img,
      String phone,
      String code,
      String firstName,
      String lastName,
      String password,
      String passwordRepeat,
      String bornDate,
      String regionId,
      String genderId,
      String deviceId,
      String deviceName,
      String deviceToken) async {
    FormData formData = FormData();
    if (img != null) {
      String fileName = img.path.split('/').last;
      formData = FormData.fromMap({
        'img': await MultipartFile.fromFile(img.path, filename: fileName),
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
      });
    } else {
      formData = FormData.fromMap({
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
      });
    }

    try {
      final response =
          await dioClient.post(AppConstants.FULL_REGISTER, data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
