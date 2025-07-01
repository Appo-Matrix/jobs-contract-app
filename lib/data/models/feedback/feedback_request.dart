class FeedbackRequest {
  final String givenTo;
  final String jobId;
  final int rating;
  final List<String> likes;
  final List<String> experience;
  final String review;

  FeedbackRequest({
    required this.givenTo,
    required this.jobId,
    required this.rating,
    required this.likes,
    required this.experience,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    return {
      'givenTo': givenTo,
      'jobId': jobId,
      'rating': rating,
      'likes': likes,
      'experience': experience,
      'review': review,
    };
  }
}
