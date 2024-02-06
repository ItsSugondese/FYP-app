import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/order-mgmt/online-order/online-order-service/online_order_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/order/online_order.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';

@RoutePage()
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<ScrollController> _scrollControllerList = [];
  // ScrollController _scrollController = ScrollController();
  OnlineOrderService onlineOrderService = OnlineOrderService();

  late Future<PaginatedData<OnlineOrder>> onlineOrderFuture;

  OnlineOrderPaginationPayload paginationPayload =
      OnlineOrderPaginationPayload();

  @override
  void initState() {
    super.initState();
    onlineOrderFuture =
        onlineOrderService.getOnlineOrder(context, paginationPayload.toJson());
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
      body: FutureBuilder<PaginatedData<OnlineOrder>>(
          future: onlineOrderFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OnlineOrder> listOfOnlineOrders = snapshot.data!.content;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    paginationPayload.page = value + 1;
                    onlineOrderFuture = onlineOrderService.getOnlineOrder(
                        context, paginationPayload.toJson());
                  });
                },
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
                        rows: listOfOnlineOrders.map((onlineOrderMap) {
                          return DataRow(cells: [
                            DataCell(Text("${onlineOrderMap.id}")),
                            DataCell(Text(onlineOrderMap.fullName)),
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: onlineOrderMap.orderFoodDetails
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
