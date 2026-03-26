// work_experience.dart
class WorkExperience {
  final String id;
  final String userId;
  final String jobTitle;
  final String company;
  final String startDate;
  final String endDate;
  final String description;

  WorkExperience({
    required this.id,
    required this.userId,
    required this.jobTitle,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      id:          json['_id']?.toString()          ?? '',
      userId:      json['userId']?.toString()       ?? '',
      jobTitle:    json['jobTitle']?.toString()     ?? '',
      company:     json['company']?.toString()      ?? '',
      startDate:   json['startDate']?.toString()    ?? '',
      endDate:     json['endDate']?.toString()      ?? '',
      description: json['description']?.toString()  ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'jobTitle':    jobTitle,
    'company':     company,
    'startDate':   startDate,
    'endDate':     endDate,
    'description': description,
  };

  // ✅ copyWith for local list updates after edit
  WorkExperience copyWith({
    String? jobTitle,
    String? company,
    String? startDate,
    String? endDate,
    String? description,
  }) {
    return WorkExperience(
      id:          id,
      userId:      userId,
      jobTitle:    jobTitle    ?? this.jobTitle,
      company:     company     ?? this.company,
      startDate:   startDate   ?? this.startDate,
      endDate:     endDate     ?? this.endDate,
      description: description ?? this.description,
    );
  }
}