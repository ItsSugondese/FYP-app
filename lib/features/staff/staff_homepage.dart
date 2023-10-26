import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StaffHomepage extends StatefulWidget {
  const StaffHomepage({Key? key}) : super(key: key);

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("STAFF homepage"),
    );
  }
}
