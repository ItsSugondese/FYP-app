class DefaultPagination {
  int row = 10;
  int page = 1;

  DefaultPagination({this.row = 10, this.page = 1});

  @override
  Map<String, dynamic> toJson() {
    return {
      'row': row,
      'page': page,
    };
  }
}
