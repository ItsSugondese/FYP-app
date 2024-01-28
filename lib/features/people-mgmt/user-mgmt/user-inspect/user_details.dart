import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/people-mgmt/user-mgmt/user-mgmt-service/user_management_service.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/podo/orders/online-order/online_order_pagination.dart';

@RoutePage()
class UserDetailsScreen extends StatefulWidget {
  final int id;
  const UserDetailsScreen({super.key, required this.id});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final List<ScrollController> _scrollControllerList = [];
  // ScrollController _scrollController = ScrollController();
  UserManagementService userManagementService = UserManagementService();

  late Future<User> userFuture;

  OnlineOrderPaginationPayload paginationPayload =
      OnlineOrderPaginationPayload();

  @override
  void initState() {
    super.initState();
    userFuture = userManagementService.getSingleUser(context, widget.id);
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
      body: FutureBuilder<User>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User userDetails = snapshot.data!;
              return Center(
                heightFactor: 1,
                child: Container(
                  child: Column(children: [
                    Text(userDetails.fullName),
                    Text(userDetails.email),
                    Text("${userDetails.accountNonLocked}"),
                    Image.network(userDetails.profilePath)
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