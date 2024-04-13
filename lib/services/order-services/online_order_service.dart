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
import 'package:fyp/model/order/online_order.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/podo/orders/online-order/order_summary.dart';
import 'package:fyp/services/image-fetch-service/image_fetch_service.dart';
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

  Future<PaginatedData<OnlineOrder>> getOnlineOrder(
      Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/${ModuleName.ONLINE_ORDER}/paginated",
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
          List<OnlineOrder> onlineOrderList = [];

          for (var jsonData in jsonDataList) {
            List<OrderedFood> orderedFoodList = [];
            for (var foodJson in jsonData['orderFoodDetails']) {
              orderedFoodList.add(OrderedFood.fromJson(
                  foodJson,
                  await FetchImageService.fetchBlobData(_dio,
                      ApiImageConstants.getFoodImage(foodJson['photoId']))));
            }

            onlineOrderList
                .add(OnlineOrder.fromJson(jsonData, orderedFoodList));
          }

          int totalPages = response.data['data']['totalPages'];
          int totalElements = response.data['data']['totalElements'];
          int numberOfElements = response.data['data']['numberOfElements'];
          int currentPageIndex = response.data['data']['currentPageIndex'];

          return PaginatedData<OnlineOrder>(
            content: onlineOrderList,
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
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<List<SummaryData>> getOnlineOrderSummary(
      String fromTime, String toTIme) async {
    try {
      Response response = await _dio.get(
        "${ApiConstant.backendUrl}/${ModuleName.ONLINE_ORDER}/summary/$fromTime/$toTIme",
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          List<dynamic> jsonDataList = response.data['data'];
          List<SummaryData> summaryList = [];

          for (var jsonData in jsonDataList) {
            summaryList.add(SummaryData.fromJson(
                jsonData,
                await FetchImageService.fetchBlobData(_dio,
                    ApiImageConstants.getFoodImage(jsonData['photoId']))));
          }

          return summaryList;
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

  Future<void> deleteSingleOrderedFood(int id) async {
    try {
      Response response = await _dio.delete(
        "${ApiConstant.backendUrl}/${ModuleName.ONLINE_ORDER}/order-food/$id",
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
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

  Future<void> convertToOnsite(int id) async {
    try {
      Response response = await _dio.get(
        "${ApiConstant.backendUrl}/${ModuleName.ONLINE_ORDER}/make-onsite/$id",
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
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

  Future<void> deleteOrder(int id) async {
    try {
      Response response = await _dio.delete(
        "${ApiConstant.backendUrl}/${ModuleName.ONLINE_ORDER}/$id",
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
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
