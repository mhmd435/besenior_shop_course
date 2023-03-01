
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PagingLoadingWidget extends StatelessWidget {
  final double size;
  const PagingLoadingWidget({Key? key,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            size: size,
            color: Colors.redAccent,
          ),
      ),
    );
  }
}
