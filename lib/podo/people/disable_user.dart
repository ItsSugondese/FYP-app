class DisableUser {
  final String? remarks;
  final int userId;
  final bool isDisabled;

  DisableUser({
    required this.remarks,
    required this.userId,
    required this.isDisabled,
  });

  factory DisableUser.fromJson(Map<String, dynamic> json) {
    return DisableUser(
      remarks: json['remarks'],
      userId: json['userId'],
      isDisabled: json['isDisabled'],
    );
  }
}
