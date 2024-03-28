import 'package:fyp/model/order/ordered_food.dart';

class OnsiteOrder {
  final int id;
  final String fullName;
  final int userId;
  final String orderType;
  final String email;
  final String orderedTime;
  final String orderStatus;
  final List<OrderedFood> orderFoodDetails;
  final double totalPrice;
  final double remainingAmount;
  final bool? feedbackStatus;

  OnsiteOrder(
      {required this.id,
      required this.fullName,
      required this.userId,
      required this.orderType,
      required this.email,
      required this.orderedTime,
      required this.orderStatus,
      required this.orderFoodDetails,
      required this.totalPrice,
      required this.remainingAmount,
      required this.feedbackStatus});

  factory OnsiteOrder.fromJson(
      Map<String, dynamic> json, List<OrderedFood> orderedFood) {
    return OnsiteOrder(
        id: json['id'] ?? 0,
        fullName: json['fullName'] ?? '',
        userId: json['userId'] ?? 0,
        orderType: json['orderType'] ?? '',
        email: json['email'] ?? '',
        orderedTime: json['orderedTime'] ?? '',
        orderFoodDetails: orderedFood,
        orderStatus: json['orderStatus'],
        totalPrice: json['totalPrice'],
        remainingAmount: json['remainingAmount'],
        feedbackStatus: json['feedbackStatus']);
  }
}
