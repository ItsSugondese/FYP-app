import 'package:flutter/material.dart';
import 'package:fyp/features/people-mgmt/staff-mgmt/staff_management_screen.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:auto_route/auto_route.dart';

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
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
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
          title: Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () {
            AutoRouter.of(context).push(const LoginScreenRoute());
          },
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
            'Homepage',
          ),
          onTap: () {
            AutoRouter.of(context).push(const HomepageRoute());
          },
        ),
      ],
    ));
  }
}
