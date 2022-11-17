import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/data/model/response/body/category_music_model.dart';
import 'package:erik_haydar/data/model/response/body/category_page_model.dart';
import 'package:erik_haydar/data/model/response/body/films_category_model.dart';
import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/data/repository/category_repo.dart';
import 'package:erik_haydar/helper/api_checker.dart';
import 'package:erik_haydar/helper/enums/view_enum.dart';
import 'package:flutter/material.dart';
import '../data/model/response/base/base_model.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider({
    required this.repo,
  });
  CategoryRepo repo;

  ViewEnum _view = ViewEnum.grid;
  ViewEnum get view => _view;
  setView(ViewEnum view) {
    _view = view;
    notifyListeners();
  }

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

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPageCount = 1;
  int get totalPageCount => _totalPageCount;

  bool _isPagingLoading = false;
  bool get isPagingLoading => _isPagingLoading;

  bool isPaging() {
    return !_isPagingLoading && (_currentPage <= totalPageCount);
  }

  Future<void> getFilmsCategoryPage(String slug, bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _films.clear();
    }
    dynamic data = {'category': slug, 'page': _currentPage};
    ApiResponse apiResponse = await repo.getFilmsCategoryPage(data);
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<CategoryPageModel>.fromJson(
          apiResponse.response?.data,
          (data) => CategoryPageModel.fromJson(data));
      _films.addAll(response.data?.films?.items ?? []);
      _currentPage = (response.data?.films?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.films?.mMeta?.pageCount ?? 0);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isPagingLoading = false;
    notifyListeners();
  }

  List<MusicModel> _musics = [];
  List<MusicModel> get musics => _musics;

  Future<void> getCategoryMusics(String slug, bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _musics.clear();
    }
    dynamic data = {'page': _currentPage};
    ApiResponse apiResponse = await repo.getCategoryMusic(data);
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<CategoryMusicModel>.fromJson(
          apiResponse.response?.data,
          (data) => CategoryMusicModel.fromJson(data));
      _musics.addAll(response.data?.items ?? []);
      _currentPage = (response.data?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.mMeta?.pageCount ?? 0);
    } else {
      ApiChecker.checkApi(apiResponse);
    }

    _isPagingLoading = false;
    notifyListeners();
  }

  List<Items> _filterList = [];
  List<Items> get filterList => _filterList;

  List<String> _filterStringList = ['sadsds', 'adsad', 'afafa'];
  List<String> get filterStringList => _filterStringList;

  String _currentFilterStringValue = '';
  String get currentFilterStringValue => _currentFilterStringValue;
  setCurrentFilterValue(String value) {
    _currentFilterStringValue = value;
    notifyListeners();
  }

  Future<void> getFilterType() async {
    _filterList.clear();
    ApiResponse apiResponse = await repo.getFilters();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((category) => _filterList.add(Items.fromJson(category)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
