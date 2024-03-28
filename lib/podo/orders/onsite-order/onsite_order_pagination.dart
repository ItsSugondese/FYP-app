import 'package:fyp/podo/pagination/pagination_request.dart';

class OnsiteOrderPaginationPayload extends DefaultPagination {
  int minuteRange;
  String onsiteOrderFilter;
  String? name;

  OnsiteOrderPaginationPayload({
    required this.minuteRange,
    required this.onsiteOrderFilter,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minuteRange'] = minuteRange;
    data['onsiteOrderFilter'] = onsiteOrderFilter;
    data['name'] = name;
    return data;
  }
}
