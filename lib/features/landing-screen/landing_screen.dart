import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/features/landing-screen/landing-screen-service/landing_screen_constants.dart';
import 'package:fyp/features/login/login-service/login-service.dart';
import 'package:fyp/routes/routes_import.gr.dart';

@RoutePage()
class LandingPageScreen extends StatefulWidget {
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  late LoginService loginService;
  int buttonFontSize = 18;

  @override
  void initState() {
    super.initState();
    loginService = LoginService(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Dimension.getScreenWidth(context),
      height: Dimension.getScreenHeight(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: CustomClipperAppBar(),
              child: Container(
                width: double.infinity,
                height: Dimension.getScreenHeight(context) * 0.5,
                decoration: ShapeDecoration(
                    color: CustomColors.defaultRedColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Image.asset(
                  ImagePath.getImagePath(ScreenName.landing, "login_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100,
              child: Image.asset(
                ImagePath.getImagePath(ScreenName.landing, "back iic logo.png"),
                fit: BoxFit.fill,
              ),
            ),
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
                        onPressed: () {
                          AutoRouter.of(context).push(const LoginScreenRoute());
                        },
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
                        onPressed: () async {
                          loginService.signIn(context);
                        },
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
              )),
        ],
      ),
    ));
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.73);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.73);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.73);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
