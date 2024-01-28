import 'package:fyp/podo/pagination/pagination_request.dart';

class StaffPaginationPayload extends DefaultPagination {
  StaffPaginationPayload({row = 5, page = 1}) : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Include default values from the superclass

    // Remove null values from the map
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
