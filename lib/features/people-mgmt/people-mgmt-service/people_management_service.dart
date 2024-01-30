import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/service_helper.dart';
import 'package:fyp/model/people/disable_history.dart';
import 'package:fyp/services/network/dio_service.dart';

class PeopleManagementService {
  late final Dio _dio;

  PeopleManagementService() {
    _dio = DioService.getDioConfig();
  }

  Future<PaginatedData<DisableHistory>> getDisableHistory(
      BuildContext context, Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/${ModuleName.USER}/disable/pageable",
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
          List<DisableHistory> disableDataList = [];

          for (var jsonData in jsonDataList) {
            disableDataList.add(DisableHistory.fromJson(jsonData));
          }

          int totalPages = response.data['data']['totalPages'];
          int totalElements = response.data['data']['totalElements'];
          int numberOfElements = response.data['data']['numberOfElements'];
          int currentPageIndex = response.data['data']['currentPageIndex'];

          return PaginatedData<DisableHistory>(
            content: disableDataList,
            totalPages: totalPages,
            totalElements: totalElements,
            numberOfElements: numberOfElements,
            currentPageIndex: currentPageIndex,
          );
        } else {
          ServiceHelper.showErrorSnackBar(context, response.data['message']);
          throw Exception(
              MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
        }
      } else {
        ServiceHelper.showErrorSnackBar(context,
            MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
        throw Exception(
            MessageConstantsMethods.dataRetrieveError(MessageConstants.get));
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
