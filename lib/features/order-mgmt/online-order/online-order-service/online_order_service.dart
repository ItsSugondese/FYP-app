import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/widgets/service_helper.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/model/order/ordered_food.dart';
import 'package:fyp/services/network/dio_service.dart';
import 'package:flutter/material.dart';

class FoodManagementService {
  late final Dio _dio;

  FoodManagementService() {
    _dio = DioService.getDioConfig();
  }

  Future<List<OrderedFood>> getOnlineOrder(Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
          "${ApiConstant.backendUrl}${ModuleName.ONLINE_ORDER}/paginated");

      if (response.statusCode == 200) {
        List<dynamic> jsonDataList = response.data['data'];
        List<FoodMenu> menusWithImages = [];

        for (var jsonData in jsonDataList) {
          Uint8List image = await fetchBlobData(jsonData['photoId']);
          FoodMenu foodMenu = FoodMenu.fromJson(jsonData, image);
          menusWithImages.add(foodMenu);
        }

        return menusWithImages;
      } else {
        throw Exception("Error when getting data");
      }
    } on DioException catch (e) {
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<Uint8List> fetchBlobData(int photoId) async {
    final response = await _dio.get(
        "${ApiConstant.backendUrl}/food-menu/photo/${photoId}",
        options: Options(responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data);
    } else {
      throw Exception('Failed to fetch blob data');
    }
  }

  Future<Uint8List> loadImageAsUint8List(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    List<int> byteList = data.buffer.asUint8List();
    Uint8List uint8List = Uint8List.fromList(byteList);
    return uint8List;
  }
}
