import 'package:erik_haydar/data/model/response/body/detail_fim_model.dart';
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

  Future<void> getFilmDetail(String slug) async {
    _detailFilmModel = DetailFilmModel();
    ApiResponse apiResponse = await repo.getFilmDetail({
      'key': slug,
    });
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<DetailFilmModel>.fromJson(
          apiResponse.response?.data, (data) => DetailFilmModel.fromJson(data));
      _detailFilmModel = response.data ?? DetailFilmModel();
    }
    notifyListeners();
  }
}
