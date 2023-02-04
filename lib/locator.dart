

import 'package:besenior_shop_course/common/utils/prefs_operator.dart';
import 'package:besenior_shop_course/features/feature_home/data/data_source/home_api_provider.dart';
import 'package:besenior_shop_course/features/feature_home/repositories/home_repository.dart';
import 'package:besenior_shop_course/features/feature_product/data/data_source/category_api_provider.dart';
import 'package:besenior_shop_course/features/feature_product/repositories/category_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async{
  locator.registerSingleton<Dio>(Dio());

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<PrefsOperator>(PrefsOperator());


  /// api provider
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider(locator()));
  locator.registerSingleton<CategoryApiProvider>(CategoryApiProvider(locator()));

  /// repository
  locator.registerSingleton<HomeRepository>(HomeRepository(locator()));
  locator.registerSingleton<CategoryRepository>(CategoryRepository(locator()));


}