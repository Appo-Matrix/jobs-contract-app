class JobModel {
  final String id;
  final String title;
  final String description;
  final String company;
  final String employmentType;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.employmentType,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    company: json["company"],
    employmentType: json["employmentType"],
  );
}
