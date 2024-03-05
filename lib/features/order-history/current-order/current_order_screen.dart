import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/order-history/current-order/current_online_order_screen.dart';
import 'package:fyp/features/order-history/current-order/current_onsite_order_screen.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class CurrentOrderScreen extends StatefulWidget {
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Online Order'),
            bottom: TabBar(
                isScrollable: true,
                tabs: [Text("Order"), Text("Advance Order")]),
          ),
          drawer: MyDrawer(),
          body: TabBarView(
            children: [
              CurrentOnsiteOrderScreen(),
              CurrentOnlineOrderScreen(),
            ],
          )),
    );
  }
}
