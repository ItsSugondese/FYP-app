class ResponseData<T> {
  final bool status;
  final String message;
  final T data;

  ResponseData(
      {required this.status, required this.message, required this.data});
}
