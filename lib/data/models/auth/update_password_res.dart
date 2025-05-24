class UpdatePasswordResponse {
  final String message;

  UpdatePasswordResponse({required this.message});

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordResponse(message: json['message'] ?? '');
  }
}

class UpdatePasswordError {
  final String error;
  final String? details;

  UpdatePasswordError({required this.error, this.details});

  factory UpdatePasswordError.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordError(
      error: json['error'] ?? '',
      details: json['details'],
    );
  }
}
