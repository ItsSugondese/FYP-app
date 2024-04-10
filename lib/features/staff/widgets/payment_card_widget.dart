import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';

class PaymentCard extends StatelessWidget {
  final String amount;
  final String label;

  const PaymentCard({required this.amount, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          width: Dimension.getScreenWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
