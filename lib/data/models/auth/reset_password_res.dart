class ResetPasswordResponse {
  final String message;

  ResetPasswordResponse({required this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      message: json['message'] ?? '',
    );
  }
}

class ResetPasswordError {
  final String message;
  final String? error;

  ResetPasswordError({required this.message, this.error});

  factory ResetPasswordError.fromJson(Map<String, dynamic> json) {
    return ResetPasswordError(
      message: json['message'] ?? '',
      error: json['error'],
    );
  }
}