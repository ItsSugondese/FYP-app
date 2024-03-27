import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/features/people-mgmt/disable_people_form.dart';
import 'package:fyp/features/people-mgmt/user-mgmt/user-mgmt-service/user_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/podo/people/user/user_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<ScrollController> _scrollControllerList = [];
  late UserManagementService userManagementService;

  late Future<PaginatedData<User>> userFuture;

  UserPaginationPayload paginationPayload = UserPaginationPayload();

  @override
  void initState() {
    super.initState();
    userManagementService = UserManagementService(context);
    userFuture = userManagementService.getAllUsers(paginationPayload.toJson());
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
      drawer: MyDrawer(),
      body: FutureBuilder<PaginatedData<User>>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> listOfOnlineOrders = snapshot.data!.content;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    paginationPayload.page = value + 1;
                    userFuture = userManagementService
                        .getAllUsers(paginationPayload.toJson());
                  });
                },
                itemCount: snapshot.data!.totalPages,
                itemBuilder: ((context, index) {
                  return Center(
                    heightFactor: 1,
                    child: SingleChildScrollView(
                      controller: _scrollControllerList[index],
                      scrollDirection: Axis.horizontal,
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
                                userMap.profilePath ??
                                    ImagePath.getImagePath(
                                        ScreenName.landing, "anon.jpg"),
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
                                ElevatedButton(
                                    onPressed: (() {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return DisablePeopleForm(
                                              user: userMap,
                                            );
                                          });
                                    }),
                                    child: const Text("Disable")),
                                ElevatedButton(
                                    onPressed: (() {
                                      AutoRouter.of(context).push(
                                          UserDetailsScreenRoute(
                                              id: userMap.id));
                                    }),
                                    child: const Text("Inspect")),
                                ElevatedButton(
                                    onPressed: (() {
                                      AutoRouter.of(context).push(
                                          DisableHistoryScreenRoute(
                                              id: userMap.id));
                                    }),
                                    child: const Text("Disable History")),
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
