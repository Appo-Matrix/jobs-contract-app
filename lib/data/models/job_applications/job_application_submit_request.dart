class JobApplicationSubmitRequest {
  final String jobId;
  final String coverLetter;

  JobApplicationSubmitRequest({
    required this.jobId,
    required this.coverLetter,
  });

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'coverLetter': coverLetter,
    };
  }
}
