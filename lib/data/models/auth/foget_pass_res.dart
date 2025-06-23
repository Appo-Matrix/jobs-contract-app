class ForgotPasswordResponse {
  final String message;

  ForgotPasswordResponse({
    required this.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      message: json['message'],
    );
  }
}

class ForgotPasswordError {
  final String error;
  final String? details;

  ForgotPasswordError({
    required this.error,
    this.details,
  });

  factory ForgotPasswordError.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordError(
      error: json['error'],
      details: json['details'],
    );
  }
}