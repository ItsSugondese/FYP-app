import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/features/order-mgmt/order_time_constant.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/podo/dashboard/payload/food_menu_data_payload.dart';
import 'package:fyp/podo/dashboard/payload/order_data_payload.dart';
import 'package:fyp/podo/dashboard/payload/sales_data_payload.dart';
import 'package:fyp/podo/dashboard/responses/food_menu_data.dart';
import 'package:fyp/podo/dashboard/responses/order_data.dart';
import 'package:fyp/podo/dashboard/responses/sales_data.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';
import 'package:fyp/services/dashboard/dashboard_service.dart';
import 'package:fyp/templates/circular_indicator/default_circular_indicator.dart';
import 'package:fyp/utils/appbar/custom-appbar.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class StaffHomepage extends StatefulWidget {
  const StaffHomepage({Key? key}) : super(key: key);

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {
  FoodMenuDataPayload foodMenuPayload = FoodMenuDataPayload();
  RevenueDataPayload revenueDataPayload = RevenueDataPayload();
  OrderDataPayload orderPayload =
      OrderDataPayload(timeDifference: OrderTimeConstant.timeInterval);
  late Future<RevenueData> revenueDataFuture;
  late Future<OrderData> orderDataFuture;
  late Future<FoodMenuData> foodMenuDataFuture;
  late DashboardService dashboardService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardService = DashboardService(context);
    refresh();
  }

  Future<void> refresh() async {
    setState(() {
      foodMenuDataFuture =
          dashboardService.getFoodData(foodMenuPayload.toJson());
      revenueDataFuture =
          dashboardService.getRevenueData(revenueDataPayload.toJson());
      orderDataFuture = dashboardService.getOrderData(orderPayload.toJson());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    Text("Today Sales Data"),
                    FutureBuilder<RevenueData>(
                        future: revenueDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const DefaultCircularIndicator(height: 0.7);
                          } else if (snapshot.hasData) {
                            RevenueData data = snapshot.data!;
                            return Column(
                              children: [
                                Text("${data.paidAmount}"),
                                Text("${data.leftToPay}"),
                                Text("${data.deliveredOrder}"),
                              ],
                            );
                          } else {
                            return Text("error");
                          }
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text(
                        "Pending Orders ${OrderTimeConstant.timeInterval} minutes"),
                    FutureBuilder<OrderData>(
                        future: orderDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const DefaultCircularIndicator(height: 0.7);
                          } else if (snapshot.hasData) {
                            OrderData data = snapshot.data!;
                            return Column(
                              children: [
                                Text("${data.totalPending}"),
                                Text("${data.onsiteOrder.pending}"),
                                Text("${data.onlineOrder.pending}"),
                              ],
                            );
                          } else {
                            return Text("error");
                          }
                        }),
                  ],
                ),
                Column(
                  children: [
                    Text("Food Menu Data"),
                    FutureBuilder<FoodMenuData>(
                        future: foodMenuDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const DefaultCircularIndicator(height: 0.7);
                          } else if (snapshot.hasData) {
                            FoodMenuData data = snapshot.data!;
                            return Column(
                              children: [
                                Text("${data.total}"),
                                Text("${data.today}"),
                                Text("${data.notToday}"),
                              ],
                            );
                          } else {
                            return Text("error");
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
