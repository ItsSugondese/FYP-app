class PaginatedData<T> {
  final List<T> content;
  final int totalPages;
  final int totalElements;
  final int numberOfElements;
  final int currentPageIndex;

  PaginatedData({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.numberOfElements,
    required this.currentPageIndex,
  });
}
