import 'package:fyp/model/order/ordered_food.dart';

class UserOrderHistory {
  final int id;
  final List<OrderedFood> orderFoodDetails;
  final int orderCode;
  final String arrivalTime;

  UserOrderHistory(
      {required this.id,
      required this.orderFoodDetails,
      required this.orderCode,
      required this.arrivalTime});

  factory UserOrderHistory.fromJson(
      Map<String, dynamic> json, List<OrderedFood> orderedFood) {
    return UserOrderHistory(
      id: json['id'],
      orderCode: int.parse(json['orderCode']),
      arrivalTime: json['arrivalTime'],
      orderFoodDetails: orderedFood,
    );
  }
}
