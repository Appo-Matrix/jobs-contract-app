class PreferenceUserModel {
  final String id;
  final String name;
  final String email;
  final List<String> jobPreferences;

  PreferenceUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.jobPreferences,
  });

  factory PreferenceUserModel.fromJson(Map<String, dynamic> json) {
    return PreferenceUserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      jobPreferences: List<String>.from(json['jobPreferences'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'jobPreferences': jobPreferences,
    };
  }
}
