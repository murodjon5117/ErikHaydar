import '../data/model/util_model/language_model.dart';

class AppConstants {
  static const APP_NAME = 'ERIK HAYDAR';
  static const BASE_URL = 'https://erik.safowater.com/api';
  static const ENTER_PHONE = '/auth/register/phone';
  static const GET_USER_INFO = '/profile-manager/profile/index';
  static const VERIFY_PHONE = '/auth/register/verify';
  static const REGISTRATION = '/auth/register/register';
  static const LOGIN = '/auth/login/login';
  static const GET_CITY = '/auth/register/regions';
  static const FULL_REGISTER = '/auth/register/register';

  //Shared Key
  static const String TOKEN = 'token';
  static const String IS_LOGIN = 'isLogin';
  static const String USER_DATA = 'userData';
  static const LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';
  static const String REGION_CODE = 'region_code';
  static const String SCRIPT_CODE = 'script_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      languageName: 'O\'zbekcha',
      countryCode: 'UZ',
      languageCode: 'uz',
      scriptsCode: "Latn",
    ),
    LanguageModel(
      languageName: 'Русский',
      countryCode: 'RU',
      languageCode: 'ru',
      scriptsCode: "RU",
    ),
    LanguageModel(
      languageName: 'Ўзбекча',
      countryCode: 'UZ',
      languageCode: 'en',
      scriptsCode: "Cyrl",
    )
  ];
}
