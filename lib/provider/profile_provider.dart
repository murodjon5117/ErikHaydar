import 'package:erik_haydar/data/model/response/body/info_model.dart';
import 'package:erik_haydar/data/model/response/body/tarif_model.dart';
import 'package:erik_haydar/data/model/response/body/url_launch.dart';
import 'package:erik_haydar/util/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/model/response/base/payment_model.dart';
import '../data/repository/profile_repo.dart';
import '../helper/api_checker.dart';
import '../util/images.dart';
import '../view/sceen/profile/widget/buttons.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileRepo repo;

  ProfileProvider({required this.repo});

  UserInfoModelProfile _userInfo = UserInfoModelProfile();
  UserInfoModelProfile get userInfo => _userInfo;

  Future<void> getUserInfo() async {
    ApiResponse apiResponse = await repo.getUserInfo();
    _userInfo = UserInfoModelProfile();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<UserInfoModelProfile>.fromJson(
          apiResponse.response?.data,
          (data) => UserInfoModelProfile.fromJson(data));
      _userInfo = response.data ?? UserInfoModelProfile();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  final List<TarifModel> _tarifs = [];
  List<TarifModel> get tarifs => _tarifs;

  Future<void> getTarifs() async {
    ApiResponse apiResponse = await repo.getTarif();
    _tarifs.clear();
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      apiResponse.response?.data['data']
          .forEach((items) => _tarifs.add(TarifModel.fromJson(items)));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<String> pay(String amount) async {
    String url = '';
    notifyListeners();
    var data = {'amount': amount};
    ApiResponse apiResponse = await repo.pay(_activePayType, data);
    if (apiResponse.response?.statusCode == 200 &&
        apiResponse.response?.data['status'] == 200) {
      var response = BaseResponse<UrlLaunch>.fromJson(
          apiResponse.response?.data, (data) => UrlLaunch.fromJson(data));
      url = response.data?.url ?? '';
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return url;
  }

  Future<BaseResponse> buyTarif(int id) async {
    BaseResponse baseResponse = BaseResponse();
    var data = {'id': id};
    ApiResponse apiResponse = await repo.buyTarif(data);
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

  final List<PaymentModel> _paymentList = [
    PaymentModel(
        name: 'Payme',
        type: PaymentType.payme,
        icon: Images.payme,
        isSlected: true),
    PaymentModel(
        name: 'Click',
        type: PaymentType.click,
        icon: Images.click,
        isSlected: false),
    PaymentModel(
        name: 'Apelsin',
        type: PaymentType.apelsin,
        icon: Images.apelsin,
        isSlected: false),
  ];
  List<PaymentModel> get paymentList => _paymentList;
  PaymentType _activePayType = PaymentType.payme;
  setSelected(PaymentType type) {
    for (var i = 0; i < _paymentList.length; i++) {
      if (_paymentList[i].type == type) {
        _paymentList[i].isSlected = true;
        _activePayType = _paymentList[i].type;
      } else {
        _paymentList[i].isSlected = false;
      }
    }
    notifyListeners();
  }
}
