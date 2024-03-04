import 'package:flutter/material.dart';
import 'package:fyp/features/order-history/current-order/current_order_screen.dart';

class CartLayout extends StatefulWidget {
  const CartLayout({super.key});

  @override
  State<CartLayout> createState() => _CartLayoutState();
}

class _CartLayoutState extends State<CartLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Online Order'),
            bottom: TabBar(tabs: [Text("Order"), Text("Advance Order")]),
          ),
          body: TabBarView(children: [
            CurrentOrderScreen(),
          ]),
        ));
  }
}
