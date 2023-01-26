
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/widgets/dot_loading_widget.dart';
import '../../../../config/responsive.dart';

class DeepLinks extends StatelessWidget {
  final String image;
  final String title;
  const DeepLinks({Key? key, required this.image, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, string){
                return Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: const SizedBox(height: 50,width: 50,));
              },
              fit: BoxFit.cover,
              useOldImageOnUrlChange: true,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Text(title, style: TextStyle(fontFamily: 'Vazir', fontSize: Responsive.isMobile(context) ? 11 : 18),)
      ],
    );
  }
}
