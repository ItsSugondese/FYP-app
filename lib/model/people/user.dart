import 'dart:typed_data';

class User {
  final bool accountNonLocked;
  final String email;
  final String? profilePath;
  final int id;
  final String fullName;
  final double? remainingAmount;
  final Uint8List? image;
  final bool isExternal;

  User(
      {required this.accountNonLocked,
      required this.email,
      this.profilePath,
      required this.id,
      required this.fullName,
      required this.remainingAmount,
      this.image,
      required this.isExternal});

  factory User.fromJson(Map<String, dynamic> json, Uint8List? image) {
    return User(
        accountNonLocked: json['accountNonLocked'],
        email: json['email'],
        profilePath: json['profilePath'],
        id: json['id'],
        fullName: json['fullName'],
        isExternal: json['external'],
        remainingAmount: json.containsKey('remainingAmount')
            ? double.parse(json['remainingAmount'].toString())
            : null,
        image: image);
  }

  // static User fromJsonModel(Map<String, dynamic> json) => User.fromJson(json);
}
