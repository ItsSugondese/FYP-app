import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/order-mgmt/online-order/online-order-service/online_order_service.dart';
import 'package:fyp/features/people-mgmt/user-mgmt/user-mgmt-service/user_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/order/online_order.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';

@RoutePage()
class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<ScrollController> _scrollControllerList = [];
  // ScrollController _scrollController = ScrollController();
  UserManagementService onlineOrderService = UserManagementService();

  late Future<PaginatedData<User>> userFuture;

  OnlineOrderPaginationPayload paginationPayload =
      OnlineOrderPaginationPayload();

  @override
  void initState() {
    userFuture =
        onlineOrderService.getAllUsers(context, paginationPayload.toJson());
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
        title: Text('User Management'),
      ),
      body: FutureBuilder<PaginatedData<User>>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> listOfOnlineOrders = snapshot.data!.dataList;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    paginationPayload.page = value + 1;
                    userFuture = onlineOrderService.getAllUsers(
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
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('Id')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: listOfOnlineOrders.map((userMap) {
                          return DataRow(cells: [
                            DataCell(
                              Image.network(
                                userMap.profilePath,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            DataCell(Text("${userMap.id}")),
                            DataCell(Text(userMap.fullName)),
                            DataCell(Text("${userMap.accountNonLocked}")),
                            DataCell(Text("${userMap.email}")),
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
