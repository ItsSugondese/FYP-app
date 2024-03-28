import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/homepage/khati_dart.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/podo/user-order/user_order_pagination.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:fyp/services/payment/payment_service.dart';
import 'package:fyp/templates/text/food_type_text.dart';
import 'package:fyp/utils/appbar/custom-appbar.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  late OnsiteOrderService onsiteOrderService;
  late Future<PaginatedData<OnsiteOrder>> onsiteOrderHistoryFuture;

  List<OnsiteOrder> orderList = [];
  UserOrderHistoryPagination paginationPayload = UserOrderHistoryPagination(
    fromDate: DateTime.now().toString().split(' ')[0],
    toDate: DateTime.now().toString().split(' ')[0],
    today: false,
  );

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  bool isLoading = false;
  bool initialLoading = true;
  int totalPage = 1;
  String? errMessage;
  @override
  void initState() {
    super.initState();
    onsiteOrderService = OnsiteOrderService(context);

    setAndFetchOrder();
    _scrollController.addListener(loadMoreData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;

        setAndFetchOrder();
      });
    }
  }

  setAndFetchOrder() {
    convertDateToString();
    setState(() {
      initialLoading = true;
    });
    paginationPayload.page = 1;
    paginationPayload.row = 10;
    orderList = [];
    getOrders(true);
  }

  Future<void> getOrders(bool first) async {
    if (!first) {
      setState(() {
        isLoading = true;
      });
    }

    PaginatedData<OnsiteOrder> onsiteOrderPagination;
    try {
      onsiteOrderPagination = await onsiteOrderService
          .getUserOnsiteOrderHistory(paginationPayload.toJson());
      errMessage = null;
    } catch (e) {
      setState(() {
        isLoading = false;
        initialLoading = false;
        errMessage = e.toString();
      });
      throw Exception(e);
    }
    setState(() {
      isLoading = false;
      initialLoading = false;
      totalPage = onsiteOrderPagination.totalPages;
      orderList.addAll(onsiteOrderPagination.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(),
        drawer: MyDrawer(),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: _selectDateRange,
                child: Text(
                    '${paginationPayload.fromDate!} - ${paginationPayload.toDate!}')),
            if (errMessage != null)
              Center(child: Text(errMessage!))
            else
              !initialLoading
                  ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return Container(
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
                                                                      orderList[
                                                                              index]
                                                                          .orderFoodDetails[i]),
                                                            ),
                                                  ],
                                                ),
                                            ]),
                                      ),
                                    ),
                                  ]),
                                  if (orderList[index].orderStatus == 'Pending')
                                    ElevatedButton(
                                        onPressed: () {
                                          onsiteOrderService
                                              .cancelOrder(orderList[index].id)
                                              .then((value) {
                                            if (value) {
                                              setState(() {
                                                setAndFetchOrder();
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
                                              orderList[index].remainingAmount,
                                              orderList[index].id);
                                        },
                                        child: Text("Pay")),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ));
  }

  convertDateToString() {
    paginationPayload.fromDate = _startDate.toString().split(' ')[0];
    paginationPayload.toDate = _endDate.toString().split(' ')[0];
  }

  Future<void> refresh() async {
    setAndFetchOrder();
  }

  void loadMoreData() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        paginationPayload.page < totalPage) {
      paginationPayload.page++;
      getOrders(false);
    }
  }
}
