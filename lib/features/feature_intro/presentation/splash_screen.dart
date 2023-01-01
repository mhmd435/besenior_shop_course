
import 'package:besenior_shop_course/common/utils/custom_snackbar.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotoHome();
  }
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: DelayedWidget(
                    delayDuration: const Duration(milliseconds: 200),
                    animationDuration: const Duration(milliseconds: 1000),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Image.asset('assets/images/besenior_logo.png',width: width * 0.8,))),
            const Text('به اینترنت متصل نیستید!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontFamily: "vazir"),),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  Future<void> gotoHome() {
    return Future.delayed(const Duration(seconds: 3),(){
      CustomSnackBar.showSnack(context, "وارد شدید", Colors.green);
    });

  }
}
