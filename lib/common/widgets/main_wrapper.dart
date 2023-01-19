
import 'package:besenior_shop_course/common/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  static const routeName = "/main_wrapper";

  MainWrapper({Key? key}) : super(key: key);

  PageController pageController = PageController();

  List<Widget> topLevelScreens = [
    Container(color: Colors.red,),
    Container(color: Colors.black,),
    Container(color: Colors.amber,),
    Container(color: Colors.green,),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(controller: pageController),

      body: PageView(
        controller: pageController,
        children: topLevelScreens,
      ),
    );
  }
}
