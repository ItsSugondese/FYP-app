import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/people-mgmt/staff-mgmt/staff-mgmt-service/staff_management_service.dart';
import 'package:fyp/model/people/staff.dart';

@RoutePage()
class StaffDetailsScreen extends StatefulWidget {
  final int id;
  const StaffDetailsScreen({super.key, required this.id});

  @override
  State<StaffDetailsScreen> createState() => _StaffDetailsScreenState();
}

class _StaffDetailsScreenState extends State<StaffDetailsScreen> {
  final List<ScrollController> _scrollControllerList = [];
  // ScrollController _scrollController = ScrollController();
  StaffManagementService staffManagementService = StaffManagementService();

  late Future<Staff> staffFuture;

  @override
  void initState() {
    super.initState();
    staffFuture = staffManagementService.getSingleStaff(context, widget.id);
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
      body: FutureBuilder<Staff>(
          future: staffFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Staff staffDetails = snapshot.data!;
              return Center(
                heightFactor: 1,
                child: Container(
                  child: Column(children: [
                    Text(staffDetails.fullName),
                    Text(staffDetails.email),
                    Text("${staffDetails.accountNonLocked}"),
                    Image.memory(staffDetails.image)
                  ]),
                ),
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
