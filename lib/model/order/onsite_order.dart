import 'package:fyp/model/order/ordered_food.dart';

class OnsiteOrder {
  final int id;
  final String fullName;
  final int userId;
  final String orderType;
  final String email;
  final String orderedTime;
  final List<OrderedFood> orderFoodDetails;

  OnsiteOrder({
    required this.id,
    required this.fullName,
    required this.userId,
    required this.orderType,
    required this.email,
    required this.orderedTime,
    required this.orderFoodDetails,
  });

  factory OnsiteOrder.fromJson(
      Map<String, dynamic> json, List<OrderedFood> orderedFood) {
    return OnsiteOrder(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      userId: json['user_id'] ?? 0,
      orderType: json['orderType'] ?? '',
      email: json['email'] ?? '',
      orderedTime: json['orderedTime'] ?? '',
      orderFoodDetails: orderedFood,
    );
  }
}
