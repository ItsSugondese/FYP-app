import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          // backgroundColor: Colors.white,
          appBar: const CustomTabBar(),
          // appBar: AppBar(
          //   elevation: 0,
          //   // title: Text(
          //   //   'Current Orders',
          //   //   style: TextStyle(color: Colors.black),
          //   // ),
          //   // centerTitle: true,
          //   backgroundColor: Colors.white,
          //   // bottom: TabBar(
          //   //     isScrollable: true,
          //   //     tabs: [Text("Order"), Text("Advance Order")]),

          //   bottom: PreferredSize(
          //     preferredSize: const Size.fromHeight(40),
          //     child: ClipRRect(
          //       borderRadius: const BorderRadius.all(Radius.circular(10)),
          //       child: Container(
          //         height: 40,
          //         margin: const EdgeInsets.symmetric(horizontal: 20),
          //         decoration: BoxDecoration(
          //           borderRadius: const BorderRadius.all(Radius.circular(10)),
          //           color: Colors.green.shade100,
          //         ),
          //         child: const TabBar(
          //           indicatorSize: TabBarIndicatorSize.tab,
          //           dividerColor: Colors.transparent,
          //           indicator: BoxDecoration(
          //             color: Colors.green,
          //             borderRadius: BorderRadius.all(Radius.circular(10)),
          //           ),
          //           labelColor: Colors.white,
          //           unselectedLabelColor: Colors.black54,
          //           tabs: [
          //             TabItem(title: 'Order', count: 6),
          //             TabItem(title: 'Online Order', count: 3),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // drawer: MyDrawer(),
          body: TabBarView(
            children: [
              CurrentOnsiteOrderScreen(),
              CurrentOnlineOrderScreen(),
            ],
          )),
    );
  }
}
