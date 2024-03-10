import 'dart:typed_data';

class FoodMenuForFeedback {
  final int foodId;
  final Uint8List image;
  final String foodName;
  final bool isGiven;

  FoodMenuForFeedback({
    required this.foodId,
    required this.image,
    required this.foodName,
    required this.isGiven,
  });

  factory FoodMenuForFeedback.fromJson(
      Map<String, dynamic> json, Uint8List image) {
    return FoodMenuForFeedback(
      foodId: json['foodId'] as int,
      image: image,
      foodName: json['foodName'] as String,
      isGiven: json['isGiven'] as bool,
    );
  }
}
