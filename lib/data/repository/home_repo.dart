// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:erik_haydar/data/datasource/exception/api_error_handler.dart';
import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:erik_haydar/data/datasource/dio/dio_client.dart';

class HomeRepo {
  HomeRepo({
    required this.dioClient,
  });
  DioClient dioClient;

  Future<ApiResponse> getSlider() async {
    try {
      final response = await dioClient.post(
        AppConstants.slider,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getHomeData() async {
    try {
      final response = await dioClient.post(
        AppConstants.homeFilm,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getHomeMusic() async {
    try {
      final response = await dioClient.post(
        AppConstants.homeMusic,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getNotification() async {
    try {
      final response = await dioClient.post(
        AppConstants.notification,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  
  Future<ApiResponse> addFavorite(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.addFavorite,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
