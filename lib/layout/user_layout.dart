import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/homepage/homepage.dart';
import 'package:fyp/features/notification/notification-service/notification_service.dart';
import 'package:fyp/features/notification/notification_screen.dart';
import 'package:fyp/features/order-history/current-order/current_order_screen.dart';
import 'package:fyp/features/user-profile/user_profile_screen.dart';
import 'package:fyp/layout/constants/layout_tab_constant.dart';

@RoutePage()
class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  int currentTab = LayoutTabConstant.intialTab;
  Timer? _timer;
  late NotificationService notificationService;
  late Future<int> notificationServiceFuture;

  GlobalKey _bottomNavigationKey = GlobalKey();

  late List<Widget> screens;

  final PageStorageBucket bucket = PageStorageBucket();
  // Widget currentScreen = Homepage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.screens = [
      Homepage(
        onTabSelected: (val) {
          print("Last screen");
          setState(() {
            currentTab = val;
          });
        },
      ),
      CurrentOrderScreen(),
      NotificationScreen(),
      UserProfile(),
    ];
    notificationService = NotificationService(context);
    fetchNotificationCount();
    _timer = Timer.periodic(Duration(seconds: 7), (timer) {
      fetchNotificationCount();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  fetchNotificationCount() {
    setState(() {
      notificationServiceFuture = notificationService.getNotificationCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppbar(),
      body: PageStorage(
        bucket: bucket,
        child: screens[currentTab],
      ),
      bottomNavigationBar: BottomAppBar(
        key: _bottomNavigationKey,
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
                    // currentScreen = Homepage(globalKey: _bottomNavigationKey,);
                    currentTab = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  color: currentTab == 0
                      ? CustomColors.defaultRedColor
                      : Colors.grey,
                  size: 30,
                ),
              ),
              IconButton(
                // minWidth: 40,
                onPressed: () {
                  setState(() {
                    // currentScreen = CurrentOrderScreen();
                    currentTab = 1;
                  });
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: currentTab == 1
                      ? CustomColors.defaultRedColor
                      : Colors.grey,
                  size: 30,
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    // minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // currentScreen = NotificationScreen();
                        currentTab = 2;
                      });
                    },
                    icon: Stack(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: currentTab == 2
                              ? CustomColors.defaultRedColor
                              : Colors.grey,
                          size: 30,
                        ),
                        Positioned(
                            top: 0,
                            right: -0,
                            child: FutureBuilder<int>(
                                future: notificationServiceFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    int val = snapshot.data!;
                                    return val == 0
                                        ? SizedBox()
                                        : Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .red, // Choose your desired color
                                              shape: BoxShape.circle,
                                            ),
                                            child: showInNotification(
                                                val.toString()));
                                  } else {
                                    return SizedBox();
                                  }
                                })),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                // minWidth: 40,
                onPressed: () {
                  setState(() {
                    // currentScreen = UserProfile();

                    currentTab = 3;
                  });
                },
                icon: Icon(
                  Icons.account_circle,
                  color: currentTab == 3
                      ? CustomColors.defaultRedColor
                      : Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showInNotification(String val) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
        val,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
