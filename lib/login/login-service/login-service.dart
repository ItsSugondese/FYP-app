import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fyp/model/jwt/JwtResponse.dart';
import 'package:http/http.dart' as http;

String endpoint = "http://localhost:9192/canteen";
Future<JwtResponse?> sendLoginCredientials(String? credientials) async{

    //POST operation starts from here
    final response = await http.post(Uri.parse("http://192.168.1.69:9192/canteen/auth/login-with-google"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(credientials),

    );

    if (response.statusCode != 201) {

      return JwtResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }

}