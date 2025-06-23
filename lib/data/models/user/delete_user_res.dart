
class DeleteUserResponse {
  final bool success;
  final String message;

  DeleteUserResponse({
    required this.success,
    required this.message,
  });

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUserResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
