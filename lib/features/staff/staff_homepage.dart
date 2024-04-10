import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/features/order-mgmt/order_time_constant.dart';
import 'package:fyp/features/staff/widgets/header_widget.dart';
import 'package:fyp/features/staff/widgets/normal_data_card.dart';
import 'package:fyp/features/staff/widgets/payment_card_widget.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const StaffHomepageHeader(header: "Sales Data"),
                    FutureBuilder<RevenueData>(
                        future: revenueDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const DefaultCircularIndicator();
                          } else if (snapshot.hasData) {
                            RevenueData data = snapshot.data!;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PaymentCard(
                                    amount: '${data.paidAmount}',
                                    label: 'Total Paid'),
                                PaymentCard(
                                    amount: '${data.leftToPay}',
                                    label: 'Left to Pay'),
                                PaymentCard(
                                    amount: '${data.deliveredOrder}',
                                    label: 'Order Delivered'),
                              ],
                            );
                          } else {
                            return Text("error");
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    StaffHomepageHeader(
                        header:
                            "Pending Orders (${OrderTimeConstant.timeInterval} minutes)"),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<OrderData>(
                        future: orderDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const DefaultCircularIndicator();
                          } else if (snapshot.hasData) {
                            OrderData data = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalDataCard(
                                    amount: "${data.onsiteOrder.pending}",
                                    label: "Onsite Order"),
                                NormalDataCard(
                                    amount: "${data.onlineOrder.pending}",
                                    label: "Online Order")
                              ],
                            );
                          } else {
                            return Text("error");
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    const StaffHomepageHeader(header: "Food Menu Data"),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<FoodMenuData>(
                        future: foodMenuDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const DefaultCircularIndicator();
                          } else if (snapshot.hasData) {
                            FoodMenuData data = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalDataCard(
                                    amount: "${data.today}",
                                    label: "Available"),
                                NormalDataCard(
                                    amount: "${data.notToday}",
                                    label: "Not available")
                              ],
                            );

                            // Column(
                            //   children: [
                            //     Text("${data.total}"),
                            //     Text("${data.today}"),
                            //     Text("${data.notToday}"),
                            //   ],
                            // );
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
