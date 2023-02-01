
import 'package:besenior_shop_course/features/feature_product/data/models/categories_model.dart';
import 'package:dio/dio.dart';

import '../../../common/error_handling/app_exception.dart';
import '../../../common/error_handling/check_exceptions.dart';
import '../../../common/resources/data_state.dart';
import '../data/data_source/category_api_provider.dart';

class CategoryRepository {
  CategoryApiProvider apiProvider;
  CategoryRepository(this.apiProvider);

  Future<DataState<CategoriesModel>> fetchCategoryData() async {
    try{
      Response response = await apiProvider.callCategories();
      final CategoriesModel categoriesModel = CategoriesModel.fromJson(response.data);
      return DataSuccess(categoriesModel);
    } on AppException catch(e){
      return await CheckExceptions.getError(e);
    }
  }
}