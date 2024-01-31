class DisableUserPayload {
  final String? remarks;
  final int userId;
  final bool isDisabled;

  DisableUserPayload({
    required this.remarks,
    required this.userId,
    required this.isDisabled,
  });

  factory DisableUserPayload.fromJson(Map<String, dynamic> json) {
    return DisableUserPayload(
      remarks: json['remarks'],
      userId: json['userId'],
      isDisabled: json['isDisabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remarks': remarks,
      'userId': userId,
      'isDisabled': isDisabled,
    };
  }
}
