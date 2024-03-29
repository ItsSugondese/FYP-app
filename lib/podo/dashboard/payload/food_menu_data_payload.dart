class FoodMenuDataPayload {
  String? fromDate;
  String? toDate;

  FoodMenuDataPayload({
    this.fromDate,
    this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}
