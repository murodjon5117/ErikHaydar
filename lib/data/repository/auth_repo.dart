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
      final response = await dioClient.post(
        AppConstants.ENTER_PHONE,
        data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.LOGIN,
        data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.VERIFY_PHONE,
        data: data
      );
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
  Future<http.StreamedResponse> fullRegistration(
      File img,
      Map<String,String> userData) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.BASE_URL}${AppConstants.FULL_REGISTER}'));
    request.headers.addAll(userData);
    request.files.add(http.MultipartFile(
        'img', img.readAsBytes().asStream(), img.lengthSync(),
        filename: img.path.split('/').last));

    http.StreamedResponse response = await request.send();
    return response;
  }

}
