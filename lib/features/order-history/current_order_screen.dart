import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/order-history/order-history-service/order_history_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/user-order/user_order_history.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';
import 'package:fyp/podo/user-order/user_order_pagination.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class CurrentOrderScreen extends StatefulWidget {
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<ScrollController> _scrollControllerList = [];
  // ScrollController _scrollController = ScrollController();
  OrderHistoryService orderHistoryService = OrderHistoryService();

  late Future<PaginatedData<UserOrderHistory>> orderHistoryFuture;

  UserOrderHistoryPagination paginationPayload =
      UserOrderHistoryPagination(fromDate: '2024-01-01', toDate: '2024-01-31');

  @override
  void initState() {
    super.initState();
    orderHistoryFuture = orderHistoryService.getOrderHistory(
        context, paginationPayload.toJson());
  }

  @override
  void dispose() {
    super.dispose();
    for (ScrollController controller in _scrollControllerList) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Order'),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<PaginatedData<UserOrderHistory>>(
          future: orderHistoryFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserOrderHistory> listOfUserOrders = snapshot.data!.content;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return ListView.builder(
                controller: _pageController,
                itemCount: snapshot.data!.totalPages,
                itemBuilder: ((context, index) {
                  return Center(
                    heightFactor: 1,
                    child: SingleChildScrollView(
                      controller: _scrollControllerList[index],
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        dataRowHeight: 200,
                        columnSpacing: 200,
                        columns: [
                          DataColumn(label: Text('Id')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: listOfUserOrders.map((orderHistoryMap) {
                          return DataRow(cells: [
                            DataCell(Text("${orderHistoryMap.id}")),
                            DataCell(Text(orderHistoryMap.orderType)),
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: orderHistoryMap.orderFoodDetails!
                                    .map((e) => Text(
                                        "${e.foodName} \t ${e.cost * e.quantity}"))
                                    .toList(),
                              ),
                            ),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {},
                                )
                              ],
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [Text("${snapshot.error}")],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
