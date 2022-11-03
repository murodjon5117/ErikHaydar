// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/slider_model/slider_model.dart';
import 'package:erik_haydar/helper/api_checker.dart';
import 'package:flutter/material.dart';

import 'package:erik_haydar/data/repository/home_repo.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.repo,
  });
  HomeRepo repo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SliderModel> _slider = [];
  List<SliderModel> get slider => _slider;

  Future<void> getSliderData() async {
    _isLoading = true;
    _slider = [];
    ApiResponse apiResponse = await repo.getSlider();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((category) => _slider.add(SliderModel.fromJson(category)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  List<HomeModel> _homeDataList = [];
  List<HomeModel> get homeDataList => _homeDataList;

  Future<void> getHomeData() async {
    _isLoading = true;
    ApiResponse apiResponse = await repo.getHomeData();
    _homeDataList.clear();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((list) => _homeDataList.add(HomeModel.fromJson(list)));
          print(_homeDataList.length);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }
}
