class FeedbackModel {
  final int id;
  final String feedbacks;
  final String feedbackStatus;
  final bool isAnonymous;
  final String username;
  final String userProfileUrl;
  final String date;

  FeedbackModel({
    required this.id,
    required this.feedbacks,
    required this.feedbackStatus,
    required this.isAnonymous,
    required this.username,
    required this.userProfileUrl,
    required this.date,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      feedbacks: json['feedbacks'],
      feedbackStatus: json['feedbackStatus'],
      isAnonymous: json['isAnonymous'],
      username: json['username'],
      userProfileUrl:
          json['userProfileUrl'], // Assuming userProfileUrl can be nullable
      date: json['date'],
    );
  }
}
