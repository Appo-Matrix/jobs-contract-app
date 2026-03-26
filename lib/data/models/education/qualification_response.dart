// qualification_response.dart
class QualificationResponse {
  final String message;
  final EducationData education;

  QualificationResponse({
    required this.message,
    required this.education,
  });

  factory QualificationResponse.fromJson(Map<String, dynamic> json) =>
      QualificationResponse(
        message:   json['message'],
        education: EducationData.fromJson(json['education']),
      );
}

class EducationData {
  final String id;
  final String userId;
  final String degree;
  final String institutionName;
  final String startDate;
  final String endDate;
  final bool isCurrentPosition;

  EducationData({
    required this.id,
    required this.userId,
    required this.degree,
    required this.institutionName,
    required this.startDate,
    required this.endDate,
    required this.isCurrentPosition,
  });

  factory EducationData.fromJson(Map<String, dynamic> json) => EducationData(
    id:                json['_id'],
    userId:            json['userId'],
    degree:            json['degree'],
    institutionName:   json['institutionName'],
    startDate:         json['startDate'],
    endDate:           json['endDate'],
    isCurrentPosition: json['isCurrentPosition'] ?? false,
  );
}