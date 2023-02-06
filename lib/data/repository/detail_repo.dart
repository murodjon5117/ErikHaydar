import 'package:dio/dio.dart';
import 'package:erik_haydar/data/datasource/exception/api_error_handler.dart';
import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/util/app_constants.dart';

import 'package:erik_haydar/data/datasource/dio/dio_client.dart';

class DetailRepo {
  DetailRepo({
    required this.dioClient,
  });
  DioClient dioClient;

  Future<ApiResponse> getFilmDetail(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.filmDetail,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMovieSource(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.movieSource,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> downloadVideo(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.filmDetail,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMusicDetail(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.musicDetail,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> likeForFilm(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.likeForFilm,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> dissLikeForFilm(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.dissLikeForFilm,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> setComment(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.setComment,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getComment(dynamic data) async {
    try {
      final response = await dioClient.post(
        AppConstants.getComment,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  
  // Future<ApiResponse> download(
  //   String urlPath,
  //   String savePath,
  //    ProgressCallback onReceiveProgress,
  // ) async {
  //   try {
  //     final response = await dioClient.download(urlPath, savePath,

  //         onReceiveProgress: onReceiveProgress);
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
}
