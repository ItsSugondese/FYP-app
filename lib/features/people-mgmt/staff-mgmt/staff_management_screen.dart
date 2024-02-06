import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/people-mgmt/disable_people_form.dart';
import 'package:fyp/features/people-mgmt/staff-mgmt/staff-mgmt-service/staff_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/people/staff.dart';
import 'package:fyp/podo/people/staff/staff_pagination.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<ScrollController> _scrollControllerList = [];
  StaffManagementService staffManagementService = StaffManagementService();

  late Future<PaginatedData<Staff>> staffFuture;

  StaffPaginationPayload paginationPayload = StaffPaginationPayload();

  @override
  void initState() {
    super.initState();
    staffFuture =
        staffManagementService.getAllStaff(context, paginationPayload.toJson());
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
        title: Text('Staff Management'),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<PaginatedData<Staff>>(
          future: staffFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Staff> listOfStaff = snapshot.data!.content;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return Column(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Add staff")),
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        paginationPayload.page = value + 1;
                        staffFuture = staffManagementService.getAllStaff(
                            context, paginationPayload.toJson());
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
                            rows: listOfStaff.map((staffMap) {
                              return DataRow(cells: [
                                DataCell(
                                  Image.memory(
                                    staffMap.image,
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                DataCell(Text("${staffMap.id}")),
                                DataCell(Text(staffMap.fullName)),
                                DataCell(Text("${staffMap.accountNonLocked}")),
                                DataCell(Text("${staffMap.email}")),
                                DataCell(Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: (() {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DisablePeopleForm(
                                                  user: staffMap,
                                                );
                                              });
                                        }),
                                        child: const Text("Disable")),
                                    ElevatedButton(
                                        onPressed: (() {
                                          AutoRouter.of(context).push(
                                              StaffDetailsScreenRoute(
                                                  id: staffMap.id));
                                        }),
                                        child: const Text("Inspect")),
                                    ElevatedButton(
                                        onPressed: (() {
                                          AutoRouter.of(context).push(
                                              DisableHistoryScreenRoute(
                                                  id: staffMap.id));
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
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [Text("${snapshot.error}")],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
