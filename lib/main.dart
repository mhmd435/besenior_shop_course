import 'dart:io';

import 'package:besenior_shop_course/common/blocs/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:besenior_shop_course/config/my_theme.dart';
import 'package:besenior_shop_course/features/feature_auth/presentation/screens/mobile_signup_screen.dart';
import 'package:besenior_shop_course/features/feature_intro/presentation/screens/intro_main_wrapper.dart';
import 'package:besenior_shop_course/features/feature_intro/presentation/screens/splash_screen.dart';
import 'package:besenior_shop_course/features/feature_product/presentation/screens/all_products_screen.dart';
import 'package:besenior_shop_course/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/widgets/main_wrapper.dart';
import 'features/feature_auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'features/feature_auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  await initLocator();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> SplashCubit()),
        BlocProvider(create: (_)=> BottomNavCubit()),
        BlocProvider(create: (_) => locator<SignupBloc>()),
        BlocProvider(create: (_) => locator<LoginBloc>()),
      ],
      child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      initialRoute: "/",
      locale: const Locale("fa",""),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en",""),
        Locale("fa",""),
      ],
      routes: {
        IntroMainWrapper.routeName: (context)=> IntroMainWrapper(),
        TestScreen.routeName: (context)=> TestScreen(),
        MainWrapper.routeName: (context)=> MainWrapper(),
        MobileSignUpScreen.routeName: (context)=> MobileSignUpScreen(),
        AllProductsScreen.routeName: (context)=> AllProductsScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'besenior shop',
      // home: MobileSignUpScreen(),
      home: SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
