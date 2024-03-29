import 'package:fyp/podo/dashboard/responses/online_order_data.dart';
import 'package:fyp/podo/dashboard/responses/onsite_order_data.dart';

class OrderData {
  int totalOrder;
  int totalPending;
  OnsiteOrderData onsiteOrder;
  OnlineOrderData onlineOrder;

  OrderData({
    required this.totalOrder,
    required this.totalPending,
    required this.onsiteOrder,
    required this.onlineOrder,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      totalOrder: json['totalOrder'] as int,
      totalPending: json['totalPending'] as int,
      onsiteOrder:
          OnsiteOrderData.fromJson(json['onsiteOrder'] as Map<String, dynamic>),
      onlineOrder:
          OnlineOrderData.fromJson(json['onlineOrder'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalOrder'] = this.totalOrder;
    data['totalPending'] = this.totalPending;
    data['onsiteOrder'] = this.onsiteOrder.toJson();
    data['onlineOrder'] = this.onlineOrder.toJson();
    return data;
  }
}
