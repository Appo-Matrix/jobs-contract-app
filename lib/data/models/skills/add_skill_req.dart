class AddSkillRequest {
  final String userId;
  final String name;

  AddSkillRequest({required this.userId, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
    };
  }
}
