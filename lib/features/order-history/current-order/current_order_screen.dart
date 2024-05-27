import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/order-history/current-order/constatns/current_order_constants.dart';
import 'package:fyp/features/order-history/current-order/current_online_order_screen.dart';
import 'package:fyp/features/order-history/current-order/current_onsite_order_screen.dart';
import 'package:fyp/features/order-history/current-order/widgets/custom_tab_item.dart';
import 'package:fyp/utils/appbar/custom_appbar_tabbar.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class CurrentOrderScreen extends StatefulWidget {
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with the desired initial index (e.g., 1 for the second tab)
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: CurrentOrderConstants.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.white,
          appBar: CustomTabBar(
            controller: _tabController,
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              CurrentOnsiteOrderScreen(),
              CurrentOnlineOrderScreen(),
            ],
          )),
    );
  }
}
