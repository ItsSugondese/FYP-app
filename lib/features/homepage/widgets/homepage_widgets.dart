import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';

class HomepageWidgets {
  final BuildContext context;

  HomepageWidgets({required this.context});

  Container getContentContainer(Widget widget) {
    return Container(
      width: Dimension.getScreenWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: Dimension.getScreenHeight(context) * 0.63,
      child: widget,
    );
  }
}
