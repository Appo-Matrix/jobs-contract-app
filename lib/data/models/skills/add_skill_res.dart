// class AddSkillResponse {
//   final bool success;
//   final String message;
//   final SkillData? data;
//
//   AddSkillResponse({
//     required this.success,
//     required this.message,
//     this.data,
//   });
//
//   factory AddSkillResponse.fromJson(Map<String, dynamic> json) {
//     return AddSkillResponse(
//       success: json['success'],
//       message: json['message'],
//       data: json['data'] != null ? SkillData.fromJson(json['data']) : null,
//     );
//   }
// }
//
// class SkillData {
//   final String id;
//   final String userId;
//   final String name;
//
//   SkillData({
//     required this.id,
//     required this.userId,
//     required this.name,
//   });
//
//   factory SkillData.fromJson(Map<String, dynamic> json) {
//     return SkillData(
//       id: json['_id'],
//       userId: json['userId'],
//       name: json['name'],
//     );
//   }
// }



// add_skill_response.dart
class AddSkillResponse {
  final bool success;
  final String message;
  final SkillData? data;

  AddSkillResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory AddSkillResponse.fromJson(Map<String, dynamic> json) =>
      AddSkillResponse(
        success: json['success'] ?? false,
        message: json['message']?.toString() ?? '',
        data: json['data'] != null ? SkillData.fromJson(json['data']) : null,
      );
}

class SkillData {
  final String id;
  final String userId;
  final String name;
  final String createdAt;
  final String updatedAt;

  SkillData({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SkillData.fromJson(Map<String, dynamic> json) => SkillData(
    id:        json['_id']?.toString()        ?? '',
    userId:    json['userId']?.toString()     ?? '',
    name:      json['name']?.toString()       ?? '',
    createdAt: json['createdAt']?.toString()  ?? '',
    updatedAt: json['updatedAt']?.toString()  ?? '',
  );
}