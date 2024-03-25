import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';

class FoodCardWidget extends StatelessWidget {
  final FoodMenu foodMenu;
  const FoodCardWidget({super.key, required this.foodMenu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: Dimension.getScreenWidth(context) * 0.4,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 100,
                child: Image.memory(
                  foodMenu.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 100,
                ),
              ),
            ),
            SizedBox(height: 3),
            Text(
              "${foodMenu.name}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs. ${foodMenu.cost}",
                  style: const TextStyle(
                    color: CustomColors.priceCOlor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: CustomColors.foodCategoryBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${foodMenu.foodType}",
                    style: TextStyle(
                      color: CustomColors.foodCategoryFontColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
