import 'package:fyp/constants/pagination.dart';
import 'package:fyp/podo/pagination/pagination_request.dart';

class ManageUserPaymentPagination extends DefaultPagination {
  List<String> userType;
  String? name;
  String? payStatus;

  ManageUserPaymentPagination(
      {required this.userType,
      this.name,
      this.payStatus,
      row = PaginationConstant.row,
      page = PaginationConstant.page})
      : super(page: page, row: row);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['userType'] = userType;
    data['name'] = name;
    data['payStatus'] = payStatus;
    return data;
  }
}
