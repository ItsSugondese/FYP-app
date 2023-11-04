import 'dart:typed_data';

import 'food_menu.dart';

class FoodMenuItemWithImage {
  final FoodMenu foodMenu;
  final Uint8List? image;

  FoodMenuItemWithImage(this.foodMenu, this.image);
}
