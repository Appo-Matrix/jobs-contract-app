class UploadResumeResponse {
  final bool success;
  final String message;
  final ResumeData data;

  UploadResumeResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UploadResumeResponse.fromJson(Map<String, dynamic> json) {
    return UploadResumeResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ResumeData.fromJson(json['data'] ?? {}),
    );
  }
}

class ResumeData {
  final String resumePath;

  ResumeData({required this.resumePath});

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      resumePath: json['resumePath'] ?? '',
    );
  }
}
