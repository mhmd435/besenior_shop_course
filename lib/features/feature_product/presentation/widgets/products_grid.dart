
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../common/widgets/dot_loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_widget/delayed_widget.dart';

import '../../../../common/params/products_params.dart';
import '../../../../common/widgets/paging_loading_widget.dart';
import '../../data/models/all_products_model.dart';
import '../bloc/all_poducts_cubit/all_products_cubit.dart';

class ProductsGrid extends StatelessWidget {
  final int? categoryId;
  final int? sellerId;
  final String? searchText;
  ProductsGrid({Key? key, this.categoryId, this.sellerId, this.searchText}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    setupScrollController(context);
    /// call api for data
    BlocProvider.of<AllProductsCubit>(context).loadProductsData(ProductsParams(categories: categoryId,search: searchText ?? ""));

    return BlocBuilder<AllProductsCubit, AllProductsState>(
      builder: (context, state) {

        if(state.productsDataStatus is ProductsDataLoading){
          return const Center(child: DotLoadingWidget(size: 30));
        }

        if(state.productsDataStatus is ProductsDataCompleted){
          ProductsDataCompleted productsDataCompleted = state.productsDataStatus as ProductsDataCompleted;
          AllProductsModel allProductsModel = productsDataCompleted.allProductsModel;
          List<Products> allProducts = state.allProducts;

          return RefreshIndicator(
            onRefresh: () async {
              // BlocProvider.of<AllProductsCubit>(context).add(ResetNextStartEvent());
              BlocProvider.of<AllProductsCubit>(context).loadProductsData(ProductsParams(categories: categoryId,search: searchText ?? ""));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  /// filter btn
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 3,
                            shadowColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed: (){
                          // showFilterBottomSheet(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('فیلتر', style: TextStyle(fontFamily: 'Vazir', color: Colors.black),),
                            Icon(Icons.filter_list_alt,color: Colors.black),
                          ],
                        )
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// all product gridview or no products for show
                  (allProducts.isNotEmpty)
                  ? Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: allProducts.length,
                      // itemCount: allProductsModel.data![0].products!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.65
                      ),
                      itemBuilder: (BuildContext context, int index){
                        final productImage = allProducts[index].image;
                        final productName = allProducts[index].name;
                        final productCategoryName = allProducts[index].category;
                        final productDiscount = allProducts[index].discount;
                        final productPrice = allProducts[index].price;
                        final productPriceBeforeDiscount = allProducts[index].priceBeforDiscount;

                        return GestureDetector(
                          onTap: (){
                            /// goto All products screen
                            // Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: ProductDetailArguments(allProducts[index].id!),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                      color: Colors.grey
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  /// product image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: productImage!,
                                      placeholder: (context, string){
                                        return const SizedBox(
                                          height: 100,
                                        );
                                      },
                                      errorWidget: (context, string, dynamic){
                                        return Icon(Icons.error,color: Colors.black,);
                                      },
                                      fit: BoxFit.cover,
                                      useOldImageOnUrlChange: true,
                                    ),
                                  ),

                                  /// product name
                                  Text(productName!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12),),
                                  Text(productCategoryName!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 12),),
                                  SizedBox(height: 10,),

                                  /// product price and discount
                                  Row(
                                    children: [

                                      /// discount red container
                                      (productDiscount != 0)
                                          ? Container(
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Center(child: Text("${productDiscount.toString().toPersianDigit()}%", style: const TextStyle(fontFamily: 'Vazir',color: Colors.white, fontWeight: FontWeight.bold,fontSize: 13),)),
                                      )
                                          : Container(),

                                      const Spacer(),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Text(productPrice.toString().toPersianDigit(), style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 13),),
                                              (productPriceBeforeDiscount != "0")
                                                  ? Text(productPriceBeforeDiscount!.toPersianDigit(), style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 11,decoration: TextDecoration.lineThrough),)
                                                  : Container(),
                                            ],
                                          ),
                                          SizedBox(width: 5,),
                                          const Text('تومان', style: TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  : const Expanded(child: Center(child: Text('محصولی برای نمایش وجود ندارد', style: TextStyle(fontFamily: 'Vazir', color: Colors.black)),)),


                  /// paging loading
                  (state.isLoadingPaging)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: DelayedWidget(
                              delayDuration: const Duration(milliseconds: 100),// Not required
                              animationDuration: const Duration(milliseconds: 500),// Not required
                              animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                              child: const PagingLoadingWidget(size: 40)
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        }

        if(state.productsDataStatus is ProductsDataError){
          final ProductsDataError productsDataError = state.productsDataStatus as ProductsDataError;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(productsDataError.errorMessage,style: const TextStyle(color: Colors.black),),
                const SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: (){
                    /// call all data again
                    BlocProvider.of<AllProductsCubit>(context).loadProductsData(ProductsParams(categories: categoryId,search: searchText ?? ""));

                  },
                  child:  const Text("تلاس دوباره"),)
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  void setupScrollController(BuildContext context){
    scrollController.addListener(() {
      if(scrollController.position.atEdge){
        if(scrollController.position.pixels != 0){
          BlocProvider.of<AllProductsCubit>(context).loadProductsData(ProductsParams(categories: categoryId,search: searchText ?? ""));
        }
      }
    });
  }

  // void showFilterBottomSheet(ct) {
  //   showModalBottomSheet(
  //       context: ct,
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
  //       ),
  //       builder: (context){
  //         return BlocProvider.value(
  //           value: BlocProvider.of<FilterCubit>(ct),
  //           child: BlocProvider.value(
  //                       value: BlocProvider.of<ProductsBloc>(ct),
  //                       child: FilterBottomSheet(categoryId: categoryId,)),
  //         );
  //   });
  // }
}
