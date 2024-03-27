import 'package:fyp/constants/pagination.dart';
import 'package:fyp/podo/pagination/pagination_request.dart';

class OrderHistoryManagementPagination extends DefaultPagination {
  String? fromDate;
  String? toDate;
  String? name;
  String? payStatus;

  OrderHistoryManagementPagination(
      {this.fromDate,
      this.toDate,
      this.name,
      this.payStatus,
      row = PaginationConstant.row,
      page = PaginationConstant.page})
      : super(page: page, row: row);

  factory OrderHistoryManagementPagination.fromJson(Map<String, dynamic> json) {
    return OrderHistoryManagementPagination(
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      name: json['name'],
      payStatus: json['payStatus'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();
    json['fromDate'] = fromDate;
    json['toDate'] = toDate;
    json['name'] = name;
    json['payStatus'] = payStatus;
    json.removeWhere((key, value) => value == null);

    return json;
  }
}
