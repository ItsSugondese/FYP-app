import 'package:flutter/material.dart';

class Dimension {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getAppbarHeight(BuildContext context) {
    return AppBar().preferredSize.height;
  }
}
