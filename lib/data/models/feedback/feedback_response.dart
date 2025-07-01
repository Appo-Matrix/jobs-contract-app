class FeedbackResponse {
  final String id;
  final String givenBy;
  final String givenTo;
  final String jobId;
  final int rating;
  final List<String> likes;
  final List<String> experience;
  final String review;
  final String createdAt;
  final String updatedAt;

  FeedbackResponse({
    required this.id,
    required this.givenBy,
    required this.givenTo,
    required this.jobId,
    required this.rating,
    required this.likes,
    required this.experience,
    required this.review,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    return FeedbackResponse(
      id: json['_id'],
      givenBy: json['givenBy'],
      givenTo: json['givenTo'],
      jobId: json['jobId'],
      rating: json['rating'],
      likes: List<String>.from(json['likes']),
      experience: List<String>.from(json['experience']),
      review: json['review'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
