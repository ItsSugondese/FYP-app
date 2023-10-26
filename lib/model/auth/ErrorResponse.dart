

class ErrorModel{
  String? message;
  int? code;

  ErrorModel({this.message, this.code});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        message : json['message'],
        code : json['httpCode']
    );
  }

  Map<String, dynamic> toJson(decode) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}