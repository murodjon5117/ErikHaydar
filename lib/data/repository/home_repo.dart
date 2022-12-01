import 'package:erik_haydar/data/datasource/exception/api_error_handler.dart';
import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/util/app_constants.dart';

import 'package:erik_haydar/data/datasource/dio/dio_client.dart';

class HomeRepo {
  HomeRepo({
    required this.dioClient,
  });
  DioClient dioClient;

  Future<ApiResponse> getSlider() async {
    try {
      final response = await dioClient.post(
        AppConstants.SLIDER,
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
