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
  });
  DioClient dioClient;

  Future<ApiResponse> getFilmsCategory() async {
    try {
      final response = await dioClient.post(
        AppConstants.filmCategory,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFilmsCategoryPage(dynamic params) async {
    try {
      final response = await dioClient.post(
        AppConstants.filmCategoryPage,
        queryParameters: params,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryMusic(dynamic params) async {
    try {
      final response = await dioClient.post(
        AppConstants.categoryMusic,
        queryParameters: params,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFilters() async {
    try {
      final response = await dioClient.get(
        AppConstants.filterType,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFavoritesMusic() async {
    try {
      final response = await dioClient.post(
        AppConstants.favoritesMusic,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFavoritesFilm() async {
    try {
      final response = await dioClient.post(
        AppConstants.favoritesFilm,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSearchFilms(dynamic data) async {
    try {
      final response = await dioClient.post(AppConstants.filmSearch,
          queryParameters: data, isLoading: false);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSearchMusics(dynamic data) async {
    try {
      final response = await dioClient.post(AppConstants.musicSearch,
          queryParameters: data, isLoading: false);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
