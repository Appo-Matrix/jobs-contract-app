class MatchedJobModel {
  final String id;
  final String title;
  final String jobCategory;
  final List<String> skillsRequired;
  final List<String> languagesRequired;
  final int experience;
  final String employmentType;
  final String jobLocation;
  final String createdAt;

  MatchedJobModel({
    required this.id,
    required this.title,
    required this.jobCategory,
    required this.skillsRequired,
    required this.languagesRequired,
    required this.experience,
    required this.employmentType,
    required this.jobLocation,
    required this.createdAt,
  });

  factory MatchedJobModel.fromJson(Map<String, dynamic> json) {
    return MatchedJobModel(
      id: json['_id'],
      title: json['title'],
      jobCategory: json['jobCategory'],
      skillsRequired: List<String>.from(json['skillsRequired']),
      languagesRequired: List<String>.from(json['languagesRequired']),
      experience: json['experience'],
      employmentType: json['employmentType'],
      jobLocation: json['jobLocation'],
      createdAt: json['createdAt'],
    );
  }
}
