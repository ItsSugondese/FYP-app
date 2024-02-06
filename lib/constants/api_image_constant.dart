import 'package:fyp/constants/api-constant.dart';

class ApiImageConstants {
  static String getFoodImage(int photoId) {
    return "${ApiConstant.backendUrl}/food-menu/photo/${photoId}";
  }
}
