import 'dart:core';

class FoodMenuRequest {
  int? id;
  String name;
  String description;
  double cost;
  bool isPackage;
  List<String>? menuItems;
  bool isAvailableToday;
  int? photoId;

  FoodMenuRequest(
      {this.id,
      required this.name,
      required this.description,
      required this.cost,
      required this.isPackage,
      this.menuItems,
      required this.isAvailableToday,
      this.photoId});

  factory FoodMenuRequest.fromJson(Map<String, dynamic> json) {
    return FoodMenuRequest(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        cost: json['cost'],
        isPackage: json['isPackage'],
        isAvailableToday: json['isAvailableToday'],
        photoId: json['photoId'],
        menuItems: (json['menuItems'] as List).cast<String>());
  }
}
