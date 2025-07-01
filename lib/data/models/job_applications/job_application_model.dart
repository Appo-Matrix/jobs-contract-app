class JobApplicationModel {
  final String id;
  final String userId;
  final String jobId;
  final String status;
  final String? coverLetter;
  final String? createdAt;
  final String? updatedAt;

  JobApplicationModel({
    required this.id,
    required this.userId,
    required this.jobId,
    required this.status,
    this.coverLetter,
    this.createdAt,
    this.updatedAt,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      jobId: json['jobId'] ?? '',
      status: json['status'] ?? '',
      coverLetter: json['coverLetter'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'jobId': jobId,
      'status': status,
      'coverLetter': coverLetter,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
