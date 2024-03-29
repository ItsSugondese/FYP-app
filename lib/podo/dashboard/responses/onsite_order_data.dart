class OnsiteOrderData {
  int total;
  int delivered;
  int pending;
  int canceled;

  OnsiteOrderData({
    required this.total,
    required this.delivered,
    required this.pending,
    required this.canceled,
  });

  factory OnsiteOrderData.fromJson(Map<String, dynamic> json) {
    return OnsiteOrderData(
      total: json['total'] as int,
      delivered: json['delivered'] as int,
      pending: json['pending'] as int,
      canceled: json['canceled'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['delivered'] = this.delivered;
    data['pending'] = this.pending;
    data['canceled'] = this.canceled;
    return data;
  }
}
