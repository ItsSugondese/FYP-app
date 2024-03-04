import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/helper/data/error_response_data.dart';
import 'package:fyp/helper/data/response_data.dart';
import 'package:fyp/helper/widgets/service_helper.dart';
import 'package:fyp/services/storage/store_service.dart';

class DioInterceptor extends Interceptor {
  BuildContext? context;

  DioInterceptor({this.context});
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Store.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    ErrorResponseData? responseData;
    if (err.response != null && err.response!.data != null) {
      responseData = ErrorResponseData.fromJson(err.response!.data);
    }
    ServiceHelper.showErrorSnackBar(
        context!, responseData == null ? err.message! : responseData.message);

    throw DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      message: responseData == null ? err.message : responseData.message,
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data != null && response.data is Map) {
      ResponseData responseData = ResponseData.fromJson(response.data);
      if (responseData.crud == 'SAVE') {
        ServiceHelper.showSuccessMessage(context!, responseData.message);
      }
      // Proceed to the next interceptor or the response
    }
    super.onResponse(response, handler);
  }
}
