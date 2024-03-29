import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/helper/widgets/service_helper.dart';
import 'package:fyp/model/auth/ErrorResponse.dart';
import 'package:fyp/model/auth/jwt/JwtResponse.dart';
import 'package:fyp/podo/auth/login_response.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/network/dio_service.dart';
import 'package:fyp/services/storage/store_service.dart';

// import 'package:google_sign_in/google_sign_in.dart';

import '../../../config/network/api/GoogleSignInApi.dart';

String endpoint = "http://localhost:9192/canteen";

class LoginService {
  late final Dio _dio;

  LoginService(BuildContext context) {
    _dio = DioService.getDioConfigWithContext(context);
  }

  // Future signIn(BuildContext context) async {
  //   try {
  //     final idToken = await (await GoogleSignInApi.login())
  //         ?.authentication
  //         .then((value) => value.idToken);

  //     print(idToken);
  //     // final response = await login(context, idToken);
  //     // Store.setToken(response!.jwtToken);
  //     // Store.setRoles(response.roles);
  //     // Store.setUsername(response.username);
  //     // AutoRouter.of(context).push(const HomepageRoute());
  //   } on DioException catch (exception) {
  //     final error = DioService.handleDioException(exception);
  //     debugPrint(error.message);
  //     ServiceHelper.showErrorSnackBar(
  //         context, error.message ?? 'Error happended when logging in');
  //     // GoogleSignInApi.logout();
  //   } on Exception catch (exception) {
  //     debugPrint(exception.toString());
  //     ServiceHelper.showErrorSnackBar(context, toString());
  //     // GoogleSignInApi.logout();
  //   }
  // }

  Future signIn(BuildContext context) async {
    try {
      final response = await tempLogin();
      Store.setToken(response!.jwtToken);
      Store.setRoles(response.roles);
      Store.setUsername(response.username);
      AutoRouter.of(context).push(const HomepageRoute());
    } on DioException catch (exception) {
      final error = DioService.handleDioException(exception);
      debugPrint(error.message);
      ServiceHelper.showErrorSnackBar(
          context, error.message ?? 'Error happended when logging in');
      GoogleSignInApi.logout();
    } on Exception catch (exception) {
      debugPrint(exception.toString());
      ServiceHelper.showErrorSnackBar(context, toString());
      GoogleSignInApi.logout();
    }
  }

  Future tempLogin() async {
    UserCredentials userCredentials = UserCredentials(
        userEmail: "np05cp4a210083@iic.edu.np",
        userPassword: "107449163184477293175");
    // Map<String, dynamic> val = {
    //   "userEmail": "np05cp4a210083@iic.edu.np" as String,
    //   "userPassword": "107449163184477293175" as String
    // };

    Response response = await _dio.post(
      "${ApiConstant.backendUrl}/auth/login",
      data: userCredentials.toJson(),
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );

    // final response = await http.post(
    //   Uri.parse("${ApiConstant.backendUrl}/auth/login"),
    //   body: json.encode(val),
    // );

    if (response.statusCode == 200) {
      return JwtResponse.fromJson(response.data);
    } else {
      final error = ErrorModel.fromJson(response.data);
      throw Exception(error);
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
}
