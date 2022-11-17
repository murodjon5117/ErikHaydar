import 'package:erik_haydar/data/model/response/base/api_response.dart';

import '../api_checker.dart';

extension IsEnableApiResponse on ApiResponse {
  bool isValide() {
    if (response?.statusCode == 200 && response?.data['status'] == 200) {
      return true;
    } else {
      ApiChecker.checkApi(this);
      return false;
    }
  }
}
