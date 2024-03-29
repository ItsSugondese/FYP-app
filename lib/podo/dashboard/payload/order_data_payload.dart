class OrderDataPayload {
  int timeDifference;

  OrderDataPayload({
    required this.timeDifference,
  });

  Map<String, dynamic> toJson() {
    return {
      'timeDifference': timeDifference,
    };
  }
}
