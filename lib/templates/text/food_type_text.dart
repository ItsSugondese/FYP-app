import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';

class FoodTypeText {
  static Container getFoodType(String text, double size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: CustomColors.foodCategoryBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: CustomColors.foodCategoryFontColor,
          fontWeight: FontWeight.w500,
          fontSize: size,
        ),
      ),
    );
  }
}
