import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/data/model/response/body/slider_model/slider_model.dart';
import 'package:erik_haydar/helper/api_checker.dart';
import 'package:flutter/material.dart';

import 'package:erik_haydar/data/repository/home_repo.dart';

import '../data/model/response/base/base_model.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.repo,
  });
  HomeRepo repo;

  List<SliderModel> _slider = [];
  List<SliderModel> get slider => _slider;

  Future<void> getSliderData() async {
    ApiResponse apiResponse = await repo.getSlider();
    _slider.clear();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((category) => _slider.add(SliderModel.fromJson(category)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  List<HomeModel> _homeDataList = [];
  List<HomeModel> get homeDataList => _homeDataList;

  Future<void> getHomeFilm() async {
    ApiResponse apiResponse = await repo.getHomeData();
    _homeDataList.clear();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((list) => _homeDataList.add(HomeModel.fromJson(list)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  List<MusicModel> _homeMusicList = [];
  List<MusicModel> get homeMusicList => _homeMusicList;

  Future<void> getHomeMusic() async {
    ApiResponse apiResponse = await repo.getHomeMusic();
    _homeMusicList.clear();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((list) => _homeMusicList.add(MusicModel.fromJson(list)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
  
  Future<BaseResponse> addFavorite(String slug) async {
    BaseResponse baseResponse = BaseResponse();
    var data = {'key': slug,};
    ApiResponse apiResponse = await repo.addFavorite(data);
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return baseResponse;
  }
}
