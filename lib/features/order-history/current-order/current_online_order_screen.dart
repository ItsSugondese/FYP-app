import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/features/order-history/order-history-service/order_history_service.dart';
import 'package:fyp/model/user-order/user_order_history.dart';
import 'package:fyp/podo/user-order/user_order_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/templates/text/food_type_text.dart';

@RoutePage()
class CurrentOnlineOrderScreen extends StatefulWidget {
  const CurrentOnlineOrderScreen({super.key});

  @override
  State<CurrentOnlineOrderScreen> createState() =>
      _CurrentOnlineOrderScreenState();
}

class _CurrentOnlineOrderScreenState extends State<CurrentOnlineOrderScreen> {
  late OrderHistoryService orderHistoryService;

  late Future<List<UserOrderHistory>> onlineOrderHistoryFuture;

  UserOrderHistoryPagination paginationPayload =
      UserOrderHistoryPagination(fromDate: '2024-01-01', toDate: '2024-01-31');

  @override
  void initState() {
    super.initState();
    orderHistoryService = OrderHistoryService(context);
    fetchOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchOrder() {
    onlineOrderHistoryFuture = orderHistoryService.getUserOnlineOrderHistory();
  }

  Future<void> refresh() async {
    setState(() {
      fetchOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: Dimension.getScreenHeight(context) * 0.855,
          child: FutureBuilder<List<UserOrderHistory>>(
              future: onlineOrderHistoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  List<UserOrderHistory> historyList = snapshot.data!;
                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
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
                                                    "Order no. ${historyList[index].orderCode}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Arrival time: ${historyList[index].arrivalTime}",
                                                  )
                                                ],
                                              ),
                                              FoodTypeText.getFoodType(
                                                  "Pending", 14)
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
                                                            historyList[index]
                                                                .orderFoodDetails
                                                                .length;
                                                        historyList[index]
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
                                                                orderedFood:
                                                                    historyList[
                                                                            index]
                                                                        .orderFoodDetails[i]),
                                                          ),
                                                          if (historyList[index]
                                                                  .orderFoodDetails
                                                                  .length >
                                                              2)
                                                            (historyList[index]
                                                                            .orderFoodDetails
                                                                            .length -
                                                                        1 >=
                                                                    i + 1)
                                                                ? Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      OrderedFoodCard(
                                                                          orderedFood:
                                                                              historyList[index].orderFoodDetails[i + 1]),
                                                                    ],
                                                                  )
                                                                : Opacity(
                                                                    opacity:
                                                                        0.0,
                                                                    child: OrderedFoodCard(
                                                                        orderedFood:
                                                                            historyList[index].orderFoodDetails[i]),
                                                                  ),
                                                        ],
                                                      ),
                                                  ]),
                                            ),
                                          ),
                                        ]),
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
        ),
      ),
    );
  }
}
