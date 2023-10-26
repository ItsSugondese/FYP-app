import 'dart:convert';

import 'package:flutter/foundation.dart';

class JwtResponse{
  String jwtToken;
  String username;
  List<String> roles;

  JwtResponse({required this.jwtToken, required this.username, required this.roles});

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
        jwtToken: json['data']['jwtToken'],
      username: json['data']['username'],
      roles: (json['data']['roles'] as List).cast<String>()
    );
  }
}