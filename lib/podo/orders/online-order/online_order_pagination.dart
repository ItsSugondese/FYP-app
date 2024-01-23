import 'package:flutter/material.dart';
import 'package:fyp/podo/pagination/pagination_request.dart';

class OnlineOrderPaginationPayload extends DefaultPagination {
  String? fromTime;
  String? toTime;

  OnlineOrderPaginationPayload({this.fromTime, this.toTime, row = 5, page = 1})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Include default values from the superclass

    json['fromTime'] = fromTime;
    json['toTime'] = toTime;

    // Remove null values from the map
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
