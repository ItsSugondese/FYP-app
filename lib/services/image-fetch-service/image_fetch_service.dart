import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class FetchImageService {
  static Future<Uint8List> fetchBlobData(Dio dio, String url) async {
    final response = await dio.get(
        // "${ApiConstant.backendUrl}/food-menu/photo/${photoId}",
        url,
        options: Options(responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data);
    } else {
      throw Exception('Failed to fetch blob data');
    }
  }

  Future<Uint8List> loadImageAsUint8List(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    List<int> byteList = data.buffer.asUint8List();
    Uint8List uint8List = Uint8List.fromList(byteList);
    return uint8List;
  }
}
