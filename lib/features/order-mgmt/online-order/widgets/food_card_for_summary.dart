import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/podo/orders/online-order/order_summary.dart';
import 'package:fyp/templates/pop-up/are_you_sure_pop_up.dart';

class SummaryFoodCard extends StatelessWidget {
  final SummaryData summaryData;
  final VoidCallback clicked;
  const SummaryFoodCard(
      {super.key, required this.summaryData, required this.clicked});
  // const OrderedFoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IntrinsicWidth(
        child: Container(
          width: Dimension.getScreenWidth(context) * 1,
          constraints: BoxConstraints(
              minWidth: 0, maxWidth: Dimension.getScreenWidth(context) * 1),
          // width: Dimension.getScreenWidth(context) * 0.6,
          // width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.memory(
                    summaryData.image!,
                    fit: BoxFit.cover,
                    width: Dimension.getScreenWidth(context) * 0.15,
                    height: Dimension.getScreenHeight(context) * 0.1,
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      summaryData.foodName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "x${summaryData.quantity}",
                      style: const TextStyle(
                        color: Color(0xFF8D8D8D),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
