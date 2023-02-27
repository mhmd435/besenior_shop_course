part of 'all_products_cubit.dart';

@immutable
abstract class ProductsDataStatus {}

class ProductsDataInitial extends ProductsDataStatus {}

class ProductsDataLoading extends ProductsDataStatus {}

class ProductsDataCompleted extends ProductsDataStatus {
  final AllProductsModel allProductsModel;
  ProductsDataCompleted(this.allProductsModel);
}

class ProductsDataError extends ProductsDataStatus {
  final String errorMessage;
  ProductsDataError(this.errorMessage);
}
