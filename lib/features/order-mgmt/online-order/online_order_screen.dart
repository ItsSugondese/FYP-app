import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/filter-map/pay_filter_map.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/features/order-mgmt/online-order/widgets/order_food_for_online_card.dart';
import 'package:fyp/features/order-mgmt/order_time_constant.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/global/pay_filter_widgets.dart';
import 'package:fyp/helper/widgets/search_widget.dart';
import 'package:fyp/model/order/online_order.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';
import 'package:fyp/podo/orders/onsite-order/onsite_order_pagination.dart';
import 'package:fyp/podo/user-order/user_order_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/order-services/online_order_service.dart';
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

  @override
  void initState() {
    super.initState();
    paginationPayload = OnlineOrderPaginationPayload(
      minDifference: OrderTimeConstant.timeInterval,
    );
    onlineOrderService = OnlineOrderService(context);
    fetchOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchOrder() {
    setState(() {
      onlineOrderFuture =
          onlineOrderService.getOnlineOrder(paginationPayload.toJson());
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
                                                          forAddingFoodButton()
                                                      ],
                                                    );
                                                  }),
                                              if (onlineOrder
                                                  .orderFoodDetails.isEmpty)
                                                forAddingFoodButton()
                                            ],
                                          ),
                                        ),
                                      ]),
                                      buttonsToHandle(onlineOrder)!,
                                    ]),
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

  Widget forAddingFoodButton() {
    return Container(
        alignment: Alignment.center,
        child: DefaultButtonNoInfinity(text: "Add Food", onPressed: () {}));
  }
}
