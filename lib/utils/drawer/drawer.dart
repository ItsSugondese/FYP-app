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
                'Staff Managemenet',
              ),
              onTap: () {
                AutoRouter.of(context).push(const StaffManagementScreenRoute());
              },
            ),
            ListTile(
              title: Text(
                'User Managemenet',
              ),
              onTap: () {
                AutoRouter.of(context).push(const UserManagementScreenRoute());
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
                'Homepage',
              ),
              onTap: () {
                AutoRouter.of(context).push(const HomepageRoute());
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
