
import 'package:dio/dio.dart';
import 'package:fyp/services/network/dio_service.dart';

import '../../constants/api-constant.dart';

class TestService{
  late final Dio _dio;

  TestService(){
    _dio = DioService.getDioConfig();
  }
  Future<String>? getFilter() async{
    try {
      Response response = await _dio.get(
          "${ApiConstant.backendUrl}/filter");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return "Fuck you dsay to me";
      }
    }on DioException catch(e){
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }
}