import 'package:dio/dio.dart';
import 'package:erik_haydar/view/sceen/profile/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart';
import '../datasource/dio/dio_client.dart';
import '../datasource/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class ProfileRepo {
  DioClient dioClient;
  SharedPreferences sharedPreferences;

  ProfileRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getUserInfo() async {
    try {
      final response = await dioClient.get(AppConstants.GET_USER_INFO,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTarif() async {
    try {
      final response = await dioClient.get(AppConstants.GET_TARIFS,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> pay(PaymentType type, dynamic data) async {
    try {
      final response = await dioClient.post(payType(type),
          queryParameters: data,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> buyTarif(dynamic data) async {
    try {
      final response = await dioClient.post(AppConstants.BUY_TARIF,
          data: data,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));

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
