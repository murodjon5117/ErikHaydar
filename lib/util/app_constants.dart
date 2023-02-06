import '../data/model/util_model/language_model.dart';

class AppConstants {
  static const appName = 'ERIK HAYDAR';
  static const baseUrl = 'https://hamshira.biznesgoya.uz/api';
  static const enterPhone = '/auth/register/phone';
  static const getUserInfo = '/profile-manager/profile/index';
  static const getTarifs = '/tariff-manager/tariff/index';
  static const verifyPhone = '/auth/register/verify';
  static const registration = '/auth/register/register';
  static const login = '/auth/login/login';
  static const getCity = '/auth/register/regions';
  static const fullRegister = '/auth/register/register';
  static const payPayme = '/tariff-manager/payment/get-payme-url';
  static const payClick = '/tariff-manager/payment/get-click-url';
  static const payApelsin = '/tariff-manager/payment/get-apelsin-url';
  static const buyTarif = '/tariff-manager/tariff/purchase';
  static const filmCategory = '/film-manager/film-category/index';
  static const deleteDevice = '/left-menu-manager/user-device/delete';
  static const filmCategoryPage = '/film-manager/film-category/films';
  static const filterType = '/film-manager/film-type/types';
  static const categoryMusic = '/film-manager/music/index';
  static const favoritesMusic = '/film-manager/favorite-film/music';
  static const favoritesFilm = '/film-manager/favorite-film/index';
  static const changePhone = '/profile-manager/update-username/phone';
  static const verifySms = '/profile-manager/update-username/verify';
  static const updateUserInfo = '/profile-manager/profile/update-name';
  static const setSupport = '/left-menu-manager/contact-us/create';
  static const getActiveDevices = '/left-menu-manager/user-device/index';
  static const updateUserPassword = '/profile-manager/profile/update-password';

  //Home Page
  static const slider = '/slider/index';
  static const homeFilm = '/film-manager/film-type/index';
  static const homeMusic = '/film-manager/music/home';
  static const likeForFilm = '/film-manager/film/like';
  static const dissLikeForFilm = '/film-manager/film/dislike';
  static const addFavorite = '/film-manager/favorite-film/create';
  static const filmDetail = '/film-manager/film/detail';
  static const movieSource = '/film-manager/film/watch';
  static const musicDetail = '/film-manager/music/detail';
  static const setComment = '/film-manager/film-comment/create';
  static const getComment = '/film-manager/film-comment/comments';
  static const musicSearch = '/film-manager/music/search';
  static const filmSearch = '/film-manager/film/search';
  static const notification = '/left-menu-manager/notice/index';

  //Serial
  static const serialSeason='/film-manager/film/seasons';
  static const serialItem='/film-manager/film/season-parts';
  //Shared Key
  static const String token = 'token';
  static const String isLogin = 'isLogin';
  static const String name = 'name';
  static const String surName = 'surName';
  static const String userName = 'userName';
  static const languageCode = 'language_code';
  static const String contryCode = 'country_code';

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
