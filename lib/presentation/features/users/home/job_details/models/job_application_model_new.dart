class JobApplicationModelNew {
  final String jobId;
  final String coverLetter;

  JobApplicationModelNew({
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

class JobApplicationResponseModelNew {
  final bool success;
  final String? message;

  JobApplicationResponseModelNew({
    required this.success,
    this.message,
  });

  factory JobApplicationResponseModelNew.fromJson(Map<String, dynamic> json) {
    return JobApplicationResponseModelNew(
      success: json['success'] ?? true,
      message: json['message'],
    );
  }
}