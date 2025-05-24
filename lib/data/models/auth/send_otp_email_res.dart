class SendOtpEmailResponse {
  final String message;
  final String otp;

  SendOtpEmailResponse({required this.message, required this.otp});

  factory SendOtpEmailResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpEmailResponse(
      message: json['message'] ?? '',
      otp: json['data']?['otp'] ?? '',
    );
  }
}

class SendOtpEmailError {
  final String message;
  final String? error;

  SendOtpEmailError({required this.message, this.error});

  factory SendOtpEmailError.fromJson(Map<String, dynamic> json) {
    return SendOtpEmailError(
      message: json['message'] ?? '',
      error: json['error'],
    );
  }
}
