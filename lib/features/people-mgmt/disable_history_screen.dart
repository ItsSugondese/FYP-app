import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/people-mgmt/people-mgmt-service/people_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/people/disable_history.dart';
import 'package:fyp/podo/people/disable_user_pagination.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class DisableHistoryScreen extends StatefulWidget {
  final int id;
  const DisableHistoryScreen({super.key, required this.id});

  @override
  State<DisableHistoryScreen> createState() => _DisableHistoryScreenState();
}

class _DisableHistoryScreenState extends State<DisableHistoryScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<ScrollController> _scrollControllerList = [];
  PeopleManagementService peopleManagementService = PeopleManagementService();

  late Future<PaginatedData<DisableHistory>> disableHistoryFuture;

  late DisableUserHistoryPagination paginationPayload;

  @override
  void initState() {
    super.initState();
    paginationPayload = DisableUserHistoryPagination(userId: widget.id);
    print("Pagination Payload JSON: ${paginationPayload.toJson()}");
    disableHistoryFuture = peopleManagementService.getDisableHistory(
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
        title: Text('Disable History'),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<PaginatedData<DisableHistory>>(
          future: disableHistoryFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DisableHistory> listOfHistory = snapshot.data!.content;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    paginationPayload.page = value + 1;
                    disableHistoryFuture = peopleManagementService
                        .getDisableHistory(context, paginationPayload.toJson());
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
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Is Disabled')),
                          DataColumn(label: Text('Remarks')),
                        ],
                        rows: listOfHistory.map((historyMap) {
                          return DataRow(cells: [
                            DataCell(Text("${historyMap.id}")),
                            DataCell(Text(historyMap.date)),
                            DataCell(Text("${historyMap.isDisabled}")),
                            DataCell(Text("${historyMap.remarks}")),
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
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
