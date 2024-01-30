class FeedbackPayload {
  String feedbackStatus;
  int foodId;
  String feedbacks;
  bool isAnonymous;

  FeedbackPayload({
    required this.feedbackStatus,
    required this.foodId,
    required this.feedbacks,
    required this.isAnonymous,
  });

  Map<String, dynamic> toJson() {
    return {
      'feedbackStatus': feedbackStatus,
      'foodId': foodId,
      'feedbacks': feedbacks,
      'isAnonymous': isAnonymous,
    };
  }
}
