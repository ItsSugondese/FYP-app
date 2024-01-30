import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/order-mgmt/onsite-order/onsite-order-service/onsite_order_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';

@RoutePage()
class OnsiteOrderScreen extends StatefulWidget {
  const OnsiteOrderScreen({super.key});

  @override
  State<OnsiteOrderScreen> createState() => _OnsiteOrderScreenState();
}

class _OnsiteOrderScreenState extends State<OnsiteOrderScreen> {
  final PageController _pageController = PageController();
  final List<ScrollController> _scrollControllerList = [];
  // ScrollController _scrollController = ScrollController();
  OnsiteOrderService onsiteOrderService = OnsiteOrderService();

  late Future<PaginatedData<OnsiteOrder>> onsiteOrderFuture;

  OnlineOrderPaginationPayload paginationPayload =
      OnlineOrderPaginationPayload();

  @override
  void initState() {
    onsiteOrderFuture =
        onsiteOrderService.getOnsiteOrder(context, paginationPayload.toJson());
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
        title: Text('Onsite Orders'),
      ),
      body: FutureBuilder<PaginatedData<OnsiteOrder>>(
          future: onsiteOrderFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OnsiteOrder> listOfOnsiteOrders = snapshot.data!.content;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    paginationPayload.page = value + 1;
                    onsiteOrderFuture = onsiteOrderService.getOnsiteOrder(
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
                          DataColumn(label: Text('Price')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: listOfOnsiteOrders.map((onlineOrderMap) {
                          return DataRow(cells: [
                            DataCell(Text("${onlineOrderMap.id}")),
                            DataCell(Text(onlineOrderMap.fullName)),
                            DataCell(Text(onlineOrderMap.email)),
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
