import 'dart:convert';

import 'package:fyp/enums/pay_status.dart';
import 'package:fyp/podo/foodmgmt/food_order_response.dart';

class OnsiteOrderResponse {
  int? id;
  List<FoodOrderResponse> foodOrderList;
  List<int>? removeFoodId;
  int? onlineOrderId;
  PayStatus payStatus;
  int tableNumber;

  OnsiteOrderResponse(
      {this.id,
      required this.foodOrderList,
      this.removeFoodId,
      this.onlineOrderId,
      required this.payStatus,
      required this.tableNumber});

  dynamic toJson() {
    return {
      "id": id,
      "foodOrderList": foodOrderList,
      "onlineOrderId": onlineOrderId,
      "removeFoodId": removeFoodId ?? [],
      "payStatus": payStatus.stringValue,
      "tableNumber": tableNumber
    };
  }
}
