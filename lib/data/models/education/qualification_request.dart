class QualificationRequest {
  final String school;
  final String degree;
  final String fieldOfStudy;
  final String startDate;
  final String endDate;
  final String description;

  QualificationRequest({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'school': school,
    'degree': degree,
    'fieldOfStudy': fieldOfStudy,
    'startDate': startDate,
    'endDate': endDate,
    'description': description,
  };
}
