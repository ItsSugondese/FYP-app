import 'package:flutter/material.dart';
import 'package:fyp/features/homepage/homepage.dart';
import 'package:fyp/features/order-history/current-order/current_order_screen.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  int currentTab = 0;
  final List<Widget> screens = [Homepage(), CurrentOrderScreen()];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
