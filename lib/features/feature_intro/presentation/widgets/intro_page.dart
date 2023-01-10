
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  const IntroPage({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DelayedWidget(
            delayDuration: const Duration(milliseconds: 300),// Not required
            animationDuration: const Duration(seconds: 1),// Not required
            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
            child: Text(title, style: textTheme.titleMedium,),
          ),
          const SizedBox(height: 10,),
          DelayedWidget(
              delayDuration: const Duration(milliseconds: 600),// Not required
              animationDuration: const Duration(seconds: 1),// Not required
              animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
              child: Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.grey,
                  child: Text(description, style: textTheme.bodyMedium))
          ),
        ],
      ),
    );
  }
}
