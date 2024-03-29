class RevenueDataPayload {
  String? fromDate;
  String? toDate;

  RevenueDataPayload({this.fromDate, this.toDate});

  Map<String, dynamic> toJson() {
    return {
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}
