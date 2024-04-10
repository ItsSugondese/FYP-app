import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/api_image_constant.dart';
import 'package:fyp/constants/message_constants.dart';
import 'package:fyp/constants/message_constants_methods.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/services/image-fetch-service/image_fetch_service.dart';
import 'package:fyp/services/network/dio_service.dart';

class UserProfileService {
  late final Dio _dio;

  UserProfileService(BuildContext context) {
    _dio = DioService.getDioConfigWithContext(context);
  }

  Future<User> getSingleUser() async {
    try {
      Response response = await _dio
          .get("${ApiConstant.backendUrl}/${ModuleName.USER_PROFILE}");

      if (response.statusCode == 200) {
        if (response.data['status'] == 1) {
          dynamic jsonData = response.data['data'];
          Uint8List? image;
          if (jsonData['profileUrl'] != null) {
            image = await FetchImageService.fetchBlobData(
                _dio, ApiImageConstants.getFoodImage(jsonData['id']));
          }
          User user = User.fromJson(jsonData, image);

          return user;
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
