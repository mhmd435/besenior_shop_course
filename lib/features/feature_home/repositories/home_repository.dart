

import 'package:besenior_shop_course/features/feature_home/data/data_source/home_api_provider.dart';
import 'package:besenior_shop_course/features/feature_home/data/models/home_model.dart';
import 'package:dio/dio.dart';

import '../../../common/resources/data_state.dart';

class HomeRepository {
  HomeApiProvider apiProvider;
  HomeRepository(this.apiProvider);

  Future<DataState<HomeModel>> fetchHomeData(lat, lon) async {
    try{
      Response response = await apiProvider.callHomeData(lat, lon);
      if(response.statusCode == 200){
        final HomeModel homeModel = HomeModel.fromJson(response.data);
        return DataSuccess(homeModel);
      }else{
        return const DataFailed("موفقیت آمیز نبوده");
      }
    }catch(e){
      return const DataFailed("سرور مشکل دارد");
    }
  }
}