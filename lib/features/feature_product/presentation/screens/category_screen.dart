import 'package:besenior_shop_course/features/feature_product/data/models/categories_model.dart';
import 'package:besenior_shop_course/features/feature_product/presentation/bloc/category_cubit/category_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/arguments/productsArgument.dart';
import '../../../../common/widgets/dot_loading_widget.dart';
import '../../../../locator.dart';
import 'all_products_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(locator()),
      child: Builder(
          builder: (context) {

            /// call api
            BlocProvider.of<CategoryCubit>(context).loadCategoryEvent();


            return BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                /// loading
                if(state.categoryDataStatus is CategoryDataLoading){
                  return const Center(child: DotLoadingWidget(size: 30));
                }

                if(state.categoryDataStatus is CategoryDataCompleted){
                  CategoryDataCompleted categoryDataCompleted = state.categoryDataStatus as CategoryDataCompleted;
                  CategoriesModel categoriesModel = categoryDataCompleted.categoriesModel;


                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index){
                      Data categoryData = categoriesModel.data![index];
                      /// text
                      return GestureDetector(
                        onTap: (){
                          /// goto All products screen
                          Navigator.pushNamed(context, AllProductsScreen.routeName, arguments: ProductsArguments(categoryId: categoryData.id!),);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              // boxShadow: const [
                              //   BoxShadow(
                              //       blurRadius: 10,
                              //       offset: Offset(5, 5),
                              //       color: Colors.grey
                              //   )
                              // ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl: categoryData.icon!,
                                          errorWidget: (context, string, dynamic){
                                            return const Icon(Icons.error,color: Colors.black,);
                                          },
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          useOldImageOnUrlChange: true,
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(categoryData.title!,style: const TextStyle(color: Colors.black, fontFamily: 'Vazir',fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  const Icon(Icons.arrow_back_ios_new, size: 15,color: Colors.blueAccent,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return SizedBox(height: 10);
                    },
                    itemCount: categoriesModel.data!.length,
                  );
                }


                if(state.categoryDataStatus is CategoryDataError){
                  final CategoryDataError categoryDataError = state.categoryDataStatus as CategoryDataError;

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(categoryDataError.errorMessage,style: const TextStyle(color: Colors.white),),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade800),
                          onPressed: (){
                            /// call all data again
                            BlocProvider.of<CategoryCubit>(context).loadCategoryEvent();
                          },
                          child: const Text("تلاش دوباره"),)
                      ],
                    ),
                  );
                }
                return Container();
              },
            );
          }
      ),
    );
  }
}
