import 'package:fyp/model/foodmgmt/Food_menu_item_with_image.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';

class FoodOrderingDetails {
  int? id;
  int quantity;
  FoodMenu foodMenu;

  FoodOrderingDetails(
      {this.id, required this.quantity, required this.foodMenu});
}
