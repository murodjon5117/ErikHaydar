import 'package:erik_haydar/data/model/response/body/category_music_model.dart';
import 'package:erik_haydar/data/model/response/body/category_page_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/model/response/body/home_model.dart';
import '../data/repository/category_repo.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider({
    required this.repo,
  });
  CategoryRepo repo;

  void setDefauilLists() {
    _films.clear();
    _musics.clear();
    _totalFilmsCount = 0;
    _totalMusicsCount = 0;
  }

  final List<Films> _films = [];
  List<Films> get films => _films;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalFilmsCount = 0;
  int get totalFilmsCount => _totalFilmsCount;

  int _totalPageCount = 1;
  int get totalPageCount => _totalPageCount;

  bool _isPagingLoading = false;
  bool get isPagingLoading => _isPagingLoading;

  bool isPaging() {
    return !_isPagingLoading && (_currentPage <= totalPageCount);
  }

  Future<void> getFilmsSearch(String query, bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _films.clear();
    }
    dynamic data = {'name': query, 'page': _currentPage};
    ApiResponse apiResponse = await repo.getSearchFilms(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<FilmsAll>.fromJson(
          apiResponse.response?.data, (data) => FilmsAll.fromJson(data));
      _films.addAll(response.data?.items ?? []);
      _currentPage = (response.data?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.mMeta?.pageCount ?? 0);
      _totalFilmsCount = (response.data?.mMeta?.totalCount ?? 0);
    }
    _isPagingLoading = false;
    notifyListeners();
  }

  final List<MusicModel> _musics = [];
  List<MusicModel> get musics => _musics;

  int _currentPageMusic = 1;
  int get currentPageMusic => _currentPageMusic;

  int _totalPageCountMusic = 1;
  int get totalPageCountMusic => _totalPageCountMusic;

  int _totalMusicsCount = 0;
  int get totalMusicsCount => _totalMusicsCount;

  bool _isPagingLoadingMusic = false;
  bool get isPagingLoadingMusic => _isPagingLoadingMusic;

  bool isPagingMusic() {
    return !_isPagingLoadingMusic && (_currentPageMusic <= totalPageCountMusic);
  }

  Future<void> getMusicSearch(String query, bool isPaging) async {
    if (isPaging) {
      _isPagingLoadingMusic = true;
      notifyListeners();
    } else {
      _currentPageMusic = 1;
      _musics.clear();
    }
    dynamic data = {'name': query, 'page': _currentPageMusic};
    ApiResponse apiResponse = await repo.getSearchMusics(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<CategoryMusicModel>.fromJson(
          apiResponse.response?.data,
          (data) => CategoryMusicModel.fromJson(data));
      _musics.addAll(response.data?.items ?? []);
      _currentPageMusic = (response.data?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCountMusic = (response.data?.mMeta?.pageCount ?? 0);
      _totalMusicsCount = (response.data?.mMeta?.totalCount ?? 0);
    }
    _isPagingLoadingMusic = false;
    notifyListeners();
  }
}
