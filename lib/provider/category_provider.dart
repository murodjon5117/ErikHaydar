import 'package:erik_haydar/data/model/response/base/api_response.dart';
import 'package:erik_haydar/data/model/response/body/category_music_model.dart';
import 'package:erik_haydar/data/model/response/body/category_page_model.dart';
import 'package:erik_haydar/data/model/response/body/films_category_model.dart';
import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/data/repository/category_repo.dart';
import 'package:erik_haydar/helper/api_checker.dart';
import 'package:erik_haydar/helper/enums/view_enum.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:flutter/material.dart';
import '../data/model/response/base/base_model.dart';
import '../view/sceen/category/videos/item_videos_screen.dart';

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

  final List<Widget> _generalWidgets = [];
  List<Widget> get generalWidgets => _generalWidgets;

  final List<Tab> _tabs = [];
  List<Tab> get tabs => _tabs;

  Future<bool> getFilmsCategory() async {
    _filmsCategory.clear();
    _isLoading = true;
    bool result = false;
    _generalWidgets.clear();
    _tabs.clear();
    ApiResponse apiResponse = await repo.getFilmsCategory();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<FilmsCategoryModel>.fromJson(
          apiResponse.response?.data,
          (data) => FilmsCategoryModel.fromJson(data));
      _filmsCategory = response.data?.items ?? [];

      for (int i = 0; i < _filmsCategory.length; i++) {
        _tabs.add(Tab(
          text: filmsCategory[i].name,
        ));
        _generalWidgets.add(ItemVideosScreen(item: filmsCategory[i]));
      }

      result = true;
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
    return result;
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

    dynamic data = {'category': slug, 'page': _currentPage, 'type': setType()};
    ApiResponse apiResponse = await repo.getFilmsCategoryPage(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<CategoryPageModel>.fromJson(
          apiResponse.response?.data,
          (data) => CategoryPageModel.fromJson(data));
      _films.addAll(response.data?.films?.items ?? []);
      _currentPage = (response.data?.films?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.films?.mMeta?.pageCount ?? 0);
    }
    _isPagingLoading = false;
    notifyListeners();
  }

  final List<MusicModel> _musics = [];
  List<MusicModel> get musics => _musics;

  Future<void> getCategoryMusics(bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _musics.clear();
    }
    dynamic data = {'page': _currentPage, 'type': setType()};
    ApiResponse apiResponse = await repo.getCategoryMusic(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<CategoryMusicModel>.fromJson(
          apiResponse.response?.data,
          (data) => CategoryMusicModel.fromJson(data));
      _musics.addAll(response.data?.items ?? []);
      _currentPage = (response.data?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.mMeta?.pageCount ?? 0);
    }
    _isPagingLoading = false;
    notifyListeners();
  }

  final List<Items> _filterList = [];
  List<Items> get filterList => _filterList;

  final List<String> _filterStringList = [];
  List<String> get filterStringList => _filterStringList;

  String _currentFilterStringValue = '';
  String get currentFilterStringValue => _currentFilterStringValue;

  setCurrentFilterValue(String value) {
    _currentFilterStringValue = value;
    notifyListeners();
  }

  String setType() {
    return _filterList
            .firstWhere((element) => element.name == _currentFilterStringValue)
            .slug ??
        '';
  }

  Future<void> getFilterType() async {
    _filterList.clear();
    _filterStringList.clear();
    ApiResponse apiResponse = await repo.getFilters();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      apiResponse.response?.data['data']
          .forEach((category) => _filterList.add(Items.fromJson(category)));
      for (var element in _filterList) {
        _filterStringList.add(element.name ?? '');
      }
      _currentFilterStringValue = _filterStringList[0];
    }
    notifyListeners();
  }
}
