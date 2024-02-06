import 'package:flutter/foundation.dart';

class OrderedFood {
  int id;
  int quantity;
  String foodName;
  double cost;
  double totalPrice;
  Uint8List? photo;

  OrderedFood(
      {required this.id,
      required this.quantity,
      required this.foodName,
      required this.cost,
      required this.totalPrice,
      this.photo});

  factory OrderedFood.fromJson(Map<String, dynamic> json, Uint8List? photo) {
    return OrderedFood(
        id: json['id'] ?? 0,
        quantity: json['quantity'] ?? 0,
        foodName: json['foodName'] ?? '',
        cost: (json['cost'] ?? 0.0).toDouble(),
        totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
        photo: photo);
  }
}
