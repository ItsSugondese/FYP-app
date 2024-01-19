class FoodOrderResponse {
  int? id;
  int foodId;
  int quantity;

  FoodOrderResponse({this.id, required this.foodId, required this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['foodId'] = foodId;
    data['quantity'] = quantity;
    return data;
  }
}
