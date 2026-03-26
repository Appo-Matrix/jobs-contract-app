class ExperienceRequest {
  final String jobTitle;
  final String company;
  final String startDate;
  final String endDate;
  final String description;

  ExperienceRequest({
    required this.jobTitle,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    "jobTitle": jobTitle,
    "company": company,
    "startDate": startDate,
    "endDate": endDate,
    "description": description,
  };
}
