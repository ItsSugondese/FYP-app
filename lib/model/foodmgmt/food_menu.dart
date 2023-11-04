import 'dart:core';
import 'dart:core';
import 'dart:core';


class FoodMenu {
  int? id;
  String name;
  String description;
  double cost;
  bool isPackage;
  List<String>? menuItems;
  bool isAvailableToday;
  int? photoId;

  FoodMenu({this.id, required this.name, required this.description, required this.cost, required this.isPackage,
    this.menuItems, required this.isAvailableToday, this.photoId
  });

  factory FoodMenu.fromJson(Map<String, dynamic> json) {
    return FoodMenu(
        id : json['id'],
        name : json['name'],
        description : json['description'],
        cost : json['cost'],
        isPackage : json['isPackage'],
        isAvailableToday : json['isAvailableToday'],
        photoId : json['photoId'],
        menuItems : (json['menuItems'] as List).cast<String>()
    );
  }

}