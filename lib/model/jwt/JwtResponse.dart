import 'dart:convert';

import 'package:flutter/foundation.dart';

class JwtResponse{
  String jwtToken;

  JwtResponse({required this.jwtToken});

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
        jwtToken: json['data']['jwtToken']
    );
  }
}