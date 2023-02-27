part of 'all_products_cubit.dart';

class AllProductsState {
  ProductsDataStatus productsDataStatus;
  List<Products> allProducts;
  int nextStart;
  bool isLoadingPaging;

  AllProductsState({
    required this.productsDataStatus,
    required this.allProducts,
    required this.nextStart,
    required this.isLoadingPaging,
  });

  AllProductsState copyWith({
    ProductsDataStatus? newProductsDataStatus,
    List<Products>? newAllProducts,
    int? newNextStart,
    bool? newIsLoadingPaging,
  }){
    return AllProductsState(
        productsDataStatus: newProductsDataStatus ?? productsDataStatus,
        allProducts: newAllProducts ?? allProducts,
        nextStart: newNextStart ?? nextStart,
        isLoadingPaging: newIsLoadingPaging ?? isLoadingPaging,
    );
  }
}
