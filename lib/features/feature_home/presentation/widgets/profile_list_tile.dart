
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final Function() onTap;
  final bool isLast;
  const ProfileListTile({Key? key, this.iconData = Icons.add,required this.title, required this.onTap,required this.isLast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: TextStyle(color: (isLast) ? Colors.red : Colors.grey.shade700,fontWeight: FontWeight.bold,fontSize: 14),),
      leading: Icon(iconData, color: (isLast) ? Colors.red : Colors.grey.shade700,),
      trailing: Icon(Icons.arrow_right, color: (isLast) ? Colors.red : Colors.grey.shade700,),
    );
  }
}
