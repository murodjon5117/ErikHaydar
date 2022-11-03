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
    required this.sharedPreferences,
  });
  DioClient dioClient;
  SharedPreferences sharedPreferences;

  Future<ApiResponse> getSlider() async {
    try {
      final response = await dioClient.post(AppConstants.SLIDER,
          options: Options(headers: {
            'Accept-Language':
                sharedPreferences.getString(AppConstants.LANGUAGE_CODE)
          }));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
