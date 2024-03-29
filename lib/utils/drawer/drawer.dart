import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/routes/routes_import.gr.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: Dimension.getScreenWidth(context) * 0.65,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              width: Dimension.getScreenWidth(context) * 0.2,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                ' window',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Staff Homepage',
              ),
              onTap: () {
                AutoRouter.of(context).push(const StaffHomepageRoute());
              },
            ),
            ListTile(
              title: Text(
                'Food Managemenet',
              ),
              onTap: () {
                AutoRouter.of(context).push(const FoodManagementScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'Order History',
              ),
              onTap: () {
                AutoRouter.of(context)
                    .push(const OrderHistoryManagementScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'Onsite Order Management',
              ),
              onTap: () {
                AutoRouter.of(context).push(const OnsiteOrderScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'Online Order Management',
              ),
              onTap: () {
                AutoRouter.of(context).push(const OnlineOrderScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'User Payment management',
              ),
              onTap: () {
                AutoRouter.of(context)
                    .push(const UserPaymentManagementScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'Homepage',
              ),
              onTap: () {
                AutoRouter.of(context).push(const HomepageRoute());
              },
            ),
            ListTile(
              title: Text(
                'Feedback',
              ),
              onTap: () {
                AutoRouter.of(context).push(const FeedbackProvideScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'Order History Screen',
              ),
              onTap: () {
                AutoRouter.of(context).push(const OrderHistoryScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'Today Order history',
              ),
              onTap: () {
                AutoRouter.of(context).push(const CurrentOrderScreenRoute());
              },
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                AutoRouter.of(context).push(const LoginScreenRoute());
              },
            ),
          ],
        ));
  }
}
