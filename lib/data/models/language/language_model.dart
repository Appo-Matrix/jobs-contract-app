class LanguageModel {
  final String id;
  final String name;
  final String proficiency;
  final String userId;

  LanguageModel({
    required this.id,
    required this.name,
    required this.proficiency,
    required this.userId,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      proficiency: json['proficiency'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'proficiency': proficiency,
      'userId': userId,
    };
  }
}
