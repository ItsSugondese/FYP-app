import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/features/homepage/khati_dart.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/features/order-mgmt/online-order/widgets/food_card_for_summary.dart';
import 'package:fyp/features/order-mgmt/online-order/widgets/order_food_for_online_card.dart';
import 'package:fyp/features/order-mgmt/order_time_constant.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/podo/orders/online-order/order_summary.dart';
import 'package:fyp/podo/user-order/user_order_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/order-services/online_order_service.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:fyp/services/payment/payment_service.dart';
import 'package:fyp/templates/circular_indicator/default_circular_indicator.dart';
import 'package:fyp/templates/not-found/no_data.dart';
import 'package:fyp/templates/text/food_type_text.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  late OnlineOrderService onlineOrderService;
  late Future<List<SummaryData>> summaryFuture;

  late TimeOfDay _startDate;
  late TimeOfDay _endDate;

  bool isLoading = false;
  bool initialLoading = true;
  int totalPage = 1;
  String? errMessage;
  @override
  void initState() {
    super.initState();
    _startDate = TimeOfDay.now();
    _endDate = TimeOfDay.now();
    _endDate = addMinutesToTime(_endDate, OrderTimeConstant.timeInterval);
    onlineOrderService = OnlineOrderService(context);

    fetchApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectFromTimeRange() async {
    final TimeOfDay? startPicked = await showTimePicker(
      context: context,
      initialTime: _startDate,
    );
    if (startPicked != null && startPicked != _startDate) {
      setState(() {
        _startDate = startPicked;
        compareAndFetch();
      });
    }
  }

  compareAndFetch() {
    if (isTimeOfDayGreaterThan(_endDate, _startDate)) {
      fetchApi();
    }
  }

  fetchApi() {
    summaryFuture = onlineOrderService.getOnlineOrderSummary(
        '${_startDate.hour > 9 ? _startDate.hour : "0${_startDate.hour}"}:${_startDate.minute > 9 ? _startDate.minute : "0${_startDate.minute}"}',
        '${_endDate.hour > 9 ? _endDate.hour : "0${_endDate.hour}"}:${_endDate.minute > 9 ? _endDate.minute : "0${_endDate.minute}"}');
  }

  Future<void> _selectToTimeRange() async {
    final TimeOfDay? endPicked = await showTimePicker(
      context: context,
      initialTime: _endDate,
    );
    if (endPicked != null && endPicked != _startDate) {
      setState(() {
        _endDate = endPicked;
        compareAndFetch();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: const CustomAppbar(),
        // drawer: MyDrawer(),
        appBar: AppBar(
          title: Text("Order Summary"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 8, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text("From:"),
                      ElevatedButton(
                          onPressed: () async {
                            await _selectFromTimeRange();
                            compareAndFetch();
                          },
                          child:
                              Text('${_startDate.hour}:${_startDate.minute}')),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text("To:"),
                      ElevatedButton(
                          onPressed: () async {
                            await _selectToTimeRange();
                            compareAndFetch();
                          },
                          child: Text('${_endDate.hour}:${_endDate.minute}')),
                    ],
                  ),
                ],
              ),
              FutureBuilder<List<SummaryData>>(
                  future: summaryFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const DefaultCircularIndicator(height: 0.7);
                    } else if (snapshot.hasData) {
                      List<SummaryData> summaryList = snapshot.data!;

                      return Expanded(
                        child: RefreshIndicator(
                            onRefresh: refresh,
                            child: summaryList.isEmpty
                                ? SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: NoData.getNoDataImage(
                                        context, "No order Here", 0.7))
                                : ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: summaryList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SummaryFoodCard(
                                              summaryData: summaryList[index],
                                              clicked: () async {}),
                                        ],
                                      );
                                    })),
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
            ],
          ),
        ));
  }

  Future<void> refresh() async {
    setState(() {
      fetchApi();
    });
  }

  bool isTimeOfDayGreaterThan(TimeOfDay t1, TimeOfDay t2) {
    if (t1.hour > t2.hour) {
      return true;
    } else if (t1.hour == t2.hour) {
      return t1.minute > t2.minute;
    } else {
      return false;
    }
  }

  TimeOfDay addMinutesToTime(TimeOfDay time, int minutesToAdd) {
    int totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }
}
