import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("HOMEPAGE FOR ALL"),
    );
  }
}
