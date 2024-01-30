import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/features/landing-screen/landing-screen-service/landing_screen_constants.dart';
import 'package:fyp/features/login/login-service/login-service.dart';

@RoutePage()
class LandingPageScreen extends StatefulWidget {
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  int buttonFontSize = 18;
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
                            shape: MaterialStateProperty.all(
                                const StadiumBorder()),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            side: MaterialStateProperty.all(const BorderSide(
                              color: CustomColors
                                  .defaultRedColor, // Set the border color
                              width: 1.0, // Set the border width
                              style: BorderStyle
                                  .solid, // Set the border style (solid, dashed, etc.)
                            )),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {},
                        child: const Text(
                          "Login as Staff",
                          style: TextStyle(
                              color: CustomColors.defaultRedColor,
                              fontSize: LandingScreenConstants.buttonFontSize,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 51,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const StadiumBorder()),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            side: MaterialStateProperty.all(const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.solid,
                            )),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              child: Image.asset(ImagePath.getImagePath(
                                  ScreenName.landing, "google.png")),
                            ),
                            // const Spacer(),
                            const Spacer(),
                            const Text(
                              "Sign in with Google",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: LandingScreenConstants.buttonFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const Spacer()
                          ],
                        ),
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
