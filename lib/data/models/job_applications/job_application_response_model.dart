// ─── Request Model ───────────────────────────────────────────────

// ─── Response Data Model ────────────────────────────────────────
class JobApplicationData {
  final String id;
  final String jobId;
  final String userId;
  final String coverLetter;
  final double estimatedServiceCost;
  final String estimatedCompletionTime;
  final String createdAt;
  final String updatedAt;
  final int v;

  JobApplicationData({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.coverLetter,
    required this.estimatedServiceCost,
    required this.estimatedCompletionTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory JobApplicationData.fromJson(Map<String, dynamic> json) {
    return JobApplicationData(
      id: json['_id'] ?? '',
      jobId: json['jobId'] ?? '',
      userId: json['userId'] ?? '',
      coverLetter: json['coverLetter'] ?? '',
      estimatedServiceCost: (json['estimatedServiceCost'] as num?)?.toDouble() ?? 0.0,
      estimatedCompletionTime: json['estimatedCompletionTime'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}

// ─── Response Model ─────────────────────────────────────────────
class JobApplicationResponseModel {
  final bool success;
  final String message;
  final JobApplicationData? data;

  JobApplicationResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory JobApplicationResponseModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? JobApplicationData.fromJson(json['data'])
          : null,
    );
  }
}