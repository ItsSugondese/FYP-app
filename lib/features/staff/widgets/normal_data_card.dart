import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';

class NormalDataCard extends StatelessWidget {
  final String amount;
  final String label;

  const NormalDataCard({required this.amount, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimension.getScreenWidth(context) * 0.4,
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0),
      color: const Color.fromARGB(255, 211, 74, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            amount,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
