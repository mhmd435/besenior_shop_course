
import 'package:dio/dio.dart';

import '../../../common/params/products_params.dart';
import '../data/data_source/product_api_provider.dart';
import '../data/models/all_products_model.dart';

class AllProductsRepository {
  ProductsApiProvider apiProvider;
  AllProductsRepository(this.apiProvider);

  Future<List<Products>> fetchAllProductsDataSearch(ProductsParams productsParams) async {

    Response response = await apiProvider.callAllProducts(productsParams);
    final AllProductsModel allProductsModel = AllProductsModel.fromJson(response.data);

    return allProductsModel.data![0].products!;
  }
}