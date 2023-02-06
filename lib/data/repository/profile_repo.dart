import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erik_haydar/view/sceen/profile/widget/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart';
import '../datasource/dio/dio_client.dart';
import '../datasource/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class ProfileRepo {
  DioClient dioClient;
  ProfileRepo({required this.dioClient});

  Future<ApiResponse> getUserInfo() async {
    try {
      final response = await dioClient.get(
        AppConstants.getUserInfo,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTarif() async {
    try {
      final response = await dioClient.get(
        AppConstants.getTarifs,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getActiveDevices() async {
    try {
      final response = await dioClient.get(
        AppConstants.getActiveDevices,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> pay(PaymentType type, dynamic data) async {
    try {
      final response = await dioClient.post(
        payType(type),
        queryParameters: data,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> changePhone(dynamic data) async {
    try {
      final response =
          await dioClient.post(AppConstants.changePhone, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifySms(dynamic data) async {
    try {
      final response = await dioClient.post(AppConstants.verifySms, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateUserInfo(
      String name, String lastName, int genderId, File? image) async {
    FormData formData = FormData();

    if (image != null) {
      String fileName = image.path.split('/').last;
      formData = FormData.fromMap({
        'img': await MultipartFile.fromFile(image.path, filename: fileName),
        'firstname': name,
        'lastname': lastName,
        'gender_id': genderId,
      });
    } else {
      formData = FormData.fromMap({
        'firstname': name,
        'lastname': lastName,
        'gender_id': genderId,
      });
    }
    try {
      final response =
          await dioClient.post(AppConstants.updateUserInfo, data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateUserRassword(dynamic data) async {
    try {
      final response =
          await dioClient.post(AppConstants.updateUserPassword, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> setSupport(dynamic data) async {
    try {
      final response =
          await dioClient.post(AppConstants.setSupport, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> buyTarif(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.buyTarif,
        data: data,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteDevice(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.deleteDevice,
        data: data,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  String payType(PaymentType type) {
    switch (type) {
      case PaymentType.payme:
        return AppConstants.payPayme;
      case PaymentType.click:
        return AppConstants.payClick;
      case PaymentType.apelsin:
        return AppConstants.payApelsin;
    }
  }
}
