import 'package:flutter/material.dart';
import 'package:fyp/features/everyone/login/login.dart';

import 'features/everyone/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : TestClass(),
    );
  }
}


