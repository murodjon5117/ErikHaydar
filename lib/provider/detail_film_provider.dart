import 'package:erik_haydar/data/model/response/body/comment_model.dart';
import 'package:erik_haydar/data/model/response/body/detail_fim_model.dart';
import 'package:erik_haydar/data/model/response/body/like_dislike_model.dart';
import 'package:erik_haydar/data/repository/detail_repo.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';

class FilmDetailProvider extends ChangeNotifier {
  FilmDetailProvider({
    required this.repo,
  });
  DetailRepo repo;
  DetailFilmModel _detailFilmModel = DetailFilmModel();
  DetailFilmModel get detailFilmModel => _detailFilmModel;

  bool _isLike = false;
  bool get isLike => _isLike;
  String _likeCount = '';
  String get likeCount => _likeCount;

  bool _isDisLike = false;
  bool get isDisLike => _isDisLike;
  String _disLikeCount = '';
  String get likeDisCount => _disLikeCount;

  Future<void> getFilmDetail(String slug) async {
    _detailFilmModel = DetailFilmModel();
    ApiResponse apiResponse = await repo.getFilmDetail({
      'key': slug,
    });
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<DetailFilmModel>.fromJson(
          apiResponse.response?.data, (data) => DetailFilmModel.fromJson(data));
      _detailFilmModel = response.data ?? DetailFilmModel();
      _isLike = _detailFilmModel.isLike ?? false;
      _likeCount = _detailFilmModel.likesCount.toString();
      _isDisLike = _detailFilmModel.isDisLike ?? false;
      _disLikeCount = _detailFilmModel.dislikesCount.toString();
    }
    notifyListeners();
  }

  Future<void> likeForFilm(String slug) async {
    var data = {
      'slug': slug,
    };
    ApiResponse apiResponse = await repo.likeForFilm(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<LikeDislikeModel>.fromJson(
          apiResponse.response?.data,
          (data) => LikeDislikeModel.fromJson(data));
      _isLike = !_isLike;
      _isDisLike = false;
      _likeCount = response.data?.likesCount.toString() ?? '';
      _disLikeCount = response.data?.dislikesCount.toString() ?? '';
    }
    notifyListeners();
  }

  Future<void> dissLikeForFilm(String slug) async {
    var data = {
      'slug': slug,
    };
    ApiResponse apiResponse = await repo.dissLikeForFilm(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<LikeDislikeModel>.fromJson(
          apiResponse.response?.data,
          (data) => LikeDislikeModel.fromJson(data));
      _isDisLike = !_isDisLike;
      _isLike = false;
      _disLikeCount = response.data?.dislikesCount.toString() ?? '';
      _likeCount = response.data?.likesCount.toString() ?? '';
    }
    notifyListeners();
  }

  Future<BaseResponse> setComment(String comment, int id) async {
    BaseResponse baseResponse = BaseResponse();
    var data = {'comment': comment, 'film_id': id};
    ApiResponse apiResponse = await repo.setComment(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<Comment>.fromJson(
          apiResponse.response?.data, (data) => Comment.fromJson(data));
      _commentList.insert(0, response.data ?? Comment());
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  final List<Comment> _commentList = [];
  List<Comment> get commentList => _commentList;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPageCount = 1;
  int get totalPageCount => _totalPageCount;

  int _totalItemCount = 0;
  int get totalItemCount => _totalItemCount;

  bool _isPagingLoading = false;
  bool get isPagingLoading => _isPagingLoading;

  bool isPaging() {
    return !_isPagingLoading && (_currentPage <= totalPageCount);
  }

  Future<void> getComment(String slug, bool isPaging) async {
    if (isPaging) {
      _isPagingLoading = true;
      notifyListeners();
    } else {
      _currentPage = 1;
      _commentList.clear();
    }
    dynamic data = {'key': slug, 'page': _currentPage};
    ApiResponse apiResponse = await repo.getComment(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<CommetModel>.fromJson(
          apiResponse.response?.data, (data) => CommetModel.fromJson(data));
      _commentList.addAll(response.data?.items ?? []);
      _currentPage = (response.data?.mMeta?.currentPage ?? 0) + 1;
      _totalPageCount = (response.data?.mMeta?.pageCount ?? 0);
      _totalItemCount = (response.data?.mMeta?.totalCount ?? 0);
    }
    _isPagingLoading = false;
    notifyListeners();
  }
}
