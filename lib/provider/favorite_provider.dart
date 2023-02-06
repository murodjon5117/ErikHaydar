import 'package:erik_haydar/data/model/response/body/category_page_model.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/model/response/body/category_music_model.dart';
import '../data/model/response/body/home_model.dart';
import '../data/model/response/body/music_model.dart';
import '../data/repository/category_repo.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider({
    required this.repo,
  });
  CategoryRepo repo;

  final List<MusicModel> _musics = [];
  List<MusicModel> get musics => _musics;
  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPageCount = 1;
  int get totalPageCount => _totalPageCount;

  bool _isPagingLoading = false;
  bool get isPagingLoading => _isPagingLoading;

  Future<void> getFavoriteMusics(bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _musics.clear();
    }
    ApiResponse apiResponse = await repo.getFavoritesMusic();
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

  bool isPaging() {
    return !_isPagingLoading && (_currentPage <= totalPageCount);
  }

  final List<Films> _films = [];
  List<Films> get films => _films;

  Future<void> getFavoriteFilms(bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _films.clear();
    }
    ApiResponse apiResponse = await repo.getFavoritesFilm();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<FilmsAll>.fromJson(
          apiResponse.response?.data, (data) => FilmsAll.fromJson(data));
      _films.addAll(response.data?.items ?? []);
      _currentPage = (response.data?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.mMeta?.pageCount ?? 0);
    }
    _isPagingLoading = false;
    notifyListeners();
  }
}
