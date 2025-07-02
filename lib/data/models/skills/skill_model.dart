class SkillModel {
  final String id;
  final String userId;
  final String name;

  SkillModel({
    required this.id,
    required this.userId,
    required this.name,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
    );
  }
}
