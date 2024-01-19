import 'package:flutter/material.dart';

class ServiceHelper {
  static void showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }

  static void showSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green, // You can customize the background color
    );

    // Find the ScaffoldMessenger in the widget tree and show the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
