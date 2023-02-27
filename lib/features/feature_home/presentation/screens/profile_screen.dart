
import 'package:besenior_shop_course/features/feature_home/presentation/widgets/profile_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/profile_list_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  List<ProfileListModel> profileList = [
    ProfileListModel(iconData: Icons.person, title: "حساب کاربری شخصی", onTap: (){print("item1");}),
    ProfileListModel(iconData: Icons.shopping_bag_outlined, title: "حساب کاربری فروشگاهی", onTap: (){print("item2");}),
    ProfileListModel(iconData: CupertinoIcons.archivebox_fill, title: "سفارشات", onTap: (){print("item3");}),
    ProfileListModel(iconData: Icons.home_work, title: "آدرس من", onTap: (){print("item4");}),
    ProfileListModel(iconData: Icons.support_agent, title: "پشتیبانی", onTap: (){print("item5");}),
    ProfileListModel(iconData: Icons.exit_to_app, title: "خروج از حساب", onTap: (){print("item6");}),
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: profileList.length,
          itemBuilder: (context, index){
            return ProfileListTile(
                iconData: profileList[index].iconData,
                title: profileList[index].title,
                onTap: profileList[index].onTap,
                isLast: (index == profileList.length - 1) ? true : false
            );
          }
        ),
      ],
    );
  }
}
