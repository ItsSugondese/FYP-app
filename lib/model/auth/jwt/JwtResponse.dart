class JwtResponse {
  String jwtToken;
  String username;
  String email;
  int userId;
  List<String> roles;

  JwtResponse(
      {required this.jwtToken,
      required this.username,
      required this.roles,
      required this.email,
      required this.userId});

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
        jwtToken: json['data']['jwtToken'],
        username: json['data']['username'],
        email: json['data']['email'],
        userId: json['data']['userId'],
        roles: (json['data']['roles'] as List).cast<String>());
  }
}
