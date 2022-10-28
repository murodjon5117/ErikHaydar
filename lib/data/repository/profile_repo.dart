import 'package:dio/dio.dart';
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
                'Bearer ${sharedPreferences.getString(AppConstants.TOKEN)}'
          }));

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
