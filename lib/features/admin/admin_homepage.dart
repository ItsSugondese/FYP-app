import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AdminHomepage extends StatefulWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ADMIN page"),
    );
  }
}
