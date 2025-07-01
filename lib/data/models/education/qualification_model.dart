// models/education/qualification_model.dart

class QualificationModel {
  final String userId;
  final String qualification;
  final String institution;
  final int yearOfCompletion;

  QualificationModel({
    required this.userId,
    required this.qualification,
    required this.institution,
    required this.yearOfCompletion,
  });

  factory QualificationModel.fromJson(Map<String, dynamic> json) {
    return QualificationModel(
      userId: json['userId'],
      qualification: json['qualification'],
      institution: json['institution'],
      yearOfCompletion: json['yearOfCompletion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'qualification': qualification,
      'institution': institution,
      'yearOfCompletion': yearOfCompletion,
    };
  }
}
