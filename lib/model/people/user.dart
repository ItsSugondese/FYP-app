class User {
  final bool accountNonLocked;
  final String email;
  final String? profilePath;
  final int id;
  final String fullName;
  final double remainingAmount;

  User(
      {required this.accountNonLocked,
      required this.email,
      this.profilePath,
      required this.id,
      required this.fullName,
      required this.remainingAmount});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accountNonLocked: json['accountNonLocked'],
      email: json['email'],
      profilePath: json['profilePath'],
      id: json['id'],
      fullName: json['fullName'],
      remainingAmount: json['remainingAmount'],
    );
  }

  static User fromJsonModel(Map<String, dynamic> json) => User.fromJson(json);
}
