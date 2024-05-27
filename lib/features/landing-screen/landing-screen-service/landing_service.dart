import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/podo/foodmgmt/toggle_menu_payload.dart';
import 'package:fyp/services/network/dio_service.dart';
import 'package:fyp/services/user/user_service.dart';

class LandingService {
  late final Dio _dio;
  late final BuildContext _context;
  String selectedFilterer = "ALL";
  LandingService(BuildContext context) {
    _dio = DioService.getDioConfigWithContext(context);
    _context = context;
  }

  Future<void> ping() async {
    try {
      Response response = await _dio.get(
        "${ApiConstant.backendUrl}/${ModuleName.COMPANY}/ping",
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        UserService.dashboardManagement(AutoRouter.of(_context));
      } else {
        throw Exception("Error when getting data");
      }
    } on DioException catch (e) {
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }
}
