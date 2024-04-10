import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/routes/routes_import.gr.dart';

class CustomAppbarProfile extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20 / 2),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 15),
                    ),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.defaultRedColor),
                    elevation: MaterialStateProperty.all(0)),
                onPressed: () {
                  GoogleSignInApi.logout();
                  AutoRouter.of(context).push(const LandingPageScreenRoute());
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
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
