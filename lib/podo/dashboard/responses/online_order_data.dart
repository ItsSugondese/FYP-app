class OnlineOrderData {
  int total;
  int approved;
  int pending;

  OnlineOrderData({
    required this.total,
    required this.approved,
    required this.pending,
  });

  factory OnlineOrderData.fromJson(Map<String, dynamic> json) {
    return OnlineOrderData(
      total: json['total'] as int,
      approved: json['approved'] as int,
      pending: json['pending'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['approved'] = this.approved;
    data['pending'] = this.pending;
    return data;
  }
}
