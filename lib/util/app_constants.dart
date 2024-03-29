import '../data/model/util_model/language_model.dart';

class AppConstants {
  static const APP_NAME = 'ERIK HAYDAR';
  static const BASE_URL = '';
  static const ENTER_PHONE = '/auth/register/phone';
  static const GET_USER_INFO = '/profile-manager/profile/index';
  static const GET_TARIFS = '/tariff-manager/tariff/index';
  static const VERIFY_PHONE = '/auth/register/verify';
  static const REGISTRATION = '/auth/register/register';
  static const LOGIN = '/auth/login/login';
  static const GET_CITY = '/auth/register/regions';
  static const FULL_REGISTER = '/auth/register/register';
  static const PAY_PAYME = '/tariff-manager/payment/get-payme-url';
  static const PAY_CLICK = '/tariff-manager/payment/get-click-url';
  static const PAY_APELSIN = '/tariff-manager/payment/get-apelsin-url';
  static const BUY_TARIF = '/tariff-manager/tariff/purchase';
  static const filmCategory = '/film-manager/film-category/index';
  static const filmCategoryPage = '/film-manager/film-category/films';
  static const filterType = '/film-manager/film-type/types';
  static const categoryMusic = '/film-manager/music/index';
  static const favoritesMusic = '/film-manager/favorite-film/music';
  static const favoritesFilm = '/film-manager/favorite-film/index';

  //Home Page
  static const SLIDER = '/slider/index';
  static const homeFilm = '/film-manager/film-type/index';
  static const homeMusic = '/film-manager/music/home';
  static const likeForFilm = '/film-manager/film/like';
  static const dissLikeForFilm = '/film-manager/film/dislike';
  static const addFavorite = '/film-manager/favorite-film/create';
  static const filmDetail = '/film-manager/film/detail';
  //Shared Key
  static const String token = 'token';
  static const String isLogin = 'isLogin';
  static const String name = 'name';
  static const String surName = 'surName';
  static const String userName = 'userName';
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
