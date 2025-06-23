class UpdateUserProfileResponse {
  final String id;
  final String name;
  final String email;
  final String profile;

  UpdateUserProfileResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
  });

  factory UpdateUserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserProfileResponse(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      profile: json['profile'],
    );
  }
}