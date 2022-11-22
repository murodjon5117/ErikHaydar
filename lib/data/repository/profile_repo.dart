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
        AppConstants.GET_USER_INFO,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTarif() async {
    try {
      final response = await dioClient.get(
        AppConstants.GET_TARIFS,
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
      final response =
          await dioClient.post(AppConstants.verifySms, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateUserInfo(dynamic data) async {
    try {
      final response =
          await dioClient.post(AppConstants.updateUserInfo, data: data);
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

  Future<ApiResponse> buyTarif(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.BUY_TARIF,
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
        return AppConstants.PAY_PAYME;
      case PaymentType.click:
        return AppConstants.PAY_CLICK;
      case PaymentType.apelsin:
        return AppConstants.PAY_APELSIN;
    }
  }
}
