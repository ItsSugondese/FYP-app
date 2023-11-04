import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../constants/api-constant.dart';
import '../../../../model/foodmgmt/Food_menu_item_with_image.dart';
import '../../../../model/foodmgmt/food_menu.dart';
import '../../../../services/network/dio_service.dart';

class HomepageService{
  late final Dio _dio;

  HomepageService(){
    _dio = DioService.getDioConfig();
  }

  Future<List<FoodMenuItemWithImage>> getFoodMenusWithImages() async {
    try {
      Response response = await _dio.get("${ApiConstant.backendUrl}/food-menu?type=TODAY");

      if (response.statusCode == 200) {
        List<dynamic> jsonDataList = response.data['data'];
        List<FoodMenuItemWithImage> menusWithImages = [];

        for (var jsonData in jsonDataList) {
          FoodMenu foodMenu = FoodMenu.fromJson(jsonData);
          Uint8List? image = await fetchBlobData(foodMenu.photoId);
          menusWithImages.add(FoodMenuItemWithImage(foodMenu, image));
        }

        return menusWithImages;
      } else {
        throw Exception("Error when getting data");
      }
    } on DioException catch (e) {
      print(e.toString());
      print((DioService.handleDioException(e)).message);
      throw (DioService.handleDioException(e)).message;
    }
  }


  Future<Uint8List?> fetchBlobData(int? photoId) async {
    if(photoId == null){
      return null;
    }

    final response = await _dio.get("${ApiConstant.backendUrl}/food-menu/photo/${photoId}", options: Options(responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data);
    } else {
      throw Exception('Failed to fetch blob data');
    }
  }

}