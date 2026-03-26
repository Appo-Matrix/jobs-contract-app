class LanguageModel {
  final String? id;
  final String name;
  final String proficiency;
  final String? userId;

  LanguageModel({
    this.id,
    required this.name,
    required this.proficiency,
    this.userId,
  });

  // Valid proficiency values per API
  static const List<String> proficiencyLevels = [
    'basic',
    'conversational',
    'fluent',
    'native',
  ];

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      proficiency: json['proficiency'] ?? '',
      userId: json['userId'],
    );
  }

  // API only needs name and proficiency — do NOT send userId
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'proficiency': proficiency,
    };
  }

  @override
  String toString() =>
      'LanguageModel(id: $id, name: $name, proficiency: $proficiency)';
}