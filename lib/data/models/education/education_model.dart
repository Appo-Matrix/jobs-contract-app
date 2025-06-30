// data/models/qualification/education_model.dart
class EducationModel {
  final String id;
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final String startDate;
  final String endDate;
  final String description;

  EducationModel({
    required this.id,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['_id'],
      institution: json['institution'],
      degree: json['degree'],
      fieldOfStudy: json['fieldOfStudy'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "institution": institution,
      "degree": degree,
      "fieldOfStudy": fieldOfStudy,
      "startDate": startDate,
      "endDate": endDate,
      "description": description,
    };
  }
}
