// models/job/job_report_model.dart

class JobReportModel {
  final String jobId;
  final String userId;
  final String reason;
  final String description;

  JobReportModel({
    required this.jobId,
    required this.userId,
    required this.reason,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'jobId': jobId,
    'userId': userId,
    'reason': reason,
    'description': description,
  };

  factory JobReportModel.fromJson(Map<String, dynamic> json) {
    return JobReportModel(
      jobId: json['jobId'],
      userId: json['userId'],
      reason: json['reason'],
      description: json['description'],
    );
  }
}
