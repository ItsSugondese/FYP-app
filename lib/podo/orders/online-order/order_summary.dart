import 'dart:typed_data';

class SummaryData {
  final int id;
  final int quantity;
  final String foodName;
  final int photoId;
  final Uint8List? image;

  SummaryData(
      {required this.id,
      required this.quantity,
      required this.foodName,
      required this.photoId,
      this.image});

  factory SummaryData.fromJson(Map<String, dynamic> json, Uint8List image) {
    return SummaryData(
        id: json['id'] as int,
        quantity: json['quantity'] as int,
        foodName: json['foodName'] as String,
        photoId: json['photoId'] as int,
        image: image);
  }
}
