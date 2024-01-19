import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fyp/config/auth/interceptors/dio_interceptor.dart';
import 'package:fyp/services/network/dio_service.dart';

import '../../constants/api-constant.dart';

class PaymentService{
  late final Dio _dio;
  PaymentService(){
    _dio = DioService.getDioConfig();
  }


  Future<void> verifyTransaction(Map<String, dynamic> payload) async {
    try {
      Response response = await _dio.post(
        "${ApiConstant.backendUrl}/khalti/verify",
        data: payload,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response);
      } else {
        throw Exception("Error when getting data");
      }
    } on DioException catch (e) {
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }
}