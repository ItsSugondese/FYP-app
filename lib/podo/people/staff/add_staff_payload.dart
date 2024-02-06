class AddStaffPayload {
  late String fullName;
  late String email;
  late String contactNumber;
  late String? profileId;

  AddStaffPayload({
    required this.fullName,
    required this.email,
    required this.contactNumber,
    this.profileId,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'contactNumber': contactNumber,
      'profileId': profileId,
    };
  }
}
