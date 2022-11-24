import 'package:dio/dio.dart';
import 'package:erik_haydar/data/repository/auth_repo.dart';
import 'package:erik_haydar/data/repository/category_repo.dart';
import 'package:erik_haydar/data/repository/profile_repo.dart';
import 'package:erik_haydar/data/repository/home_repo.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/provider/detail_film_provider.dart';
import 'package:erik_haydar/provider/detail_music_provider.dart';
import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/provider/localization_provider.dart';
import 'package:erik_haydar/provider/login_provider.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/provider/register_provider.dart';
import 'package:erik_haydar/provider/search_provider.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/dio/dio_client.dart';
import 'data/datasource/dio/logging_interceptor.dart';
import 'data/repository/detail_repo.dart';
import 'provider/favorite_provider.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //DioCLient
  sl.registerFactory(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  //Shared Preference for internal storage
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //Dio and Interceptor
  sl.registerFactory(() => Dio());
  sl.registerFactory(() => LoggingInterceptor());

  //Repositories
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl()));
  sl.registerLazySingleton(() => HomeRepo(dioClient: sl()));
  sl.registerLazySingleton(() => DetailRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  
  //Provider
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => UserDataProvider(sharedPreferences: sl()));
  sl.registerFactory(() => HomeProvider(repo: sl()));
  sl.registerFactory(() => RegisterProvider(authRepo: sl()));
  sl.registerFactory(() => LoginProvider(repo: sl()));
  sl.registerFactory(() => ProfileProvider(repo: sl()));
  sl.registerFactory(() => CategoryProvider(repo: sl()));
  sl.registerFactory(() => SearchProvider(repo: sl()));
  sl.registerFactory(() => FavoriteProvider(repo: sl()));
  sl.registerFactory(() => FilmDetailProvider(repo: sl()));
  sl.registerFactory(() => MusicDetailProvider(repo: sl()));
}
