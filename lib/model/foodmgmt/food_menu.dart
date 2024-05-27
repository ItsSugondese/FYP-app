import 'dart:core';
import 'dart:typed_data';

class FoodMenu {
  int id;
  String name;
  String description;
  double cost;
  String foodType;
  bool isAvailableToday;
  bool isAuto;
  Uint8List image;
  int photoId;
  int? remainingQuantity;
  FoodMenu(
      {required this.id,
      required this.name,
      required this.description,
      required this.cost,
      required this.isAvailableToday,
      required this.image,
      required this.photoId,
      required this.foodType,
      required this.isAuto,
      this.remainingQuantity});

  factory FoodMenu.fromJson(Map<String, dynamic> json, Uint8List image) {
    return FoodMenu(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        cost: json['cost'],
        isAvailableToday: json['isAvailableToday'],
        image: image,
        isAuto: json['isAuto'],
        photoId: json['photoId'],
        remainingQuantity: json['remQuantity'],
        foodType: json['foodType']);
  }
}
