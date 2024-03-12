import 'dart:typed_data';

class FoodMenuForFeedback {
  final int foodId;
  final Uint8List image;
  final String foodName;
  final String foodType;
  final bool isGiven;
  final double price;

  FoodMenuForFeedback(
      {required this.foodId,
      required this.image,
      required this.foodName,
      required this.isGiven,
      required this.price,
      required this.foodType});

  factory FoodMenuForFeedback.fromJson(
      Map<String, dynamic> json, Uint8List image) {
    return FoodMenuForFeedback(
        foodId: json['foodId'] as int,
        image: image,
        foodName: json['foodName'] as String,
        isGiven: json['given'] as bool,
        price: json['price'].toDouble(),
        foodType: json['foodType'] as String);
  }
}
