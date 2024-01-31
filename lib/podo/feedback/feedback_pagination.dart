import 'package:fyp/constants/pagination.dart';
import 'package:fyp/podo/pagination/pagination_request.dart';

class FeedbackPagination extends DefaultPagination {
  int foodId;
  FeedbackPagination(
      {required this.foodId,
      row = PaginationConstant.row,
      page = PaginationConstant.page})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Include default values from the superclass
    // Remove null values from the map
    json['foodId'] = foodId;
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
