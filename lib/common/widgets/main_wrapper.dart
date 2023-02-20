
import 'package:besenior_shop_course/common/widgets/bottom_nav.dart';
import 'package:besenior_shop_course/features/feature_home/presentation/screens/home_screen.dart';
import 'package:besenior_shop_course/features/feature_home/presentation/screens/profile_screen.dart';
import 'package:besenior_shop_course/features/feature_product/presentation/screens/category_screen.dart';
import 'package:flutter/material.dart';

import '../../features/feature_product/presentation/widgets/search_textfield.dart';
import '../../features/feature_product/repositories/all_product_repository.dart';
import '../../locator.dart';

class MainWrapper extends StatelessWidget {
  static const routeName = "/main_wrapper";

  MainWrapper({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  PageController pageController = PageController();

  List<Widget> topLevelScreens = [
    HomeScreen(),
    CategoryScreen(),
    ProfileScreen(),
    Container(color: Colors.green,),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(controller: pageController),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),

            /// search Box
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey.shade400,
                        offset: const Offset(0, 3)
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10, bottom: 10),
                child: SearchTextField(controller: searchController, allProductsRepository: locator<AllProductsRepository>(),),
              ),
            ),
            const SizedBox(height: 10,),

            Expanded(
              child: PageView(
                controller: pageController,
                children: topLevelScreens,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
