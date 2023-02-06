import '../../util/app_constants.dart';
import '../datasource/dio/dio_client.dart';
import '../datasource/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class SerialRepo {
  DioClient dioClient;

  SerialRepo({required this.dioClient});
  Future<ApiResponse> getSerialSeason(dynamic data) async {
    try {
      final response = await dioClient.post(AppConstants.serialSeason,
          queryParameters: data);

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
    Future<ApiResponse> getSerialsItem(dynamic data) async {
    try {
      final response = await dioClient.post(AppConstants.serialItem,
          queryParameters: data);

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
