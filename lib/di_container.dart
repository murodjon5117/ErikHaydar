import 'package:dio/dio.dart';
import 'package:erik_haydar/data/repository/auth_repo.dart';
import 'package:erik_haydar/data/repository/home_repo/home_repo.dart';
import 'package:erik_haydar/provider/home_provider/home_provider.dart';
import 'package:erik_haydar/data/repository/profile_repo.dart';
import 'package:erik_haydar/provider/localization_provider.dart';
import 'package:erik_haydar/provider/login_provider.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/provider/register_provider.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/dio/dio_client.dart';
import 'data/datasource/dio/logging_interceptor.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //DioCLient
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  //Shared Preference for internal storage
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //Dio and Interceptor
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());

  //Repositories
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));

  //Provider
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => HomeProvider(repo: sl()));

  sl.registerFactory(
      () => RegisterProvider(authRepo: sl(), sharedPreferences: sl()));

  sl.registerFactory(() => LoginProvider(sharedPreferences: sl(), repo: sl()));

  sl.registerFactory(
      () => ProfileProvider(sharedPreferences: sl(), repo: sl()));
}
