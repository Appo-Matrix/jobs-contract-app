class SkillModel {
  final String? id;
  final String? userId;
  final String name;

  SkillModel({this.id, this.userId, required this.name});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['_id'] ?? json['id'],
      userId: json['userId'],
      name: json['name'] ?? '',
    );
  }

  @override
  String toString() => 'SkillModel(id: $id, name: $name)';
}