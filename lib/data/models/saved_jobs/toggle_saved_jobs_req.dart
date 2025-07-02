class ToggleSaveJobRequest {
  final String jobId;
  final String userId;

  ToggleSaveJobRequest({
    required this.jobId,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    'jobId': jobId,
    'userId': userId,
  };
}
