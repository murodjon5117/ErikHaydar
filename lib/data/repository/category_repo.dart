// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:erik_haydar/data/datasource/exception/api_error_handler.dart';
import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:erik_haydar/data/datasource/dio/dio_client.dart';

class CategoryRepo {
  CategoryRepo({
    required this.dioClient,
    required this.sharedPreferences,
  });
  DioClient dioClient;
  SharedPreferences sharedPreferences;

  Future<ApiResponse> getFilmsCategory() async {
    try {
      final response = await dioClient.post(AppConstants.filmCategory,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFilmsCategoryPage(dynamic params) async {
    try {
      final response = await dioClient.post(AppConstants.filmCategoryPage,
          queryParameters: params,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryMusic(dynamic params) async {
    try {
      final response = await dioClient.post(AppConstants.categoryMusic,
          queryParameters: params,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFilters() async {
    try {
      final response = await dioClient.get(AppConstants.filterType,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getFavoritesMusic() async {
    try {
      final response = await dioClient.post(AppConstants.favoritesMusic,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getFavoritesFilm() async {
    try {
      final response = await dioClient.post(AppConstants.favoritesFilm,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstants.token)}'
          }));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
