import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/filter-map/pay_filter_map.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/features/order-mgmt/order_time_constant.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/global/pay_filter_widgets.dart';
import 'package:fyp/helper/widgets/search_widget.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/podo/orders/onsite-order/onsite_order_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:fyp/templates/button/default_button_no_infinity.dart';
import 'package:fyp/templates/circular_indicator/default_circular_indicator.dart';
import 'package:fyp/templates/not-found/no_data.dart';
import 'package:fyp/templates/pop-up/are_you_sure_pop_up.dart';
import 'package:fyp/templates/pop-up/pay_order_pop_up.dart';
import 'package:fyp/templates/text/food_type_text.dart';
import 'package:fyp/utils/appbar/custom-appbar.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class OnsiteOrderScreen extends StatefulWidget {
  const OnsiteOrderScreen({super.key});

  @override
  State<OnsiteOrderScreen> createState() => _OnsiteOrderScreenState();
}

class _OnsiteOrderScreenState extends State<OnsiteOrderScreen> {
  late Future<PaginatedData<OnsiteOrder>> onsiteOrderFuture;

  late OnsiteOrderPaginationPayload paginationPayload;

  late OnsiteOrderService onsiteOrderService;

  late Future<PaginatedData<OnsiteOrder>> onsiteOrderHistoryFuture;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    paginationPayload = OnsiteOrderPaginationPayload(
        minuteRange: OrderTimeConstant.timeInterval,
        onsiteOrderFilter:
            PayFilterMap.orderManagementFilter.entries.first.value);
    onsiteOrderService = OnsiteOrderService(context);
    _controller.text = OrderTimeConstant.timeInterval.toString();
    fetchOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchOrder() {
    setState(() {
      onsiteOrderHistoryFuture =
          onsiteOrderService.getOnsiteOrder(paginationPayload.toJson());
    });
  }

  Future<void> refresh() async {
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: const CustomAppbar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: Dimension.getScreenHeight(context),
        child: Column(children: [
          SearchWidget(
            searchText: "Search User",
            typedText: (val) {
              paginationPayload.name = val.trim() == "" ? null : val;
              fetchOrder();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          GlobalPayFilterWidget(
              options: PayFilterMap.orderManagementFilter,
              selectedFilter: (val) {
                paginationPayload.onsiteOrderFilter = val;
                fetchOrder();
              }),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey, // Set border color here
                  width: 1, // Set border width here
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(
                        0, 3), // Positive vertical value for bottom shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        // controller: _emailFieldController,
                        decoration: InputDecoration(
                            hintText: "Min", border: InputBorder.none),
                        onEditingComplete: (() {
                          if (_controller.text.isNotEmpty) {
                            OrderTimeConstant.timeInterval =
                                int.parse(_controller.text);
                            fetchOrder();
                          } else {
                            setState(() {
                              _controller.text =
                                  OrderTimeConstant.timeInterval.toString();
                            });
                          }
                        }),
                      ),
                    ),
                    Text("Minutes"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<PaginatedData<OnsiteOrder>>(
              future: onsiteOrderHistoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const DefaultCircularIndicator(height: 0.5);
                } else if (snapshot.hasData) {
                  List<OnsiteOrder> orderList = snapshot.data!.content;
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: orderList.isEmpty
                          ? SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: NoData.getNoDataImage(
                                  context, "No order Here", 0.5))
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: orderList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    if (index != 0)
                                      SizedBox(
                                        height: 30,
                                      ),
                                    Container(
                                        child: Column(children: [
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
                                                  "${orderList[index].fullName}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  "Ordered : ${orderList[index].orderedTime} ago",
                                                ),
                                                Text(
                                                  "Table no. : ${orderList[index].tableNumber ?? 'Not Specified'}",
                                                )
                                              ],
                                            ),
                                            FoodTypeText.getFoodType(
                                                orderList[index].orderStatus,
                                                14)
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
                                                              orderedFood:
                                                                  orderList[
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
                                                                      height:
                                                                          10,
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
                                      buttonsToHandle(orderList[index])!
                                    ])),
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

  Row? buttonsToHandle(OnsiteOrder order) {
    if (paginationPayload.onsiteOrderFilter ==
        PayFilterMap.orderManagementFilter['Pending']) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
            onPressed: () async {
              await onsiteOrderService.markAsRead(order.id);
              fetchOrder();
            },
            icon: Icon(Icons.visibility)),
        Text("${CurrencyConstant.currency}${order.totalPrice}")
      ]);
    } else if (paginationPayload.onsiteOrderFilter ==
        PayFilterMap.orderManagementFilter['Viewed']) {
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
                        await onsiteOrderService.updateOrderStatus(
                            order.id, 'CANCELED');
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
              await onsiteOrderService.updateOrderStatus(order.id, 'DELIVERED');
              fetchOrder();
            }),
      ]);
    } else if (paginationPayload.onsiteOrderFilter ==
        PayFilterMap.orderManagementFilter['Canceled']) {
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        DefaultButtonNoInfinity(
            text: "Re-Enter",
            onPressed: () async {
              await onsiteOrderService.updateOrderStatus(order.id, 'PENDING');
              fetchOrder();
            }),
      ]);
    } else if (paginationPayload.onsiteOrderFilter ==
        PayFilterMap.orderManagementFilter['Delivered']) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("${CurrencyConstant.currency}${order.totalPrice}"),
        DefaultButtonNoInfinity(
            text: "Pay",
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PayOrderPopUp(
                    callback: (val) async {
                      if (val) {
                        fetchOrder();
                      }
                    },
                    order: order,
                  );
                },
              );
            }),
      ]);
    } else {
      return Row(
        children: [],
      );
    }
  }
}
