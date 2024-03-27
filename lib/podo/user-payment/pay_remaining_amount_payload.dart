class RemainingPaymentPayload {
  final double paidAmount;
  final int userId;

  RemainingPaymentPayload({required this.paidAmount, required this.userId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paidAmount'] = paidAmount;
    data['userId'] = userId;
    return data;
  }
}
