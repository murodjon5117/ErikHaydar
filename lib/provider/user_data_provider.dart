import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_constants.dart';
import '../util/loading_dialog.dart';

class UserDataProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  UserDataProvider({required this.sharedPreferences});

  bool isLogin() {
    return sharedPreferences.getBool(AppConstants.isLogin) ?? false;
  }

  Future<void> saveUserData(
      String token, String name, String surName, String userName) async {
    LoadingOverlay().show();
    sharedPreferences.setString(AppConstants.token, token);
    sharedPreferences.setString(AppConstants.name, name);
    sharedPreferences.setString(AppConstants.surName, surName);
    sharedPreferences.setString(AppConstants.userName, userName);
    sharedPreferences.setBool(AppConstants.isLogin, true);
    LoadingOverlay().show();
    notifyListeners();
  }

  Future<void> deleteUserData() async {
    LoadingOverlay().show();
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.name);
    sharedPreferences.remove(AppConstants.surName);
    sharedPreferences.remove(AppConstants.userName);
    sharedPreferences.setBool(AppConstants.isLogin, false);
    LoadingOverlay().show();
    notifyListeners();
  }
}
