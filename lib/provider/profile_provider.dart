import 'dart:io';

import 'package:erik_haydar/data/model/response/body/devices_model.dart';
import 'package:erik_haydar/data/model/response/body/info_model.dart';
import 'package:erik_haydar/data/model/response/body/tarif_model.dart';
import 'package:erik_haydar/data/model/response/body/url_launch.dart';
import 'package:erik_haydar/helper/extention/extention.dart';
import 'package:flutter/material.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/base_model.dart';
import '../data/model/response/base/payment_model.dart';
import '../data/repository/profile_repo.dart';
import '../util/images.dart';
import '../view/sceen/profile/widget/buttons.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileRepo repo;

  ProfileProvider({required this.repo});

  UserInfoModelProfile _userInfo = UserInfoModelProfile();
  UserInfoModelProfile get userInfo => _userInfo;

  int _genderId = 5;
  int get genderId => _genderId;

  void setGender(int id) {
    _genderId = id;
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    ApiResponse apiResponse = await repo.getUserInfo();
    _userInfo = UserInfoModelProfile();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<UserInfoModelProfile>.fromJson(
          apiResponse.response?.data,
          (data) => UserInfoModelProfile.fromJson(data));
      _userInfo = response.data ?? UserInfoModelProfile();
    }
    notifyListeners();
  }

  final List<TarifModel> _tarifs = [];
  List<TarifModel> get tarifs => _tarifs;

  Future<void> getTarifs() async {
    ApiResponse apiResponse = await repo.getTarif();
    _tarifs.clear();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      apiResponse.response?.data['data']
          .forEach((items) => _tarifs.add(TarifModel.fromJson(items)));
    }
    notifyListeners();
  }

  Future<String> pay(String amount) async {
    String url = '';
    var data = {'amount': amount};
    ApiResponse apiResponse = await repo.pay(_activePayType, data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      var response = BaseResponse<UrlLaunch>.fromJson(
          apiResponse.response?.data, (data) => UrlLaunch.fromJson(data));
      url = response.data?.url ?? '';
    }
    notifyListeners();
    return url;
  }

  Future<BaseResponse> changePhone(String phone) async {
    var data = {'phone': phone};
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await repo.changePhone(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  Future<BaseResponse> verifyPhone(String phone, String code) async {
    var data = {'phone': phone, 'code': code};
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await repo.verifySms(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  Future<BaseResponse> updateUserInfo(
    String name,
    String surName,
    File? img,
  ) async {
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse =
        await repo.updateUserInfo(name, surName, genderId, img);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  Future<BaseResponse> updateUserPassword(
      String oldPassword, String newPassword, String newPasswordRepeat) async {
    var data = {
      'old_password': oldPassword,
      'new_password': newPassword,
      'repeat_password': newPasswordRepeat
    };
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await repo.updateUserRassword(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  Future<BaseResponse> setSupport(String message) async {
    var data = {
      'message': message,
    };
    BaseResponse baseResponse = BaseResponse();
    ApiResponse apiResponse = await repo.setSupport(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  Future<BaseResponse> buyTarif() async {
    int id = _activeItem
            .firstWhere(
              (element) => _selectedActiveItem == element.durationName,
              orElse: () => ActiveItems(),
            )
            .id ??
        0;
    BaseResponse baseResponse = BaseResponse();
    var data = {'id': id};
    ApiResponse apiResponse = await repo.buyTarif(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  Future<BaseResponse> deleteDevice(String deviceId) async {
    BaseResponse baseResponse = BaseResponse();
    var data = {'device_id': deviceId};
    ApiResponse apiResponse = await repo.deleteDevice(data);
    if (IsEnableApiResponse(apiResponse).isValide()) {
      baseResponse =
          BaseResponse.fromJson(apiResponse.response?.data, (data) => dynamic);
    }
    notifyListeners();
    return baseResponse;
  }

  final List<DeviceModel> _deviceList = [];
  List<DeviceModel> get deviceList => _deviceList;

  Future<void> getActiveDevices() async {
    ApiResponse apiResponse = await repo.getActiveDevices();
    _deviceList.clear();
    if (IsEnableApiResponse(apiResponse).isValide()) {
      apiResponse.response?.data['data']
          .forEach((items) => _deviceList.add(DeviceModel.fromJson(items)));
    }
    notifyListeners();
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

  final List<ActiveItems> _activeItem = [];
  List<ActiveItems> get activeItems => _activeItem;

  final List<String> _activeItemString = [];
  List<String> get activeItemString => _activeItemString;

  String _selectedActiveItem = '';
  String get selectedActiveItem => _selectedActiveItem;

  selectActiveTarif(TarifModel model) {
    _activeItem.clear();
    _activeItemString.clear();
    _activeItem.addAll(model.activeItems ?? []);
    for (var element in _activeItem) {
      _activeItemString.add(element.durationName ?? '');
    }
    _selectedActiveItem = _activeItemString[0];
    notifyListeners();
  }

  selectActiveItemTarif(String item) {
    _selectedActiveItem = item;
    notifyListeners();
  }

  String getPriceOfTarif(String item) {
    return _activeItem
            .firstWhere((element) => element.durationName == item)
            .price ??
        '';
  }
}
