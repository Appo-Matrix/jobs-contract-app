class DeleteResumeResponse {
  final bool success;
  final String message;
  final String? error;

  DeleteResumeResponse({
    required this.success,
    required this.message,
    this.error,
  });

  factory DeleteResumeResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResumeResponse(
      success: json['success'],
      message: json['message'],
      error: json['error'],
    );
  }
}
