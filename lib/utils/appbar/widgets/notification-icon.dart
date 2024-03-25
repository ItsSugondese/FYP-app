import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/routes/routes_import.gr.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  final double? iconSize = 45;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize, // Adjust the size as needed
      height: iconSize, // Adjust the size as needed
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
        icon: const Icon(Icons.notifications), // Replace with your desired icon
        color: Colors.black, // Adjust the icon color as needed
        onPressed: () {
          AutoRouter.of(context).push(const NotificationScreenRoute());
        },
      ),
    );
  }
}
