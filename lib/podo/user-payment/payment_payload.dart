class PaymentPayload {
  late double totalAmount;
  late double paidAmount;
  double? discount;
  late double dueAmount;
  String? remarks;
  String? paymentMode;
  late int onsiteOrderId;
  late int userId;

  PaymentPayload({
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.onsiteOrderId,
    required this.userId,
    this.discount,
    this.remarks,
    this.paymentMode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAmount'] = totalAmount;
    data['paidAmount'] = paidAmount;
    data['discount'] = discount;
    data['dueAmount'] = dueAmount;
    data['remarks'] = remarks;
    data['paymentMode'] = paymentMode;
    data['onsiteOrderId'] = onsiteOrderId;
    data['userId'] = userId;
    return data;
  }
}
