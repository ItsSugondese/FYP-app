import 'package:fyp/model/order/ordered_food.dart';

class UserOrderHistory {
  final int id;
  final String orderType;
  final List<OrderedFood>? orderFoodDetails;

  UserOrderHistory({
    required this.id,
    required this.orderType,
    required this.orderFoodDetails,
  });

  factory UserOrderHistory.fromJson(
      Map<String, dynamic> json, List<OrderedFood> orderedFood) {
    return UserOrderHistory(
      id: json['id'],
      orderType: json['ordertype'],
      orderFoodDetails: orderedFood,
    );
  }
}
