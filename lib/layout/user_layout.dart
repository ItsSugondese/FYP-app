import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/homepage/homepage.dart';
import 'package:fyp/features/notification/notification_screen.dart';
import 'package:fyp/features/order-history/current-order/current_order_screen.dart';
import 'package:fyp/features/user-profile/user_profile_screen.dart';

@RoutePage()
class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  int currentTab = 0;
  final List<Widget> screens = [
    Homepage(),
    CurrentOrderScreen(),
    NotificationScreen(),
    UserProfile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Homepage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppbar(),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          width: Dimension.getScreenWidth(context),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                // minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Homepage();
                    currentTab = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  color: currentTab == 0
                      ? CustomColors.defaultRedColor
                      : Colors.grey,
                ),
              ),
              IconButton(
                // minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = CurrentOrderScreen();
                    currentTab = 1;
                  });
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: currentTab == 1
                      ? CustomColors.defaultRedColor
                      : Colors.grey,
                ),
              ),
              IconButton(
                // minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = NotificationScreen();
                    currentTab = 2;
                  });
                },
                icon: Icon(
                  Icons.notifications,
                  color: currentTab == 2
                      ? CustomColors.defaultRedColor
                      : Colors.grey,
                ),
              ),
              IconButton(
                // minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = UserProfile();
                    currentTab = 3;
                  });
                },
                icon: Icon(
                  Icons.account_circle,
                  color: currentTab == 3
                      ? CustomColors.defaultRedColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
