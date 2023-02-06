import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_constants.dart';

class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LocalizationProvider({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = const Locale('ru', 'RU');
  Locale get locale => _locale;

  void setLanguage(Locale locale) {
    _locale = locale;
    _saveLanguage(_locale);
    notifyListeners();
  }

  bool isExistLanguage() {
    if (sharedPreferences.getString(AppConstants.languageCode) == null) {
      return false;
    } else {
      return true;
    }
  }

  bool isCurrentLanguage(String? lang) {
    if (lang == 'en') {
      lang = 'kr';
    }
    if (lang == sharedPreferences.getString(AppConstants.languageCode)) {
      return true;
    } else {
      return false;
    }
  }

  _loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(AppConstants.languageCode) ??
            AppConstants.languages[0].languageCode!,
        sharedPreferences.getString(AppConstants.contryCode) ??
            AppConstants.languages[0].countryCode);
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    String lang = '';
    if (locale.languageCode == 'en') {
      lang = 'kr';
    } else {
      lang = locale.languageCode;
    }
    sharedPreferences.setString(AppConstants.languageCode, lang);
    //sharedPreferences.setString(AppConstants.SCRIPT_CODE, locale.scriptCode!);
    sharedPreferences.setString(AppConstants.contryCode, locale.countryCode!);
  }
}
