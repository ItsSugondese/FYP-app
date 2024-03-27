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
}
