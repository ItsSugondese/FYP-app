import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/model/order/ordered_food.dart';

class OrderedFoodCard extends StatelessWidget {
  final OrderedFood orderedFood;
  const OrderedFoodCard({super.key, required this.orderedFood});
  // const OrderedFoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
              minWidth: 0, maxWidth: Dimension.getScreenWidth(context) * 0.6),
          // width: Dimension.getScreenWidth(context) * 0.6,
          // width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 75,
                  height: 75,
                  child: Image.memory(
                    orderedFood.photo!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        orderedFood.foodName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Rs. ${orderedFood.cost}",
                        style: const TextStyle(
                          color: CustomColors.priceCOlor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "x${orderedFood.quantity}",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
