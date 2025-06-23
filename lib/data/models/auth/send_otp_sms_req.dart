class SendOtpSmsRequest {
  final String phoneNumber;

  SendOtpSmsRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() => {'phoneNumber': phoneNumber};
}
