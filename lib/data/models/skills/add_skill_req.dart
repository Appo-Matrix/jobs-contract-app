class AddSkillRequest {
  final String name;

  AddSkillRequest({ required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
