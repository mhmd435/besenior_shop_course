import 'package:besenior_shop_course/config/my_theme.dart';
import 'package:besenior_shop_course/features/feature_intro/presentation/screens/intro_main_wrapper.dart';
import 'package:besenior_shop_course/features/feature_intro/presentation/screens/splash_screen.dart';
import 'package:besenior_shop_course/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLocator();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> SplashCubit()),
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
      },
      debugShowCheckedModeBanner: false,
      title: 'besenior shop',
      home: SplashScreen(),
    );
  }
}
