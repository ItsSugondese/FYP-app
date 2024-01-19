class FoodMenuResponse {
  final int? id;
  final String name;
  final String? description;
  final double cost;
  final bool isPackage;
  final List<String>? menuItems;
  final bool isAvailableToday;
  final int? photoId;

  FoodMenuResponse({
    this.id,
    required this.name,
    this.description,
    required this.cost,
    required this.isPackage,
    this.menuItems,
    required this.isAvailableToday,
    this.photoId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cost': cost,
      'isPackage': isPackage,
      'menuItems': menuItems,
      'isAvailableToday': isAvailableToday,
      'photoId': photoId,
    };
  }
}
