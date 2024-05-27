import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/notification/notification-service/notification_service.dart';
import 'package:fyp/routes/routes_import.gr.dart';

class NotificationIconWidget extends StatefulWidget {
  const NotificationIconWidget({super.key});

  @override
  State<NotificationIconWidget> createState() => _NotificationIconWidgetState();
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {
  final double? iconSize = 45;
  Timer? _timer;
  late Future<int> notificationServiceFuture;
  late NotificationService notificationService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService = NotificationService(context);
    fetchNotificationCount();
    _timer = Timer.periodic(Duration(seconds: 7), (timer) {
      fetchNotificationCount();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  fetchNotificationCount() {
    setState(() {
      notificationServiceFuture = notificationService.getNotificationCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize, // Adjust the size as needed
      height: iconSize, // Adjust the size as needed
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ], // Adjust the color as needed
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications, // Replace with your desired icon
              ),
              color: Colors.black, // Adjust the icon color as needed
              onPressed: () {
                AutoRouter.of(context).push(const NotificationScreenRoute());
              },
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: FutureBuilder<int>(
                  future: notificationServiceFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int val = snapshot.data!;
                      return val == 0
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors
                                    .red, // Adjust the background color as needed
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                val.toString(), // Change this to your desired number
                                style: TextStyle(
                                  color: Colors
                                      .white, // Adjust the text color as needed
                                  fontSize:
                                      12, // Adjust the font size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                    } else {
                      return SizedBox();
                    }
                  })),
        ],
      ),
    );
  }
}
