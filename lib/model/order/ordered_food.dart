class OrderedFood {
  int id;
  int quantity;
  String foodName;
  double cost;
  double totalPrice;

  OrderedFood({
    required this.id,
    required this.quantity,
    required this.foodName,
    required this.cost,
    required this.totalPrice,
  });

  factory OrderedFood.fromJson(Map<String, dynamic> json) {
    return OrderedFood(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      foodName: json['foodName'] ?? '',
      cost: (json['cost'] ?? 0.0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
    );
  }
}
