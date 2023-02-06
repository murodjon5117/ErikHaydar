import 'package:erik_haydar/data/model/serial_season_model.dart';
import 'package:erik_haydar/data/model/serials_item_model.dart';
import 'package:erik_haydar/data/repository/serial_repo.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:erik_haydar/view/sceen/serial/serial_list_screen.dart';
import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';

class SerialProvider extends ChangeNotifier {
  SerialProvider({
    required this.repo,
  });
  SerialRepo repo;

  final List<Widget> _generalWidgets = [];
  List<Widget> get generalWidgets => _generalWidgets;

  final List<Tab> _tabs = [];
  List<Tab> get tabs => _tabs;

  List<Seasons> _seasonList = [];
  List<Seasons> get seasonList => _seasonList;

  Future<bool> getSerialSeason(String slug) async {
    bool result = false;
    dynamic data = {'key': slug};
    ApiResponse apiResponse = await repo.getSerialSeason(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      _seasonList.clear();
      _generalWidgets.clear();
      _tabs.clear();

      var response = BaseResponse<SerialSeason>.fromJson(
          apiResponse.response?.data, (data) => SerialSeason.fromJson(data));
      _seasonList.addAll(response.data?.seasons ?? []);
      for (int i = 0; i < _seasonList.length; i++) {
        _tabs.add(Tab(
          text: _seasonList[i].name,
        ));
        _generalWidgets.add(SerialListScreen(seasons: _seasonList[i]));
      }
      result = true;
    }
    notifyListeners();
    return result;
  }

  List<SerialsItems> _serials = [];
  List<SerialsItems> get serials => _serials;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPageCount = 1;
  int get totalPageCount => _totalPageCount;

  bool _isPagingLoading = false;
  bool get isPagingLoading => _isPagingLoading;

  bool isPaging() {
    return !_isPagingLoading && (_currentPage <= totalPageCount);
  }

  Future<void> getSerialsItem(String season, bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _serials.clear();
    }
    dynamic data = {'season': season, 'page': _currentPage};

    ApiResponse apiResponse = await repo.getSerialsItem(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<SerialItems>.fromJson(
          apiResponse.response?.data, (data) => SerialItems.fromJson(data));
      _serials.addAll(response.data?.parts?.items ?? []);
      _currentPage = (response.data?.parts?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.parts?.mMeta?.pageCount ?? 0);
    }
    _isPagingLoading = false;
    notifyListeners();
  }
}
