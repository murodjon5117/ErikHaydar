import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/data/model/response/body/notification_model.dart';
import 'package:erik_haydar/data/model/response/body/slider_model/slider_model.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:flutter/material.dart';

import 'package:erik_haydar/data/repository/home_repo.dart';

import '../data/model/response/base/base_model.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.repo,
  });
  HomeRepo repo;

  final List<SliderModel> _slider = [];
  List<SliderModel> get slider => _slider;

  Future<void> getSliderData() async {
    ApiResponse apiResponse = await repo.getSlider();
    _slider.clear();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      apiResponse.response?.data['data']
          .forEach((category) => _slider.add(SliderModel.fromJson(category)));
    }
    notifyListeners();
  }

  final List<HomeModel> _homeDataList = [];
  List<HomeModel> get homeDataList => _homeDataList;

  Future<void> getHomeFilm() async {
    ApiResponse apiResponse = await repo.getHomeData();
    _homeDataList.clear();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      apiResponse.response?.data['data']
          .forEach((list) => _homeDataList.add(HomeModel.fromJson(list)));
    }
    notifyListeners();
  }

  final List<MusicModel> _homeMusicList = [];
  List<MusicModel> get homeMusicList => _homeMusicList;

  Future<void> getHomeMusic() async {
    ApiResponse apiResponse = await repo.getHomeMusic();
    _homeMusicList.clear();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      apiResponse.response?.data['data']
          .forEach((list) => _homeMusicList.add(MusicModel.fromJson(list)));
    }
    notifyListeners();
  }

  List<NotifItems> _notifList = [];
  List<NotifItems> get notifList => _notifList;

  Future<void> getNotification() async {
    ApiResponse apiResponse = await repo.getNotification();
    _notifList.clear();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<NotificationModel>.fromJson(
          apiResponse.response?.data,
          (data) => NotificationModel.fromJson(data));
      _notifList.addAll(response.data?.items ?? []);
    }
    notifyListeners();
  }

  Future<BaseResponse> addFavorite(String slug) async {
    BaseResponse baseResponse = BaseResponse();
    var data = {
      'key': slug,
    };
    ApiResponse apiResponse = await repo.addFavorite(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }
}
