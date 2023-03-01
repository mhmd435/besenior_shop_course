
import 'package:dio/dio.dart';

import '../../../../common/error_handling/check_exceptions.dart';
import '../../../../common/params/products_params.dart';
import '../../../../config/constants.dart';

class ProductsApiProvider {
  Dio dio;
  ProductsApiProvider(this.dio);

  dynamic callAllProducts(ProductsParams productsParams) async {
    try{

      print(productsParams.categories);

      final response = await dio.post(
        "${Constants.baseUrl}/products",
        data: {
          "start": productsParams.start,
          "step": productsParams.step,
          "categories": productsParams.categories,
          "maxPrice": productsParams.maxPrice,
          "minPrice": productsParams.minPrice,
          "sortby": productsParams.sortBy,
          'search': productsParams.search
        },
      );

      print(response);
      return response;
    } on DioError catch(e) {
      print(e.toString());
      return CheckExceptions.response(e.response!);
    }

  }
}