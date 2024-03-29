class RevenueData {
  double revenue;
  double paidAmount;
  double leftToPay;
  int deliveredOrder;

  RevenueData({
    required this.revenue,
    required this.paidAmount,
    required this.leftToPay,
    required this.deliveredOrder,
  });

  factory RevenueData.fromJson(Map<String, dynamic> json) {
    return RevenueData(
      revenue: double.parse(json['revenue'].toString()),
      paidAmount: double.parse(json['paidAmount'].toString()),
      leftToPay: double.parse(json['leftToPay'].toString()),
      deliveredOrder: json['deliveredOrder'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['revenue'] = this.revenue;
    data['paidAmount'] = this.paidAmount;
    data['leftToPay'] = this.leftToPay;
    data['deliveredOrder'] = this.deliveredOrder;
    return data;
  }
}
