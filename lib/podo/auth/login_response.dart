class UserCredentials {
  String userEmail;
  String userPassword;
  String device;

  UserCredentials(
      {required this.userEmail,
      required this.userPassword,
      required this.device});

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'userPassword': userPassword,
      'device': device
    };
  }
}
