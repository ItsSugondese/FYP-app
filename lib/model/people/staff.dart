import 'dart:typed_data';

class Staff {
  final bool accountNonLocked;
  final String email;
  final Uint8List image;
  final int id;
  final String fullName;

  Staff({
    required this.accountNonLocked,
    required this.email,
    required this.image,
    required this.id,
    required this.fullName,
  });

  factory Staff.fromJson(Map<String, dynamic> json, Uint8List image) {
    return Staff(
      accountNonLocked: json['accountNonLocked'],
      email: json['email'],
      image: image,
      id: json['id'],
      fullName: json['fullName'],
    );
  }

  static Staff fromJsonImageModel(Map<String, dynamic> json, Uint8List image) =>
      Staff.fromJson(json, image);
}
