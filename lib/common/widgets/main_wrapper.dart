
import 'package:besenior_shop_course/common/widgets/bottom_nav.dart';
import 'package:besenior_shop_course/features/feature_home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  static const routeName = "/main_wrapper";

  MainWrapper({Key? key}) : super(key: key);

  PageController pageController = PageController();

  List<Widget> topLevelScreens = [
    HomeScreen(),
    Container(color: Colors.black,),
    Container(color: Colors.amber,),
    Container(color: Colors.green,),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(controller: pageController),

      body: Column(
        children: [
          /// search box


          const SizedBox(height: 60,),
          Expanded(
            child: PageView(
              controller: pageController,
              children: topLevelScreens,
            ),
          ),
        ],
      ),
    );
  }
}
