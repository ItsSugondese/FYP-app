import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/service_helper.dart';
import 'package:fyp/model/people/staff.dart';
import 'package:fyp/services/image-fetch-service/image_fetch_service.dart';
import 'package:fyp/services/network/dio_service.dart';

class StaffManagementService {
  late final Dio _dio;

  StaffManagementService() {
    _dio = DioService.getDioConfig();
  }

  Future<PaginatedData<Staff>> getAllStaff(
      BuildContext context, Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/${ModuleName.STAFF}/paginated",
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
          List<Staff> staffList = [];

          for (var jsonData in jsonDataList) {
            int id = jsonData['id'];
            staffList.add(Staff.fromJson(
                jsonData,
                await FetchImageService.fetchBlobData(_dio,
                    "${ApiConstant.backendUrl}/${ModuleName.STAFF}/photo/$id")));
          }

          int totalPages = response.data['data']['totalPages'];
          int totalElements = response.data['data']['totalElements'];
          int numberOfElements = response.data['data']['numberOfElements'];
          int currentPageIndex = response.data['data']['currentPageIndex'];

          return PaginatedData<Staff>(
            content: staffList,
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

  Future<Staff> getSingleStaff(BuildContext context, int id) async {
    try {
      Response response =
          await _dio.get("${ApiConstant.backendUrl}/${ModuleName.USER}/$id");

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          dynamic jsonData = response.data['data'];
          int id = jsonData['id'];
          Staff staff = Staff.fromJson(
              jsonData,
              await FetchImageService.fetchBlobData(_dio,
                  "${ApiConstant.backendUrl}/${ModuleName.STAFF}/photo/$id"));
          // fetchBlobData(jsonData['id']));

          return staff;
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
}
