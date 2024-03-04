import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/model/auth/ErrorResponse.dart';
import 'package:fyp/services/network/dio_service.dart';

class OnlineOrderService {
  late final Dio _dio;

  OnlineOrderService(BuildContext context) {
    _dio = DioService.getDioConfigWithContext(context);
  }

  Future<void> makeOnlineOrder(Map<String, dynamic> data) async {
    Response response = await _dio.post(
      "${ApiConstant.backendUrl}/online-order",
      data: jsonEncode(data),
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("done");
    } else {
      final error = ErrorModel.fromJson(response.data);
      throw Exception(error);
    }
  }

  Future<void> getOnlineOrder(Map<String, dynamic> data) async {
    Response response = await _dio.post(
      "${ApiConstant.backendUrl}/online-order",
      data: jsonEncode(data),
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("done");
    } else {
      final error = ErrorModel.fromJson(response.data);
      throw Exception(error);
    }
  }
}
