class PaginatedData<T> {
  final List<T> dataList;
  final int totalPages;
  final int totalElements;
  final int numberOfElements;
  final int currentPageIndex;

  PaginatedData({
    required this.dataList,
    required this.totalPages,
    required this.totalElements,
    required this.numberOfElements,
    required this.currentPageIndex,
  });
}
