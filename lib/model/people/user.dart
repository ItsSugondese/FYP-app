class User {
  final bool accountNonLocked;
  final String email;
  final String profilePath;
  final int id;
  final String fullName;

  User({
    required this.accountNonLocked,
    required this.email,
    required this.profilePath,
    required this.id,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accountNonLocked: json['accountNonLocked'],
      email: json['email'],
      profilePath: json['profilePath'],
      id: json['id'],
      fullName: json['fullName'],
    );
  }

  static User fromJsonModel(Map<String, dynamic> json) => User.fromJson(json);
}
