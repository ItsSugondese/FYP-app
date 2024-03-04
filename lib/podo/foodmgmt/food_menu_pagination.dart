import 'package:fyp/podo/pagination/pagination_request.dart';

class FoodMenuPaginationPayload extends DefaultPagination {
  String? foodType;
  String? filter;
  String? name;
  FoodMenuPaginationPayload(
      {this.foodType, this.filter, this.name, row = 5, page = 1})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json =
        super.toJson(); // Include default values from the superclass

    json['foodType'] = foodType;
    json['filter'] = filter;
    json['name'] = name;

    // Remove null values from the map
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
