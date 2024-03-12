class ViewFeedback {
  final int id;
  final String feedbacks;
  final String feedbackStatus;
  final bool isAnonymous;

  ViewFeedback(
      {required this.id,
      required this.feedbacks,
      required this.feedbackStatus,
      required this.isAnonymous});

  factory ViewFeedback.fromJson(Map<String, dynamic> json) {
    return ViewFeedback(
      id: json['id'],
      feedbacks: json['feedbacks'],
      feedbackStatus: json['feedbackStatus'],
      isAnonymous: json['isAnonymous'],
    );
  }
}
