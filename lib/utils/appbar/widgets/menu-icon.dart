import 'package:flutter/material.dart';

class MenuIconWidget extends StatelessWidget {
  const MenuIconWidget({super.key});

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
        icon: const Icon(Icons.menu), // Replace with your desired icon
        color: Colors.black, // Adjust the icon color as needed
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }
}
