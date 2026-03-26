// user_education_model.dart
class UserEducationModel {
  final String id;
  final String userId;
  final String degree;
  final String institutionName;
  final String startDate;
  final String endDate;
  final bool isCurrentPosition;

  UserEducationModel({
    required this.id,
    required this.userId,
    required this.degree,
    required this.institutionName,
    required this.startDate,
    required this.endDate,
    required this.isCurrentPosition,
  });

  factory UserEducationModel.fromJson(Map<String, dynamic> json) {
    return UserEducationModel(
      id:                json['_id']?.toString()             ?? '',
      userId:            json['userId']?.toString()          ?? '',
      degree:            json['degree']?.toString()          ?? '',
      institutionName:   json['institutionName']?.toString() ?? '',
      startDate:         json['startDate']?.toString()       ?? '',
      endDate:           json['endDate']?.toString()         ?? '',
      isCurrentPosition: json['isCurrentPosition']           ?? false,
    );
  }
}