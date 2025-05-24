class SendOtpSmsResponse {
  final String message;
  final String otp;

  SendOtpSmsResponse({required this.message, required this.otp});

  factory SendOtpSmsResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpSmsResponse(
      message: json['message'] ?? '',
      otp: json['data']?['otp'] ?? '',
    );
  }
}

class SendOtpSmsError {
  final String message;
  final String? error;

  SendOtpSmsError({required this.message, this.error});

  factory SendOtpSmsError.fromJson(Map<String, dynamic> json) {
    return SendOtpSmsError(
      message: json['message'] ?? '',
      error: json['error'],
    );
  }
}
