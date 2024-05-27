import 'package:fyp/constants/pagination.dart';
import 'package:fyp/podo/pagination/pagination_request.dart';

class UserOrderHistoryPagination extends DefaultPagination {
  String? fromDate;
  String? toDate;
  bool today;
  UserOrderHistoryPagination(
      {this.fromDate,
      this.toDate,
      this.today = false,
      row = PaginationConstant.row,
      page = PaginationConstant.page})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Include default values from the superclass
    // Remove null values from the map
    json['fromDate'] = fromDate;
    json['toDate'] = toDate;
    json['today'] = today;
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
