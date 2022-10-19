
import '../data/model/util_model/language_model.dart';

class AppConstants {
  static const APP_NAME = 'texnomart';
  // static const BASE_URL = 'https://backend.texnomart.uz';
  static const BASE_URL = 'https://dev-back.texnomart.uz';
  static const BASE_URL_IMAGE = 'https://backend.texnomart.uz';
  static const HOME_URL = '/api/v2/home/';
  static const CART_URL = '/api/v2/product/products-via-ids';
  static const FAVORITE_URL = '/api/v2/product/products-via-ids';
  static const LOAN_TYPE = '/front-api/loan-info/get-mobile-all-info';
  static const CATEGORY_URL = '/api/v2/category/index';
  static const SUB_CATEGORY_URL = '/api/v2/category/list/?category_id=';
  static const PRODUCTS_URL = '/api/v3/category/products';
  static const DETAIL_PRODUCT_URL = '/api/v2/product/view';
  static const AVAILABLE_STORE_URL = '/api/v2/store/product-available-stores';
  static const AVAILABLE_STORIES_ALL = '/api/v1/store/sklads';
  static const ALL_REVIEW_URL = '/api/v1/product/product-reviews';
  static const PRODUCTS_FILTERS_URL =
      '/api/v2/category/filter-group/?category_id=';
  static const SEARCH_QUERY = '/api/v1/search/search-autocomplete';
  static const SEARCH_QUERY_PRODUCTS = '/api/v2/search/search';
  //Authentification
  static const AUTHENTIFICATION_USERS_URL = "/api/v1/user/register";
  static const ONCE_LOGIN = '/api/v2/user/login-phone';
  static const AUTH_VERFY_SMS = '/api/v1/user/verify-code';
  static const LOGIN_VERFY_SMS = '/api/v2/user/login-phone-verify';
  static const EDIT_USER_DATA = '/api/v1/profile/edit';

  //Bonus cart
  static const USER_BONUS_CART = '/api/v1/loan/card-info';
  //Shaharlar
  static const MY_REGIONS = '/api/v1/store/regions';
  //Akisya
  static const AKSIYA_PRODUCTS = '/api/v1/extra/aksii';
  //ariza yuborish post
  static const SUBMIT_AN_APPLICATION = '/front-api/feedback/b2b';
  //Bo'sh ish o'rinlari
  static const JOB_OFFER_DATA = '/api/v1/extra/vacancies';
  //oferta
  static const EXTRA_OFERTA = '/api/v1/extra/page';
  //compare category
  static const COMPARE_CATEGORY = '/api/v1/product/compare-category';
  static const COMPARE_PRODUCT = '/api/v1/product/compare';
  static const ADDRESS_URL = '/api/v2/address/index';
  static const CREATE_ORDER_URL = '/api/v2/order/create';
  static const CREATE_LOAN_ORDER_URL = '/api/v2/order/loan-create';
  static const ALIF_CREATE_LOAN_ORDER_URL = '/api/v2/alif/credit-verify';
  static const INTEND_CREATE_LOAN_ORDER_URL = '/api/v2/intend/credit-preview';
  static const ADD_ADDRESS_URL = '/api/v2/address/add';
  static const REGIONS_URL = '/api/v1/regions/get-regions';
  static const CITY_URL = '/api/v1/regions/get-districts';
  //my oders api
  static const String MY_ORDERS = '/api/v3/order/index';
  static const String MY_ORDERS_GETURL = '/api/v2/order/payment-url';
  static const String MY_ORDER_STATUS = '/api/v1/order/order-status';
  static const String MY_ORDER_CANCEL = '/api/v3/order/cancel-order';
  //Support Service api
  static const String SUPPORT_SERVICE_MESSAGE = '/api/v1/extra/comment';
  static const GET_LOAN_INFO_ONE_URL =
      '/front-api/loan-info/get-mobile-one-info';
  static const GET_ORDER_SCORING_STATUS = '/front-api/skoring/check-order';
  static const CHECK_USER_ALIF = '/api/v2/alif/check-buyer';
  static const CHECK_USER_INTEND = '/api/v2/intend/member-auth';
  static const INTEND_APPLY_ORDER = '/api/v2/intend/credit-verify';
  static const SEND_SMS_ALIF = '/api/v2/alif/request-otp';
  static const SAVE_IMAGE = '/api/v1/extra/save-images';
  //Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String PHONE = 'phone';
  static const String EMAIL = 'email';
  static const String NAME = 'name';
  static const String SUR_NAME = 'sur_name';
  static const String IS_LOGIN = 'is_login';
  static const String GENDER = 'user_gender';
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
