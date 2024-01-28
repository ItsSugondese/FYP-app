import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/features/login/login-service/login-service.dart';

@RoutePage()
class LandingPageScreen extends StatefulWidget {
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  final loginService = LoginService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Dimension.getScreenWidth(context),
      height: Dimension.getScreenHeight(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(ImagePath.getImagePath(
                ScreenName.landing, "back iic logo.png")),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: Dimension.getScreenHeight(context) * 0.22,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 51,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {},
                        child: const Text(
                          "Login as Staff",
                          style: TextStyle(
                              color: CustomColors.defaultRedColor,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Yo"),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
