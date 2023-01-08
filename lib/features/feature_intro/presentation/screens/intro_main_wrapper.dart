
import 'package:besenior_shop_course/features/feature_intro/presentation/widgets/intro_page.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/get_start_btn.dart';

class IntroMainWrapper extends StatelessWidget {
  static const routeName = "/intro_main_wrapper";
  IntroMainWrapper({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  final List<Widget> introPages = [
    const IntroPage(title: 'تخصص حرف اول رو میزنه!', description: 'اپلیکیشن تخصصی خرید و فروش انواع قطعات یدکی خودروهای داخلی و خارجی با ضمانت اصالت کالا و نازلترین قیمت',),
    const IntroPage(title: 'آسان خرید و فروش کن!', description: 'خرید و فروش سریع و آسان همراه با تیم پشتیبانی قوی',),
    const IntroPage(title: 'همه چی اینجا هست!', description: 'ثبت قطعات کمیاب و خرید و فروش عمده تنها با یک کلیک',),
  ];

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as String;
    /// get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          /// image
          Positioned(
              top: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(150))
                ),
                width: width,
                height: height * 0.6,
                child: Image.asset("assets/images/benz.png")
              )
          ),

          Positioned(
              bottom: height * 0.1,
              child: SizedBox(
                  width: width,
                  height: height * 0.25,
                  child: PageView(
                    controller: pageController,
                    children: introPages,
                  )
              )),

          /// GetStarted Btn
          Positioned(
            bottom: height * 0.07,
            right: 30,
            child: DelayedWidget(
              delayDuration: const Duration(milliseconds: 500),// Not required
              animationDuration: const Duration(seconds: 1),// Not required
              animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
              child: GetStartBtn(
                text: 'ورق بزن',
                onTap: (){

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
