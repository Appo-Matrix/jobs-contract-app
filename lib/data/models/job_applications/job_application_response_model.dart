class JobApplicationResponseModel {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  JobApplicationResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory JobApplicationResponseModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? {},
    );
  }
}
