class UserCredentials {
  String userEmail;
  String userPassword;

  UserCredentials({
    required this.userEmail,
    required this.userPassword,
  });

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      userEmail: json['userEmail'],
      userPassword: json['userPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }
}
