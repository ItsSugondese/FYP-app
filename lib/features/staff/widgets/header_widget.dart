import 'package:flutter/material.dart';

class StaffHomepageHeader extends StatelessWidget {
  final String header;
  const StaffHomepageHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
