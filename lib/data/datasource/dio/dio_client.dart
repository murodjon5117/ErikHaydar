import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/loading_dialog.dart';
import '../exception/pretty_dio_logger.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor? loggingInterceptor;
  final SharedPreferences? sharedPreferences;
  Dio dio = Dio();
  DioClient(this.baseUrl, Dio dioC,
      {this.loggingInterceptor, this.sharedPreferences}) {
    dio = dioC;
    dio
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          request: true,
          compact: true,
          maxWidth: 90))
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 30000
      ..options.receiveTimeout = 30000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    dio.interceptors.add(loggingInterceptor!);
  }
  Future<Response> get(String uri,
      {Map<String, dynamic>? queryParametrs,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool? isLoading}) async {
    if (isLoading ?? true) {
      LoadingOverlay().show();
    }
    try {
      var response = await dio.get(uri,
          queryParameters: queryParametrs,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sharedPreferences?.getString(AppConstants.token)}',
          }),
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      LoadingOverlay().hide();
      return response;
    } on SocketException catch (e) {
      if (isLoading ?? true) {
        LoadingOverlay().hide();
      }
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      if (isLoading ?? true) {
        LoadingOverlay().hide();
      }
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (isLoading ?? true) {
        LoadingOverlay().hide();
      }
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool? isLoading,
  }) async {
    if (isLoading ?? true) {
      LoadingOverlay().show();
    }
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          'Authorization':
              'Bearer ${sharedPreferences?.getString(AppConstants.token)}'
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (isLoading ?? true) {
        LoadingOverlay().hide();
      }
      return response;
    } on FormatException catch (_) {
      if (isLoading ?? true) {
        LoadingOverlay().hide();
      }
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (isLoading ?? true) {
        LoadingOverlay().hide();
      }
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          'Authorization':
              'Bearer ${sharedPreferences?.getString(AppConstants.token)}'
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          'Authorization':
              'Bearer ${sharedPreferences?.getString(AppConstants.token)}'
        }),
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
