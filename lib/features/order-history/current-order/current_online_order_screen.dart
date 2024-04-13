import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/features/order-history/current-order/widgets/add_menu_pop_up.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_list_card.dart';
import 'package:fyp/features/order-history/order-history-service/order_history_service.dart';
import 'package:fyp/features/order-mgmt/online-order/widgets/order_food_for_online_card.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/model/order/online_order.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/model/user-order/user_order_history.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';
import 'package:fyp/podo/foodmgmt/food_order_response.dart';
import 'package:fyp/podo/orders/online-order/online_order_response.dart';
import 'package:fyp/podo/user-order/user_order_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/order-services/online_order_service.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:fyp/templates/button/default_button_no_infinity.dart';
import 'package:fyp/templates/counter/counter_button.dart';
import 'package:fyp/templates/not-found/no_data.dart';
import 'package:fyp/templates/pop-up/are_you_sure_pop_up.dart';
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
  late FoodManagementService foodManagementService;

  late Future<List<UserOrderHistory>> onlineOrderHistoryFuture;
  late OnlineOrderService onlineOrderService;

  UserOrderHistoryPagination paginationPayload =
      UserOrderHistoryPagination(fromDate: '2024-01-01', toDate: '2024-01-31');

  FoodMenuPaginationPayload foodPaginationPayload =
      FoodMenuPaginationPayload(filter: true);

  FoodMenu? selectedMenu;

  bool addFood = false;
  int addedQuantity = 0;

  Future<List<FoodMenu>> fetchFoodMenu() async {
    return Future.value((await foodManagementService
            .getFoodDetailsPaginated(paginationPayload.toJson()))
        .content);
  }

  @override
  void initState() {
    super.initState();
    orderHistoryService = OrderHistoryService(context);
    foodManagementService = FoodManagementService(context);
    onlineOrderService = OnlineOrderService(context);

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
                        child: historyList.length == 0
                            ? Center(
                                child: NoData.getNoDataImage(
                                    context, "No order Here", 0.7),
                              )
                            : Column(
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Order no. ${historyList[index].orderCode}",
                                                          style:
                                                              const TextStyle(
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
                                                ListView.builder(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        historyList[index]
                                                            .orderFoodDetails
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      OrderedFood orderedFood =
                                                          historyList[index]
                                                              .orderFoodDetails[i];
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          OrderedFoodListViewForOnlineCard(
                                                              orderedFood:
                                                                  orderedFood,
                                                              clicked:
                                                                  () async {
                                                                await onlineOrderService
                                                                    .deleteSingleOrderedFood(
                                                                        orderedFood
                                                                            .id);
                                                                setState(() {
                                                                  fetchOrder();
                                                                });
                                                              }),
                                                          if (historyList[index]
                                                                  .orderFoodDetails
                                                                  .length ==
                                                              i + 1)
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  DefaultButtonNoInfinity(
                                                                      text:
                                                                          "Add Menu",
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AddMenuPopUp(
                                                                              orderHistory: historyList[index],
                                                                            );
                                                                          },
                                                                        );
                                                                      }),
                                                            )
                                                        ],
                                                      );
                                                    }),
                                                if (historyList[index]
                                                    .orderFoodDetails
                                                    .isEmpty)
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child:
                                                        DefaultButtonNoInfinity(
                                                            text: "Add Menu",
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AddMenuPopUp(
                                                                    orderHistory:
                                                                        historyList[
                                                                            index],
                                                                  );
                                                                },
                                                              );
                                                            }),
                                                  ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    DefaultButtonNoInfinity(
                                                        text: "Cancel",
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AreYouSurePopUp(
                                                                callback:
                                                                    (val) async {
                                                                  if (val) {
                                                                    onlineOrderService
                                                                        .deleteOrder(
                                                                            historyList[index].id);
                                                                  }
                                                                },
                                                                description:
                                                                    "Are you sure you want to remove this food from order?",
                                                                header:
                                                                    "Remove Food from order",
                                                              );
                                                            },
                                                          );
                                                        }),
                                                    Text(historyList[index]
                                                        .totalPrice
                                                        .toString())
                                                  ],
                                                )
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

  // Widget forAddingFoodButton() {
  //   return Container(
  //       alignment: Alignment.center,
  //       width: Dimension.getScreenWidth(context),
  //       child: !addFood
  //           ? DefaultButtonNoInfinity(
  //               text: "Add Food",
  //               onPressed: () {
  //                 setState(() {
  //                   addFood = true;
  //                 });
  //               })
  //           : Row(
  //               children: [
  //                 IconButton(
  //                     onPressed: () {
  //                       setState(() {});
  //                     },
  //                     icon: const Icon(Icons.delete)),
  //                 Expanded(
  //                   child: Column(
  //                     children: [
  //                       Text("Add Menu"),
  //                       Autocomplete<FoodMenu>(
  //                         displayStringForOption: (food) => food.name,
  //                         optionsBuilder:
  //                             (TextEditingValue textEditingValue) async {
  //                           if (textEditingValue.text == '') {
  //                             return const Iterable.empty();
  //                           }
  //                           final foodMenu = await fetchFoodMenu();
  //                           return foodMenu.where((element) => element.name
  //                               .toLowerCase()
  //                               .contains(textEditingValue.text.toLowerCase()));
  //                         },
  //                         onSelected: (item) {
  //                           setState(() {
  //                             selectedMenu = item;
  //                           });
  //                         },
  //                         fieldViewBuilder: (context, controller, focusNode,
  //                             onFieldSubmitted) {
  //                           // Your logic to build the text field
  //                           return TextField(
  //                             controller: controller,
  //                             focusNode: focusNode,
  //                             onChanged: (text) {
  //                               // Your logic to check the text written in the field
  //                               print("Text field content: $text");

  //                               if (selectedMenu != null &&
  //                                   selectedMenu!.name != text) {
  //                                 setState(() {
  //                                   selectedMenu = null;
  //                                 });
  //                               }
  //                             },
  //                           );
  //                         },
  //                         optionsViewBuilder: (context, onSelected, options) {
  //                           return Align(
  //                             alignment:
  //                                 Alignment.topCenter, // Positioning at the top
  //                             child: Material(
  //                               elevation: 4.0,
  //                               child: ConstrainedBox(
  //                                 constraints: BoxConstraints(maxHeight: 200),
  //                                 child: ListView.builder(
  //                                   shrinkWrap: true,
  //                                   itemCount: options.length,
  //                                   itemBuilder:
  //                                       (BuildContext context, int index) {
  //                                     final option = options.elementAt(index);
  //                                     return GestureDetector(
  //                                       onTap: () {
  //                                         onSelected(option);
  //                                       },
  //                                       child: ListTile(
  //                                         title: Text(option.name),
  //                                         subtitle: Text(
  //                                             "${CurrencyConstant.currency}${option.cost}"),
  //                                         leading: Image.memory(option.image),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                       Text("Quantity"),
  //                       Container(
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10.0),
  //                             color: CustomColors.defaultRedColor),
  //                         child: ItemCount(
  //                           initialValue: addedQuantity,
  //                           minValue: 0,
  //                           maxValue: 10,
  //                           decimalPlaces: 0,
  //                           buttonTextColor: Colors.white,
  //                           buttonSizeWidth: 30,
  //                           buttonSizeHeight: 30,
  //                           textStyle: const TextStyle(
  //                               color: Colors.white, fontSize: 18),
  //                           // textStyle: TextStyle(color: Colors.white),
  //                           onChanged: (value) {
  //                             setState(() {
  //                               if (value.toInt() != 0) {
  //                                 addedQuantity = value.toInt();
  //                               }
  //                             });
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 DefaultButtonNoInfinity(
  //                     text: "Add",
  //                     isDisabled: selectedMenu == null || addedQuantity == 0,
  //                     onPressed: () async {
  //                       List<FoodOrderResponse> foodOrderList = [
  //                         FoodOrderResponse(
  //                           foodId: selectedMenu!.id,
  //                           quantity: addedQuantity,
  //                         ),
  //                       ];

  //                       OnlineOrderResponse onlineOrderResponse =
  //                           OnlineOrderResponse(
  //                               id: order.id,
  //                               foodOrderList: foodOrderList,
  //                               arrivalTime:
  //                                   convertAmPmTo24Hour(order.arrivalTime),
  //                               totalPrice: order.totalPrice +
  //                                   (selectedMenu!.cost * addedQuantity));
  //                       await onlineOrderService
  //                           .makeOnlineOrder(onlineOrderResponse.toJson());

  //                       setState(() {
  //                         openAndCloseAddFoodMenu(order.id, val, true);
  //                         fetchOrder();
  //                       });
  //                     })
  //               ],
  //             ));
  // }
}
