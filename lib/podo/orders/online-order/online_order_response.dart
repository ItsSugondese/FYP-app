import 'package:fyp/podo/foodmgmt/food_order_response.dart';

class OnlineOrderResponse {
  int? id;
  List<FoodOrderResponse> foodOrderList;
  List<int>? removeFoodId;
  String arrivalTime;
  double totalPrice;

  OnlineOrderResponse(
      {this.id,
      required this.foodOrderList,
      this.removeFoodId,
      required this.arrivalTime,
      required this.totalPrice});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "foodOrderList": foodOrderList,
      "removeFoodId": removeFoodId ?? [],
      "arrivalTime": arrivalTime,
      "totalPrice": totalPrice
    };
  }
}
