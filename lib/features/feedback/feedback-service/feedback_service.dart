import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/api_image_constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/feedback/feedback.dart';
import 'package:fyp/podo/feedback/food_menu_for_feedback.dart';
import 'package:fyp/podo/feedback/view_feedback.dart';
import 'package:fyp/services/image-fetch-service/image_fetch_service.dart';
import 'package:fyp/services/network/dio_service.dart';

class FeedbackService {
  late final Dio _dio;
  final String moduleName = ModuleName.FEEDBACK;

  FeedbackService(BuildContext context) {
    _dio = DioService.getDioConfigWithContext(context);
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

  Future<bool> saveFeedbacks(Map<String, dynamic> map) async {
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
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception("Error when getting data");
      }
    } on DioException catch (e) {
      throw (DioService.handleDioException(e)).message;
    }
  }

  Future<PaginatedData<FeedbackModel>> getFeedbacks(
      Map<String, dynamic> map) async {
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

  Future<List<FoodMenuForFeedback>> getMenusToFeedback() async {
    try {
      Response response = await _dio
          .get("${ApiConstant.backendUrl}/$moduleName/available-to-give");

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          List<dynamic> jsonDataList = response.data['data'];
          List<FoodMenuForFeedback> feedbackList = [];

          for (var jsonData in jsonDataList) {
            feedbackList.add(FoodMenuForFeedback.fromJson(
                jsonData,
                await FetchImageService.fetchBlobData(_dio,
                    ApiImageConstants.getFoodImage(jsonData['pictureId']))));
          }

          return feedbackList;
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

  Future<ViewFeedback> viewFeedbackGiven(int foodId) async {
    try {
      Response response = await _dio.get(
          "${ApiConstant.backendUrl}/$moduleName/view-feedback-user/$foodId");

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          return ViewFeedback.fromJson(response.data['data']);
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

  Future<bool> deleteFeedback(int id) async {
    try {
      Response response =
          await _dio.delete("${ApiConstant.backendUrl}/$moduleName/$id");

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          return true;
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
