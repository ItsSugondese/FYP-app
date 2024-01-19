enum PayStatus {
  PAID,
  UNPAID,
  REFUND;
}

extension PayStatusExtension on PayStatus {
  String get stringValue {
    return this.toString().split('.').last;
  }
}
