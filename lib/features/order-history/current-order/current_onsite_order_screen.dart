import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/homepage/khati_dart.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/features/order-history/order-history-service/order_history_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/model/user-order/user_order_history.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';
import 'package:fyp/podo/user-order/user_order_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:fyp/services/payment/payment_service.dart';
import 'package:fyp/templates/text/food_type_text.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class CurrentOnsiteOrderScreen extends StatefulWidget {
  const CurrentOnsiteOrderScreen({super.key});

  @override
  State<CurrentOnsiteOrderScreen> createState() =>
      _CurrentOnsiteOrderScreenState();
}

class _CurrentOnsiteOrderScreenState extends State<CurrentOnsiteOrderScreen> {
  late OnsiteOrderService onsiteOrderService;

  late Future<List<OnsiteOrder>> onsiteOrderHistoryFuture;

  UserOrderHistoryPagination paginationPayload =
      UserOrderHistoryPagination(fromDate: '2024-01-01', toDate: '2024-01-31');

  @override
  void initState() {
    super.initState();
    onsiteOrderService = OnsiteOrderService(context);
    fetchOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchOrder() {
    onsiteOrderHistoryFuture = onsiteOrderService.getUserOnsiteOrderHistory();
  }

  Future<void> refresh() async {
    setState(() {
      fetchOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimension.getScreenHeight(context),
      child: FutureBuilder<List<OnsiteOrder>>(
          future: onsiteOrderHistoryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<OnsiteOrder> orderList = snapshot.data!;
              return RefreshIndicator(
                onRefresh: refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    // height: Dimension.getScreenHeight(context),
                    margin: EdgeInsets.only(top: 3),
                    child: Column(
                      children: [
                        for (int index = 0;
                            index < snapshot.data!.length;
                            index++)
                          Column(
                            children: [
                              if (index != 0)
                                SizedBox(
                                  height: 30,
                                ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Order no. ${orderList[index].fullName}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                "Ordered : ${orderList[index].orderedTime} ago",
                                              )
                                            ],
                                          ),
                                          FoodTypeText.getFoodType(
                                              orderList[index].orderStatus, 14)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.end,
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        orderList[index]
                                                            .orderFoodDetails
                                                            .length;
                                                    orderList[index]
                                                                .orderFoodDetails
                                                                .length <=
                                                            2
                                                        ? i++
                                                        : i += 2)
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: OrderedFoodCard(
                                                            orderedFood: orderList[
                                                                    index]
                                                                .orderFoodDetails[i]),
                                                      ),
                                                      if (orderList[index]
                                                              .orderFoodDetails
                                                              .length >
                                                          2)
                                                        (orderList[index]
                                                                        .orderFoodDetails
                                                                        .length -
                                                                    1 >=
                                                                i + 1)
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  OrderedFoodCard(
                                                                      orderedFood:
                                                                          orderList[index].orderFoodDetails[i +
                                                                              1]),
                                                                ],
                                                              )
                                                            : Opacity(
                                                                opacity: 0.0,
                                                                child: OrderedFoodCard(
                                                                    orderedFood:
                                                                        orderList[index]
                                                                            .orderFoodDetails[i]),
                                                              ),
                                                    ],
                                                  ),
                                              ]),
                                        ),
                                      ),
                                    ]),
                                    if (orderList[index].orderStatus ==
                                        'Pending')
                                      ElevatedButton(
                                          onPressed: () {
                                            onsiteOrderService
                                                .cancelOrder(
                                                    orderList[index].id)
                                                .then((value) {
                                              if (value) {
                                                setState(() {
                                                  fetchOrder();
                                                });
                                              }
                                            });
                                          },
                                          child: Text("Cancel"))
                                    else if (orderList[index].orderStatus ==
                                            'Delivered' ||
                                        orderList[index].orderStatus ==
                                            'Partial Paid')
                                      ElevatedButton(
                                          onPressed: () {
                                            payWithKhaltiInAppPurchase(
                                                context,
                                                PaymentService(context),
                                                orderList[index]
                                                    .remainingAmount,
                                                orderList[index].id);
                                          },
                                          child: Text("Pay")),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  ElevatedButton(
                      child: const Text("Remove data"),
                      onPressed: () => {GoogleSignInApi.logout()}),
                  ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () => {
                            AutoRouter.of(context)
                                .push(const LoginScreenRoute())
                          }),
                  Text("${snapshot.error}")
                ],
              );
            }
          }),
    );
  }
}
