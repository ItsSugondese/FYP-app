import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/api-constant.dart';
import 'package:fyp/constants/module_name.dart';
import 'package:fyp/helper/widgets/service_helper.dart';
import 'package:fyp/services/network/dio_service.dart';
import 'package:http/http.dart' as http;

class TemporaryAttachmentsService {
  late final Dio _dio;

  TemporaryAttachmentsService() {
    _dio = DioService.getDioConfig();
  }
  Future<int> getAttachmentId(BuildContext context) async {
    try {
      var dio = Dio();
      var url = "${ApiConstant.backendUrl}/${ModuleName.TEMPORARY_ATTACHMENTS}";

      var response = await dio.get(url);

      final Map<String, dynamic> responseBody = response.data;

      if (responseBody["status"] == 1) {
        List<dynamic> jsonDataList = responseBody['data'];
        return jsonDataList[0];
      } else {
        ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
        throw Exception("Hello");
      }
    } catch (error) {
      ServiceHelper.showErrorSnackBar(
          context, 'Error fetching attachment ID: $error');
      throw Exception('Error fetching attachment ID: $error');
    }
  }

  // Future<int> uploadFile(File file, BuildContext context) async {
  //   //POST operation starts from here
  //   var url = Uri.parse(
  //       "${ApiConstant.backendUrl}/${ModuleName.TEMPORARY_ATTACHMENTS}");

  //   // Create a multipart request
  //   var request = http.MultipartRequest('POST', url);

  //   // Add the file to the request
  //   var fileStream = http.ByteStream(file.openRead());
  //   var length = await file.length();
  //   var multipartFile = http.MultipartFile('attachments', fileStream, length,
  //       filename: file.path);

  //   // Add the file to the request
  //   request.files.add(multipartFile);

  //   try {
  //     // Send the request
  //     var streamedResponse = await request.send();

  //     // Convert the StreamedResponse to a regular Response
  //     var response = await http.Response.fromStream(streamedResponse);
  //     final Map<String, dynamic> responseBody = json.decode(response.body);

  //     if (responseBody["status"] == 1) {
  //       List<dynamic> jsonDataList = responseBody['data'];

  //       return jsonDataList[0];
  //     } else {
  //       ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
  //       throw Exception("Hello");
  //     }
  //   } catch (error) {
  //     // Handle the exception
  //     ServiceHelper.showErrorSnackBar(context, 'Error uploading file: $error');
  //     throw Exception('Error uploading file: $error');
  //   }
  // }

  Future<int> uploadFile(File file, BuildContext context) async {
    try {
      var url = "${ApiConstant.backendUrl}/${ModuleName.TEMPORARY_ATTACHMENTS}";

      var formData = FormData.fromMap({
        'attachments': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      var response = await _dio.post(
        url,
        data: formData,
      );

      final Map<String, dynamic> responseBody = response.data;

      if (responseBody["status"] == 1) {
        List<dynamic> jsonDataList = responseBody['data'];
        return jsonDataList[0];
      } else {
        ServiceHelper.showErrorSnackBar(context, responseBody["message"]);
        throw Exception("Hello");
      }
    } catch (error) {
      ServiceHelper.showErrorSnackBar(context, 'Error uploading file: $error');
      throw Exception('Error uploading file: $error');
    }
  }
}
