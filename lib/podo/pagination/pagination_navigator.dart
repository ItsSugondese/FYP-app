class DefaultPaginationNavigator {
  int currentPage;
  int row;
  int? totalNoOfPage;
  int? totalNoOfElements;
  int? noOfElements;

  DefaultPaginationNavigator({
    required this.currentPage,
    required this.row,
    this.totalNoOfPage,
    this.totalNoOfElements,
    this.noOfElements,
  });

  factory DefaultPaginationNavigator.fromJson(Map<String, dynamic> json) {
    return DefaultPaginationNavigator(
      currentPage: json['currentPage'] as int,
      row: json['row'] as int,
      totalNoOfPage: json['totalNoOfpage'] as int?,
      totalNoOfElements: json['totalNoOfElements'] as int?,
      noOfElements: json['noOfElements'] as int?,
    );
  }
}
