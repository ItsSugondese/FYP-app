import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgPathHelper {
  static Widget buildLink(
      {required String svgCode,
      required String label,
      required VoidCallback onTap,
      double width = 24,
      double height = 24,
      Color color = Colors.black}) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 15),
          ),
          shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0)),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.string(
              svgCode,
              width: width,
              height: height,
              color: color, // Change color as needed
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
