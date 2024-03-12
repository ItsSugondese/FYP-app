class NotificationModel {
  String date;
  bool isSeen;
  String message;
  String? remark;

  NotificationModel({
    required this.date,
    required this.isSeen,
    required this.message,
    this.remark,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      date: json['date'],
      isSeen: json['isSeen'],
      message: json['message'],
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['isSeen'] = this.isSeen;
    data['message'] = this.message;
    data['remark'] = this.remark;
    return data;
  }
}
