class DisableHistory {
  int id;
  String date;
  bool isDisabled;
  String? remarks;

  DisableHistory({
    required this.id,
    required this.date,
    required this.isDisabled,
    this.remarks,
  });

  factory DisableHistory.fromJson(Map<String, dynamic> json) {
    return DisableHistory(
      id: json['id'],
      date: json['date'],
      isDisabled: json['isDisabled'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'isDisabled': isDisabled,
      'remarks': remarks,
    };
  }
}
