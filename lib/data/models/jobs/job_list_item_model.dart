class JobListItemModel {
  final String id;
  final String jobTitle;
  final String description;
  final String createdAt;
  final String updatedAt;

  JobListItemModel({
    required this.id,
    required this.jobTitle,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobListItemModel.fromJson(Map<String, dynamic> json) {
    return JobListItemModel(
      id: json['_id'],
      jobTitle: json['jobTitle'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
