
import 'package:besenior_shop_course/common/utils/prefs_operator.dart';
import 'package:besenior_shop_course/common/widgets/main_wrapper.dart';
import 'package:besenior_shop_course/features/feature_intro/presentation/bloc/intro_cubit/intro_cubit.dart';
import 'package:besenior_shop_course/features/feature_intro/presentation/widgets/intro_page.dart';
import 'package:besenior_shop_course/test_screen.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../locator.dart';
import '../widgets/get_start_btn.dart';

class IntroMainWrapper extends StatelessWidget {
  static const routeName = "/intro_main_wrapper";
  IntroMainWrapper({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  final List<Widget> introPages = [
    const IntroPage(title: 'تخصص حرف اول رو میزنه!', description: 'اپلیکیشن تخصصی خرید و فروش انواع قطعات یدکی خودروهای داخلی و خارجی با ضمانت اصالت کالا و نازلترین قیمت',image: "assets/images/benz.png",),
    const IntroPage(title: 'آسان خرید و فروش کن!', description: 'خرید و فروش سریع و آسان همراه با تیم پشتیبانی قوی',image: "assets/images/bmw.png",),
    const IntroPage(title: 'همه چی اینجا هست!', description: 'ثبت قطعات کمیاب و خرید و فروش عمده تنها با یک کلیک',image: "assets/images/tara.png",),
  ];

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as String;
    /// get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => IntroCubit(),
      child: Builder(
        builder: (context) {
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
                      )
                  ),

                  Positioned(
                      bottom: height * 0.1,
                      child: SizedBox(
                          width: width,
                          height: height * 0.9,
                          child: PageView(
                            onPageChanged: (index){
                              if(index == 2){
                                BlocProvider.of<IntroCubit>(context).changeGetStart(true);
                              }else{
                                BlocProvider.of<IntroCubit>(context).changeGetStart(false);
                              }
                            },
                            controller: pageController,
                            children: introPages,
                          )
                      )),

                  /// GetStarted Btn
                  Positioned(
                    bottom: height * 0.07,
                    right: 30,
                    child: BlocBuilder<IntroCubit, IntroState>(
                      builder: (context, state) {
                        if(state.showGetStart){
                          return GetStartBtn(
                            text: 'شروع کنید',
                            onTap: (){
                              PrefsOperator prefsOperator = locator<PrefsOperator>();
                              prefsOperator.changeIntroState();

                              /// goto home screen
                              Navigator.pushNamedAndRemoveUntil(context, MainWrapper.routeName, ModalRoute.withName("main_wrapper"),);
                            },
                          );
                        }else{
                          return DelayedWidget(
                            delayDuration: const Duration(milliseconds: 500),// Not required
                            animationDuration: const Duration(seconds: 1),// Not required
                            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                            child: GetStartBtn(
                              text: 'ورق بزن',
                              onTap: (){
                                if(pageController.page!.toInt() < 2){
                                  if(pageController.page!.toInt() == 1){
                                    BlocProvider.of<IntroCubit>(context).changeGetStart(true);
                                  }

                                  pageController.animateToPage(
                                      pageController.page!.toInt() + 1,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeIn
                                  );
                                }
                              },
                            ),
                          );
                        }

                      },
                    ),
                  ),

                  Positioned(
                      bottom: height * 0.07,
                      left: 30,
                      child: DelayedWidget(
                          delayDuration: const Duration(milliseconds: 300),// Not required
                          animationDuration: const Duration(seconds: 1),// Not required
                          animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                          child: SmoothPageIndicator(
                              controller: pageController,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                spacing: 5,
                                activeDotColor: Colors.amber
                              ),
                          )
                      ),
                  )
                ],
              ),
            );
        }
      ),
    );
  }
}
