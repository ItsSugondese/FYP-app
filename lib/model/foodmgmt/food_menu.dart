import 'dart:core';
import 'dart:typed_data';

class FoodMenu {
  int id;
  String name;
  String description;
  double cost;
  bool isPackage;
  List<String>? menuItems;
  bool isAvailableToday;
  Uint8List image;
  int photoId;
  FoodMenu(
      {required this.id,
      required this.name,
      required this.description,
      required this.cost,
      required this.isPackage,
      this.menuItems,
      required this.isAvailableToday,
      required this.image,
      required this.photoId});

  factory FoodMenu.fromJson(Map<String, dynamic> json, Uint8List image) {
    return FoodMenu(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        cost: json['cost'],
        isPackage: json['isPackage'],
        isAvailableToday: json['isAvailableToday'],
        image: image,
        menuItems: (json['menuItems'] as List).cast<String>(),
        photoId: json['photoId']);
  }
}
