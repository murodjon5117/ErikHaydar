// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/data/model/response/base/base_model.dart';
import 'package:erik_haydar/data/model/response/body/slider_model/slider_model.dart';
import 'package:erik_haydar/helper/api_checker.dart';
import 'package:flutter/material.dart';

import '../../data/repository/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.repo,
  });
  HomeRepo repo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<SliderModel> _slider = [];
  List<SliderModel> get slider => _slider;
  Future<void> getSliderData(BuildContext context) async {
    _isLoading = true;
    _slider = [];
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await repo.getSlider();

    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((category) => _slider.add(SliderModel.fromJson(category)));
      print('object $_slider');
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }
}
