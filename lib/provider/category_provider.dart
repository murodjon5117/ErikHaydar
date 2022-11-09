// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/data/model/response/body/category_page_model.dart';
import 'package:erik_haydar/data/model/response/body/films_category_model.dart';
import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/data/model/response/body/slider_model/slider_model.dart';
import 'package:erik_haydar/data/repository/category_repo.dart';
import 'package:erik_haydar/helper/api_checker.dart';
import 'package:flutter/material.dart';

import 'package:erik_haydar/data/repository/home_repo.dart';

import '../data/model/response/base/base_model.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider({
    required this.repo,
  });
  CategoryRepo repo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Items> _filmsCategory = [];
  List<Items> get filmsCategory => _filmsCategory;

  Future<void> getFilmsCategory() async {
    _filmsCategory.clear();
    _isLoading = true;
    ApiResponse apiResponse = await repo.getFilmsCategory();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<FilmsCategoryModel>.fromJson(
          apiResponse.response?.data,
          (data) => FilmsCategoryModel.fromJson(data));
      _filmsCategory = response.data?.items ?? [];
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  List<Films> _films = [];
  List<Films> get films => _films;

  Future<void> getFilmsCategoryPage(String slug) async {
    _isLoading = true;
    _films.clear();
    dynamic data = {'category': slug};
    ApiResponse apiResponse = await repo.getFilmsCategoryPage(data);
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<CategoryPageModel>.fromJson(
          apiResponse.response?.data,
          (data) => CategoryPageModel.fromJson(data));
      _films = response.data?.films?.items ?? [];
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  List<Items> _filterList = [];
  List<Items> get filterList => _filterList;

  List<String> _filterStringList = ['sadsds','adsad','afafa'];
  List<String> get filterStringList => _filterStringList;

  String _currentFilterStringValue = '';
  String get currentFilterStringValue => _currentFilterStringValue;
  setCurrentFilterValue(String value) {
    _currentFilterStringValue = value;
    notifyListeners();
  }

  Future<void> getFilterType() async {
    _isLoading = true;
    _filterList.clear();
    ApiResponse apiResponse = await repo.getFilters();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((category) => _filterList.add(Items.fromJson(category)));
      // for (var element in _filterList) {
      //   _filterStringList.add(element.name ?? '');
      // }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }
}
