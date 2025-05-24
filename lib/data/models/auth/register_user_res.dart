class RegisterUserResponse {
  final String message;

  RegisterUserResponse({required this.message});

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponse(
      message: json['message'] ?? '',
    );
  }
}

class RegisterUserError {
  final String error;

  RegisterUserError({required this.error});

  factory RegisterUserError.fromJson(Map<String, dynamic> json) {
    return RegisterUserError(
      error: json['error'] ?? 'Unknown error',
    );
  }
}
