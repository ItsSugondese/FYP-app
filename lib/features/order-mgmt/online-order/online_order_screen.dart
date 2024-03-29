import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/features/order-mgmt/online-order/widgets/order_food_for_online_card.dart';
import 'package:fyp/features/order-mgmt/order_time_constant.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/search_widget.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/model/order/online_order.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';
import 'package:fyp/podo/foodmgmt/food_order_response.dart';
import 'package:fyp/podo/foodmgmt/food_ordering_details.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';
import 'package:fyp/podo/orders/online-order/online_order_response.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/order-services/online_order_service.dart';
import 'package:fyp/templates/button/default_button_no_infinity.dart';
import 'package:fyp/templates/circular_indicator/default_circular_indicator.dart';
import 'package:fyp/templates/counter/counter_button.dart';
import 'package:fyp/templates/not-found/no_data.dart';
import 'package:fyp/templates/pop-up/are_you_sure_pop_up.dart';
import 'package:fyp/utils/appbar/custom-appbar.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class OnlineOrderScreen extends StatefulWidget {
  const OnlineOrderScreen({super.key});

  @override
  State<OnlineOrderScreen> createState() => _OnlineOrderScreenState();
}

class _OnlineOrderScreenState extends State<OnlineOrderScreen> {
  late Future<PaginatedData<OnsiteOrder>> onsiteOrderFuture;

  late OnlineOrderPaginationPayload paginationPayload;

  late OnlineOrderService onlineOrderService;

  late Future<PaginatedData<OnlineOrder>> onlineOrderFuture;

  List<FoodMenu> foodMenuList = [];
  FoodMenuPaginationPayload foodPaginationPayload = FoodMenuPaginationPayload();
  late Future<PaginatedData<FoodMenu>> foodMenuFuture;
  late FoodManagementService foodManagementService;
  FoodMenu? selectedMenu;
  int? lastAddId;
  Map<int, bool> openAutoList = {};

  int addedQuantity = 0;
  Future<List<FoodMenu>> fetchFoodMenu() async {
    return Future.value((await foodManagementService
            .getFoodDetailsPaginated(paginationPayload.toJson()))
        .content);
  }

  @override
  void initState() {
    super.initState();
    paginationPayload = OnlineOrderPaginationPayload(
      minDifference: OrderTimeConstant.timeInterval,
    );
    onlineOrderService = OnlineOrderService(context);
    foodManagementService = FoodManagementService(context);
    foodPaginationPayload.filter = true;
    fetchOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchOrder() {
    setState(() {
      lastAddId = null;
      addedQuantity = 0;
      openAutoList = {};
      onlineOrderFuture =
          onlineOrderService.getOnlineOrder(paginationPayload.toJson());
    });
  }

  Future<void> refresh() async {
    fetchOrder();
  }

  List<String> items = ["Apple", "Orange", "Banana", "Orange"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: const CustomAppbar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: Dimension.getScreenHeight(context),
        child: Column(children: [
          Text("${lastAddId ?? 'null'}"),
          SearchWidget(
            searchText: "Search User",
            typedText: (val) {
              paginationPayload.name = val.trim() == "" ? null : val;
              fetchOrder();
            },
          ),
          FutureBuilder<PaginatedData<OnlineOrder>>(
              future: onlineOrderFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const DefaultCircularIndicator(height: 0.7);
                } else if (snapshot.hasData) {
                  List<OnlineOrder> orderList = snapshot.data!.content;

                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: orderList.isEmpty
                          ? SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: NoData.getNoDataImage(
                                  context, "No order Here", 0.7))
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: orderList.length,
                              itemBuilder: (context, index) {
                                OnlineOrder onlineOrder = orderList[index];
                                openAutoList.putIfAbsent(
                                    onlineOrder.id, () => false);
                                return Column(
                                  children: [
                                    Column(children: [
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
                                                  "Order no. ${orderList[index].orderCode}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  "Arrival Time : ${onlineOrder.arrivalTime} ago",
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            children: [
                                              ListView.builder(
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: onlineOrder
                                                      .orderFoodDetails.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    OrderedFood orderedFood =
                                                        onlineOrder
                                                                .orderFoodDetails[
                                                            index];
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        OrderedFoodForOnlineCard(
                                                            orderedFood:
                                                                orderedFood,
                                                            clicked: () async {
                                                              await onlineOrderService
                                                                  .deleteSingleOrderedFood(
                                                                      orderedFood
                                                                          .id);
                                                              fetchOrder();
                                                            }),
                                                        if (onlineOrder
                                                                .orderFoodDetails
                                                                .length ==
                                                            index + 1)
                                                          forAddingFoodButton(
                                                              onlineOrder,
                                                              openAutoList)
                                                      ],
                                                    );
                                                  }),
                                              if (onlineOrder
                                                  .orderFoodDetails.isEmpty)
                                                forAddingFoodButton(
                                                    onlineOrder, openAutoList)
                                            ],
                                          ),
                                        ),
                                      ]),
                                      buttonsToHandle(onlineOrder)!,
                                    ]),
                                    // Autocomplete<String>(
                                    //   optionsBuilder:
                                    //       (TextEditingValue textEditingValue) {
                                    //     if (textEditingValue.text == '') {
                                    //       return const Iterable.empty();
                                    //     }
                                    //     return items.where((element) => element
                                    //         .toLowerCase()
                                    //         .contains(textEditingValue.text
                                    //             .toLowerCase()));
                                    //   },
                                    //   onSelected: (item) {
                                    //     print(item);
                                    //   },
                                    // ),
                                  ],
                                );
                              }),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      ElevatedButton(
                          child: Text("Remove data"),
                          onPressed: () => {GoogleSignInApi.logout()}),
                      ElevatedButton(
                          child: Text("Login"),
                          onPressed: () => {
                                AutoRouter.of(context)
                                    .push(const LoginScreenRoute())
                              }),
                      Text("${snapshot.error}")
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ]),
      ),
    );
  }

  Row? buttonsToHandle(OnlineOrder order) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      DefaultButtonNoInfinity(
          text: "Cancel",
          color: CustomColors.defaultRedColor,
          hasBorder: true,
          bgColor: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AreYouSurePopUp(
                  callback: (val) async {
                    if (val) {
                      fetchOrder();
                    }
                  },
                  description: "Are you sure you want to cancel this order?",
                  header: "Cancel Order",
                );
              },
            );
          }),
      Text("${CurrencyConstant.currency}${order.totalPrice}"),
      DefaultButtonNoInfinity(
          text: "Deliver",
          onPressed: () async {
            await onlineOrderService.convertToOnsite(order.id);
            fetchOrder();
          }),
    ]);
  }

  Widget forAddingFoodButton(OnlineOrder order, Map<int, dynamic> val) {
    return Container(
        alignment: Alignment.center,
        width: Dimension.getScreenWidth(context),
        child: !val[order.id]
            ? DefaultButtonNoInfinity(
                text: "Add Food",
                onPressed: () {
                  setState(() {
                    openAndCloseAddFoodMenu(order.id, val, false);
                  });
                })
            : Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          openAndCloseAddFoodMenu(order.id, val, true);
                          addedQuantity = 0;
                        });
                      },
                      icon: const Icon(Icons.delete)),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Add Menu"),
                        Autocomplete<FoodMenu>(
                          displayStringForOption: (food) => food.name,
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            if (textEditingValue.text == '') {
                              return const Iterable.empty();
                            }
                            final foodMenu = await fetchFoodMenu();
                            return foodMenu.where((element) => element.name
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (item) {
                            setState(() {
                              selectedMenu = item;
                            });
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            // Your logic to build the text field
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onChanged: (text) {
                                // Your logic to check the text written in the field
                                print("Text field content: $text");

                                if (selectedMenu != null &&
                                    selectedMenu!.name != text) {
                                  setState(() {
                                    selectedMenu = null;
                                  });
                                }
                              },
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment:
                                  Alignment.topCenter, // Positioning at the top
                              child: Material(
                                elevation: 4.0,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 200),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final option = options.elementAt(index);
                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: ListTile(
                                          title: Text(option.name),
                                          subtitle: Text(
                                              "${CurrencyConstant.currency}${option.cost}"),
                                          leading: Image.memory(option.image),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Text("Quantity"),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: CustomColors.defaultRedColor),
                          child: ItemCount(
                            initialValue: addedQuantity,
                            minValue: 0,
                            maxValue: 10,
                            decimalPlaces: 0,
                            buttonTextColor: Colors.white,
                            buttonSizeWidth: 30,
                            buttonSizeHeight: 30,
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            // textStyle: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                if (value.toInt() != 0) {
                                  addedQuantity = value.toInt();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  DefaultButtonNoInfinity(
                      text: "Add",
                      isDisabled: selectedMenu == null || addedQuantity == 0,
                      onPressed: () async {
                        List<FoodOrderResponse> foodOrderList = [
                          FoodOrderResponse(
                            foodId: selectedMenu!.id,
                            quantity: addedQuantity,
                          ),
                        ];

                        OnlineOrderResponse onlineOrderResponse =
                            OnlineOrderResponse(
                                id: order.id,
                                foodOrderList: foodOrderList,
                                arrivalTime:
                                    convertAmPmTo24Hour(order.arrivalTime),
                                totalPrice: order.totalPrice +
                                    (selectedMenu!.cost * addedQuantity));
                        await onlineOrderService
                            .makeOnlineOrder(onlineOrderResponse.toJson());

                        setState(() {
                          openAndCloseAddFoodMenu(order.id, val, true);
                          fetchOrder();
                        });
                      })
                ],
              ));
  }

  List<FoodOrderResponse> getFoodOrderList(List<FoodOrderingDetails> details) {
    List<FoodOrderResponse> foodOrderList = details.map((element) {
      return FoodOrderResponse(
        foodId: element.foodMenu.id,
        quantity: element.quantity,
      );
    }).toList();

    return foodOrderList;
  }

  openAndCloseAddFoodMenu(int orderId, Map<int, dynamic> val, bool closing) {
    if (lastAddId != null) {
      val[lastAddId!] = false;
    }
    if (!closing) {
      val[orderId] = true;
      lastAddId = orderId;
    } else {
      lastAddId = null;
    }
    addedQuantity = 0;
  }

  String convertAmPmTo24Hour(String timeString) {
    // Split the time string into hours, minutes, and am/pm indicator
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1].split(' ')[0]);
    String indicator = parts[1].split(' ')[1].toLowerCase();

    // Convert the hours to 24-hour format if necessary
    if (indicator == 'pm' && hours < 12) {
      hours += 12;
    } else if (indicator == 'am' && hours == 12) {
      hours = 0;
    }

    // Format the time in 24-hour format
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}
