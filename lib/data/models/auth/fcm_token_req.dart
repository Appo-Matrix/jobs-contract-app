class FcmTokenRequest {
  final String email;
  final String fcmToken;

  FcmTokenRequest({
    required this.email,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fcmToken': fcmToken,
    };
  }
}
