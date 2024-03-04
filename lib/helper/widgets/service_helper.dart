import 'package:flutter/material.dart';

class ServiceHelper {
  static void showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red, // Adjust the duration as needed
      ),
    );
  }

  static void showSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.green, // You can customize the background color
      // behavior: SnackBarBehavior.floating, // Show at the top
      // margin: EdgeInsets.all(3.0), // Adjust padding as needed
    );

    // Find the ScaffoldMessenger in the widget tree and show the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
