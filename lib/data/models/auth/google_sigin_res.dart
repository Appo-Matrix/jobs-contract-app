class GoogleSignInResponse {
  final bool success;
  final String message;
  final String accessToken;
  final GoogleUser user;

  GoogleSignInResponse({
    required this.success,
    required this.message,
    required this.accessToken,
    required this.user,
  });

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) {
    return GoogleSignInResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      accessToken: json['accessToken'] ?? '',
      user: GoogleUser.fromJson(json['user'] ?? {}),
    );
  }
}

class GoogleUser {
  final String id;
  final String email;
  final String firstName;
  final String profilePicture;

  GoogleUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.profilePicture,
  });

  factory GoogleUser.fromJson(Map<String, dynamic> json) {
    return GoogleUser(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }
}
