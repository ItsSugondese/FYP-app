import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';

class DefaultCircularIndicator extends StatefulWidget {
  final double? height;
  const DefaultCircularIndicator({super.key, this.height});

  @override
  State<DefaultCircularIndicator> createState() =>
      _DefaultCircularIndicatorState();
}

class _DefaultCircularIndicatorState extends State<DefaultCircularIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height == null
          ? null
          : Dimension.getScreenHeight(context) * widget.height!,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
