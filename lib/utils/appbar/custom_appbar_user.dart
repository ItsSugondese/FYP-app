import 'package:flutter/material.dart';
import 'package:fyp/utils/appbar/widgets/menu-icon.dart';
import 'package:fyp/utils/appbar/widgets/notification-icon.dart';

class CustomUserAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomUserAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25 / 2.5),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ],
      ),
    ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
