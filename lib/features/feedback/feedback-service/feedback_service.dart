import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/service_helper.dart';
import 'package:fyp/model/feedback/feedback.dart';
import 'package:fyp/services/network/dio_service.dart';

class FeedbackService {
  late final Dio _dio;
  final String moduleName = ModuleName.FEEDBACK;

  FeedbackService() {
    _dio = DioService.getDioConfig();
  }

  Future<List<String>> getFeedbackStatus() async {
    try {
      Response response = await _dio
          .get("${ApiConstant.backendUrl}/${ModuleName.ENUMS}/$moduleName");

      if (response.statusCode == 200) {
        return List<String>.from(response.data['data']);
      } else {
        throw Exception("Error when getting data");
      }
    } on DioException catch (e) {
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<bool> saveFeedbacks(
      BuildContext context, Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/$moduleName",
        data: json.encode(map),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          ServiceHelper.showSuccessMessage(context, response.data['message']);
          return true;
        } else {
          ServiceHelper.showErrorSnackBar(context, response.data['message']);
          return false;
        }
      } else {
        ServiceHelper.showErrorSnackBar(context,
            MessageConstantsMethods.dataRetrieveError(MessageConstants.save));
        throw Exception("Error when getting data");
      }
    } on DioException catch (e) {
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<PaginatedData<FeedbackModel>> getFeedbacks(
      BuildContext context, Map<String, dynamic> map) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/$moduleName/paginated",
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
          List<FeedbackModel> feedbackList = [];

          for (var jsonData in jsonDataList) {
            feedbackList.add(FeedbackModel.fromJson(jsonData));
          }

          int totalPages = response.data['data']['totalPages'];
          int totalElements = response.data['data']['totalElements'];
          int numberOfElements = response.data['data']['numberOfElements'];
          int currentPageIndex = response.data['data']['currentPageIndex'];

          return PaginatedData<FeedbackModel>(
            content: feedbackList,
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
      throw (DioService.handleDioException(e)).message;
    }
  }
}
