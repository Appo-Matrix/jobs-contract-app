class RealEstatePreferencesModel {
  final String userId;
  final String jobType;
  final String location;
  final String category;
  final String salaryRange;

  RealEstatePreferencesModel({
    required this.userId,
    required this.jobType,
    required this.location,
    required this.category,
    required this.salaryRange,
  });

  factory RealEstatePreferencesModel.fromJson(Map<String, dynamic> json) {
    return RealEstatePreferencesModel(
      userId: json['userId'] ?? '',
      jobType: json['jobType'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      salaryRange: json['salaryRange'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'jobType': jobType,
      'location': location,
      'category': category,
      'salaryRange': salaryRange,
    };
  }
}
