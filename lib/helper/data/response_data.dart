class ResponseData {
  final int status;
  final String message;
  final String crud;

  ResponseData({
    required this.status,
    required this.message,
    required this.crud,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      status: json['status'],
      message: json['message'],
      crud: json['crud'],
    );
  }
}
