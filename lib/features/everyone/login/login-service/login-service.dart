import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/features/everyone/test.dart';
import 'package:fyp/model/auth/ErrorResponse.dart';
import 'package:fyp/model/auth/jwt/JwtResponse.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/network/dio_service.dart';
import 'package:fyp/services/storage/store_service.dart';

import '../../../../config/network/api/GoogleSignInApi.dart';

String endpoint = "http://localhost:9192/canteen";

class LoginService {
  late final Dio _dio;

  LoginService() {
    _dio = DioService.getDioConfig();
  }

  Future signIn(BuildContext context) async {
    try {
      final idToken = await (await GoogleSignInApi.login())
          ?.authentication
          .then((value) => value.idToken);
      final response = await login(context, idToken);
      Store.setToken(response!.jwtToken);
      Store.setRoles(response.roles);
      Store.setUsername(response.username);
      AutoRouter.of(context).push(const TestScreenRoute());
    } on DioException catch (exception){
      final error = DioService.handleDioException(exception);
      debugPrint(error.message);
      showErrorSnackBar(context, error.message  ?? 'Error happended when logging in');
      GoogleSignInApi.logout();
    }
    on Exception catch (exception) {
      debugPrint(exception.toString());
      showErrorSnackBar(context, toString());
      GoogleSignInApi.logout();
    }
  }


  Future<JwtResponse?> login(BuildContext context, String? credientials) async {
    //POST operation starts from here
    Response response = await _dio.post(
      "${ApiConstant.backendUrl}/auth/login-with-google",
      data: credientials,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return JwtResponse.fromJson(response.data);
    } else {
      final error = ErrorModel.fromJson(response.data);
      throw Exception(error);
    }
  }



  void showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }
}
