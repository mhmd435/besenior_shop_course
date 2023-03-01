
import 'package:besenior_shop_course/features/feature_product/presentation/bloc/all_poducts_cubit/all_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/arguments/productsArgument.dart';
import '../../../../common/widgets/main_appbar.dart';
import '../../../../locator.dart';
import '../widgets/products_grid.dart';

class AllProductsScreen extends StatelessWidget {
  static const routeName = '/all_product_screen';

  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// get categoryId
    final arg = ModalRoute.of(context)!.settings.arguments as ProductsArguments;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>  AllProductsCubit(locator())),
        // BlocProvider(create: (_) =>  FilterCubit()),
      ],
      child: Scaffold(

          appBar: const MainAppbar(title: 'محصولات',),

          body: ProductsGrid(categoryId: arg.categoryId, searchText: arg.searchTxt, sellerId: arg.sellerId,),
        ),
    );
  }
}
