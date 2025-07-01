class UserPreferencesModel {
  final String id;
  final String userId;
  final List<String> jobTypes;
  final List<String> locations;
  final List<String> skills;

  UserPreferencesModel({
    required this.id,
    required this.userId,
    required this.jobTypes,
    required this.locations,
    required this.skills,
  });

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      jobTypes: List<String>.from(json['jobTypes'] ?? []),
      locations: List<String>.from(json['locations'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'jobTypes': jobTypes,
      'locations': locations,
      'skills': skills,
    };
  }
}
