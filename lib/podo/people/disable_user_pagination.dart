import 'package:fyp/constants/pagination.dart';
import 'package:fyp/podo/pagination/pagination_request.dart';

class DisableUserHistoryPagination extends DefaultPagination {
  int userId;
  DisableUserHistoryPagination(
      {required this.userId,
      row = PaginationConstant.row,
      page = PaginationConstant.page})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Include default values from the superclass
    // Remove null values from the map
    json['userId'] = userId;
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
