import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/features/landing-screen/landing-screen-service/landing_screen_constants.dart';

// ignore: must_be_immutable
class DefaultButtonNoInfinity extends StatelessWidget {
  final String text;
  Color? bgColor = CustomColors.defaultRedColor;
  Color? color = Colors.white;
  final VoidCallback? onPressed;
  bool? hasBorder = false;
  Color? borderColor = CustomColors.defaultRedColor;

  DefaultButtonNoInfinity(
      {super.key,
      required this.text,
      this.bgColor,
      this.color,
      required this.onPressed,
      this.hasBorder,
      this.borderColor = CustomColors.defaultRedColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ButtonStyle(
          side: hasBorder ?? false
              ? MaterialStateProperty.all(BorderSide(
                  color: borderColor!, // Set the border color
                  width: 1.0, // Set the border width
                  style: BorderStyle
                      .solid, // Set the border style (solid, dashed, etc.)
                ))
              : null,
          backgroundColor: MaterialStateProperty.all(bgColor),
          // elevation: MaterialStateProperty.all(0)
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: color,
              fontSize: LandingScreenConstants.buttonFontSize,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
