class ErrorResponseData {
  final int status;
  final int httpCode;
  final String message;
  final List<String> errors;

  ErrorResponseData({
    required this.status,
    required this.httpCode,
    required this.message,
    required this.errors,
  });

  factory ErrorResponseData.fromJson(Map<String, dynamic> json) {
    return ErrorResponseData(
      status: json['status'] ?? 0,
      httpCode: json['httpCode'] ?? 0,
      message: json['message'] ?? '',
      errors: (json['errors'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
