import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/api_image_constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/auth/ErrorResponse.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/services/image-fetch-service/image_fetch_service.dart';
import 'package:fyp/services/network/dio_service.dart';

class OnsiteOrderService {
  late final Dio _dio;

  OnsiteOrderService(BuildContext context) {
    _dio = DioService.getDioConfigWithContext(context);
  }

  Future<bool> makeOnsiteOrder(Map<String, dynamic> data) async {
    Response response = await _dio.post(
      "${ApiConstant.backendUrl}/onsite-order",
      data: jsonEncode(data),
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final error = ErrorModel.fromJson(response.data);
      throw Exception(error);
    }
  }

  Future<bool> verifyOnsite(String text) async {
    Response response = await _dio.get(
      "${ApiConstant.backendUrl}/onsite-order/verify-onsite/$text",
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      final error = ErrorModel.fromJson(response.data);
      throw Exception(error);
    }
  }

  Future<bool> cancelOrder(int orderId) async {
    Response response = await _dio
        .get("${ApiConstant.backendUrl}/onsite-order/status/$orderId/CANCELED");

    if (response.statusCode == 200) {
      return true;
    } else {
      final error = ErrorModel.fromJson(response.data);
      throw Exception(error);
    }
  }

  Future<PaginatedData<OnsiteOrder>> getUserOnsiteOrderHistory(
      Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(
          "${ApiConstant.backendUrl}/${ModuleName.ONSITE_ORDER}/history/paginated",
          data: jsonEncode(data));

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          List<dynamic> jsonDataList = response.data['data']['content'];
          List<OnsiteOrder> userOrderHistoryList = [];

          for (var jsonData in jsonDataList) {
            List<OrderedFood> orderedFoodList = [];
            for (var foodJson in jsonData['orderFoodDetails']) {
              orderedFoodList.add(OrderedFood.fromJson(
                  foodJson,
                  await FetchImageService.fetchBlobData(_dio,
                      ApiImageConstants.getFoodImage(foodJson['photoId']))));
            }

            userOrderHistoryList
                .add(OnsiteOrder.fromJson(jsonData, orderedFoodList));
          }

          int totalPages = response.data['data']['totalPages'];
          int totalElements = response.data['data']['totalElements'];
          int numberOfElements = response.data['data']['numberOfElements'];
          int currentPageIndex = response.data['data']['currentPageIndex'];

          return PaginatedData<OnsiteOrder>(
            content: userOrderHistoryList,
            totalPages: totalPages,
            totalElements: totalElements,
            numberOfElements: numberOfElements,
            currentPageIndex: currentPageIndex,
          );
        } else {
          throw Exception(
              MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
        }
      } else {
        throw Exception(
            MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
      }
    } on DioException catch (e) {
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<PaginatedData<OnsiteOrder>> getOnsiteOrder(
      Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/${ModuleName.ONSITE_ORDER}/paginated",
        data: json.encode(map),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          List<dynamic> jsonDataList = response.data['data']['content'];
          List<OnsiteOrder> onsiteOrderList = [];

          for (var jsonData in jsonDataList) {
            List<OrderedFood> orderedFoodList = [];
            for (var foodJson in jsonData['orderFoodDetails']) {
              orderedFoodList.add(OrderedFood.fromJson(
                  foodJson,
                  await FetchImageService.fetchBlobData(_dio,
                      ApiImageConstants.getFoodImage(foodJson['photoId']))));
            }

            onsiteOrderList
                .add(OnsiteOrder.fromJson(jsonData, orderedFoodList));
          }

          int totalPages = response.data['data']['totalPages'];
          int totalElements = response.data['data']['totalElements'];
          int numberOfElements = response.data['data']['numberOfElements'];
          int currentPageIndex = response.data['data']['currentPageIndex'];

          return PaginatedData<OnsiteOrder>(
            content: onsiteOrderList,
            totalPages: totalPages,
            totalElements: totalElements,
            numberOfElements: numberOfElements,
            currentPageIndex: currentPageIndex,
          );
        } else {
          throw Exception(
              MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
        }
      } else {
        throw Exception(
            MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
      }
    } on DioException catch (e) {
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<void> updateOrderStatus(int id, String status) async {
    try {
      Response response = await _dio.get(
        "${ApiConstant.backendUrl}/${ModuleName.ONSITE_ORDER}/status/$id/$status",
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
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

  Future<void> markAsRead(int id) async {
    try {
      Response response = await _dio.get(
        "${ApiConstant.backendUrl}/${ModuleName.ONSITE_ORDER}/mark-as-read/$id",
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
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
