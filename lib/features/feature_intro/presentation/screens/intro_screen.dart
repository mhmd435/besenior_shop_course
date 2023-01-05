
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = "/intro_screen";
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(args),
      ),
    );
  }
}
