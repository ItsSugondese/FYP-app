class PayFilterMap {
  static final Map<String, dynamic> payfilter = {
    'All': null,
    'Paid': 'PAID',
    'Unpaid': 'UNPAID',
    'Partial Paid': 'PARTIAL_PAID',
  };
  static final Map<String, dynamic> payfilterWithoutPartial = {
    'All': null,
    'Paid': 'PAID',
    'Unpaid': 'UNPAID',
  };

  static final Map<String, dynamic> orderManagementFilter = {
    'Pending': 'PENDING',
    'Viewed': 'VIEWED',
    'Delivered': 'DELIVERED',
    'Paid': 'PAID',
    'Canceled': 'CANCELED'
  };
}
