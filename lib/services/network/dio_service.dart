import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/auth/interceptors/dio_interceptor.dart';

import '../../model/auth/ErrorResponse.dart';

class DioService {
  static getDioConfig() {
    Dio dio = Dio();
    dio.interceptors.add(DioInterceptor());
    return dio;
  }

  static getDioConfigWithContext(BuildContext context) {
    Dio dio = Dio();
    dio.interceptors.add(DioInterceptor(context: context));
    return dio;
  }

  static handleDioException(DioException e) {
    return ErrorModel.fromJson(e.response?.data);
  }
}
