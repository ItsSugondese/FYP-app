import 'package:fyp/podo/pagination/pagination_request.dart';

class NotificationPaginationPayload extends DefaultPagination {
  NotificationPaginationPayload({row = 10, page = 1})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();

    // Remove null values from the map
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
