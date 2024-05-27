import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/storage/store_service.dart';
import 'package:fyp/services/user/user_profile_service.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late final UserProfileService userProfileService;

  fetchUserProfile() {}

  @override
  void initState() {
    super.initState();
    userProfileService = UserProfileService(context);
    fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: FutureBuilder<String?>(
              future: Store.getUsername(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data ?? 'No Username');
                }
              },
            ),
            accountEmail: FutureBuilder<String?>(
              future: Store.getEmail(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data ?? 'No Email');
                }
              },
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                ImagePath.getImagePath(ScreenName.landing, "anon.jpg"),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Staff Homepage'),
            onTap: () {
              AutoRouter.of(context).push(const StaffHomepageRoute());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Food Management'),
            onTap: () {
              AutoRouter.of(context).push(const FoodManagementScreenRoute());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Order History'),
            onTap: () {
              AutoRouter.of(context)
                  .push(const OrderHistoryManagementScreenRoute());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Onsite Order Management'),
            onTap: () {
              AutoRouter.of(context).push(const OnsiteOrderScreenRoute());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.online_prediction),
            title: Text('Online Order Management'),
            onTap: () {
              AutoRouter.of(context).push(const OnlineOrderScreenRoute());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('User Payment Management'),
            onTap: () {
              AutoRouter.of(context)
                  .push(const UserPaymentManagementScreenRoute());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              AutoRouter.of(context).pushAndPopUntil(
                  const LandingPageScreenRoute(),
                  predicate: (route) => false);
              Store.clear();
            },
          ),
        ],
      ),
    );
  }
}
