import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/features/landing-screen/landing-screen-service/landing_screen_constants.dart';
import 'package:fyp/features/landing-screen/landing-screen-service/landing_service.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LandingService landingService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    landingService = LandingService(context);
    landingService.ping();
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
              height: Dimension.getScreenHeight(context) * 0.3,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          )
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
