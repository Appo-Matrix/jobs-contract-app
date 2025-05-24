class SendOtpEmailRequest {
  final String email;

  SendOtpEmailRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}
