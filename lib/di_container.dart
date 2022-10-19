

import 'package:erik_haydar/provider/localization_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Shared Preference for internal storage
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  //Localization Provider for Language
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));

  

}