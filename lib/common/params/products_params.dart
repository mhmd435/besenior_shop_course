
class ProductsParams {
  int? start;
  int? step;
  int? categories;
  int? maxPrice;
  int? minPrice;
  String? sortBy;
  String? search;

  ProductsParams({this.start = 0, this.step = 10, this.categories, this.maxPrice, this.minPrice, this.sortBy = "date",this.search});
}