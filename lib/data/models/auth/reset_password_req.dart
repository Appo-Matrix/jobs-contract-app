class ResetPasswordRequest {
  final String token;
  final String email;
  final String newPassword;

  ResetPasswordRequest({
    required this.token,
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'email': email,
    'newPassword': newPassword,
  };
}