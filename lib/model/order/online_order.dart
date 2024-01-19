import 'package:fyp/model/order/ordered_food.dart';

class OnlineOrder {
  String orderCode;
  String fullName;
  int userId;
  String approvalStatus;
  int id;
  String toTime;
  String fromTime;
  String email;
  String timeRange;
  List<OrderedFood> orderFoodDetails;

  OnlineOrder({
    required this.orderCode,
    required this.fullName,
    required this.userId,
    required this.approvalStatus,
    required this.id,
    required this.toTime,
    required this.fromTime,
    required this.email,
    required this.timeRange,
    required this.orderFoodDetails,
  });

  factory OnlineOrder.fromJson(
      Map<String, dynamic> json, List<OrderedFood> orderedFood) {
    return OnlineOrder(
      orderCode: json['order_code'] ?? '',
      fullName: json['full_name'] ?? '',
      userId: json['user_id'] ?? 0,
      approvalStatus: json['approval_status'] ?? '',
      id: json['id'] ?? 0,
      toTime: json['to_time'] ?? '',
      fromTime: json['from_time'] ?? '',
      email: json['email'] ?? '',
      timeRange: json['time_range'] ?? '',
      orderFoodDetails: orderedFood,
    );
  }
}
