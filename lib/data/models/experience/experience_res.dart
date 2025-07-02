class ExperienceResponse {
  final String id;
  final String userId;
  final String jobTitle;
  final String company;
  final String startDate;
  final String endDate;
  final String description;

  ExperienceResponse({
    required this.id,
    required this.userId,
    required this.jobTitle,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory ExperienceResponse.fromJson(Map<String, dynamic> json) {
    return ExperienceResponse(
      id: json['_id'],
      userId: json['userId'],
      jobTitle: json['jobTitle'],
      company: json['company'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      description: json['description'],
    );
  }
}
