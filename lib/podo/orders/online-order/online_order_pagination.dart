import 'package:fyp/podo/pagination/pagination_request.dart';

class OnlineOrderPaginationPayload extends DefaultPagination {
  String? fromTime;
  String? toTime;
  int minDifference;
  String? name;

  OnlineOrderPaginationPayload(
      {this.fromTime,
      this.toTime,
      required this.minDifference,
      this.name,
      row = 5,
      page = 1})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Include default values from the superclass

    json['fromTime'] = fromTime;
    json['toTime'] = toTime;
    json['minDifference'] = minDifference;
    json['name'] = name;

    // Remove null values from the map
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
