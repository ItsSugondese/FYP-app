import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/templates/pop-up/are_you_sure_pop_up.dart';

class OrderedFoodForOnlineCard extends StatelessWidget {
  final OrderedFood orderedFood;
  final VoidCallback clicked;
  const OrderedFoodForOnlineCard(
      {super.key, required this.orderedFood, required this.clicked});
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
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AreYouSurePopUp(
                          callback: (val) async {
                            if (val) {
                              clicked();
                            }
                          },
                          description:
                              "Are you sure you want to remove this food from order?",
                          header: "Remove Food from order",
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete)),
              Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.memory(
                    orderedFood.photo!,
                    fit: BoxFit.cover,
                    height: Dimension.getScreenHeight(context) * 0.08,
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
                      orderedFood.foodName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
