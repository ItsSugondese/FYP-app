class ToggleMenuAvailabilityPayload {
  final int foodId;
  final bool status;

  ToggleMenuAvailabilityPayload({
    required this.foodId,
    required this.status,
  });

  factory ToggleMenuAvailabilityPayload.fromJson(Map<String, dynamic> json) {
    return ToggleMenuAvailabilityPayload(
      foodId: json['foodId'] as int,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'status': status,
    };
  }
}
