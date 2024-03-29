import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/podo/dashboard/responses/food_menu_data.dart';
import 'package:fyp/podo/dashboard/responses/order_data.dart';
import 'package:fyp/podo/dashboard/responses/sales_data.dart';
import 'package:fyp/services/network/dio_service.dart';

class DashboardService {
  late final Dio _dio;

  DashboardService(BuildContext context) {
    _dio = DioService.getDioConfigWithContext(context);
  }

  Future<RevenueData> getRevenueData(Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/admin/${ModuleName.DASHBOARD}/revenue-data",
        data: json.encode(map),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          return RevenueData.fromJson(response.data['data']);
        } else {
          throw Exception(
              MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
        }
      } else {
        throw Exception(
            MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
      }
    } on DioException catch (e) {
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<OrderData> getOrderData(Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/admin/${ModuleName.DASHBOARD}/order-data",
        data: json.encode(map),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          return OrderData.fromJson(response.data['data']);
        } else {
          throw Exception(
              MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
        }
      } else {
        throw Exception(
            MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
      }
    } on DioException catch (e) {
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<FoodMenuData> getFoodData(Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/admin/${ModuleName.DASHBOARD}/food-menu-data",
        data: json.encode(map),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          return FoodMenuData.fromJson(response.data['data']);
        } else {
          throw Exception(
              MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
        }
      } else {
        throw Exception(
            MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
      }
    } on DioException catch (e) {
      throw (DioService.handleDioException(e)).message;
    }
  }
}
