class RegisterUserResponse {
  final String? message;
  final dynamic data;
  final bool? success;
  final String? token;

  RegisterUserResponse({
    this.message,
    this.data,
    this.success = true,
    this.token,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return RegisterUserResponse(
        message: json?['message'] ?? '',
        success: true,
        data: null,
        token: null,
      );
    }

    // Extract token from either root level or nested in data
    String? extractedToken = json['token']?.toString();

    if (extractedToken == null && json['data'] is Map) {
      final dataMap = json['data'] as Map<String, dynamic>;
      extractedToken = dataMap['token']?.toString();
    }

    return RegisterUserResponse(
      message: json['message']?.toString() ?? json['msg']?.toString() ?? 'Account created successfully',
      data: json['data'] ?? json['user'],
      success: json['success'] != null
          ? json['success'] as bool
          : (json['message'] != null ? true : false),
      token: extractedToken,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
    'success': success,
    'token': token,
  };

  @override
  String toString() => 'RegisterUserResponse(message: $message, success: $success, token: $token, data: $data)';
}

// Error class for registration
class RegisterUserError {
  final String error;
  final String? details;

  RegisterUserError({
    required this.error,
    this.details,
  });

  factory RegisterUserError.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return RegisterUserError(error: 'Unknown error');
    }

    return RegisterUserError(
      error: json['error']?.toString() ?? json['message']?.toString() ?? 'Unknown error',
      details: json['details']?.toString() ?? json['detail']?.toString(),
    );
  }
}