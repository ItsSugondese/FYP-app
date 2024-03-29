class FoodMenuData {
  int total;
  int latest;
  int today;
  int notToday;

  FoodMenuData({
    required this.total,
    required this.latest,
    required this.today,
    required this.notToday,
  });

  factory FoodMenuData.fromJson(Map<String, dynamic> json) {
    return FoodMenuData(
      total: json['total'] as int,
      latest: json['latest'] as int,
      today: json['today'] as int,
      notToday: json['notToday'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['latest'] = this.latest;
    data['today'] = this.today;
    data['notToday'] = this.notToday;
    return data;
  }
}
