class RecentJobModel {
  final String id;
  final String title;
  final String description;
  final String company;
  final String location;
  final int salary;
  final String createdAt;

  RecentJobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.salary,
    required this.createdAt,
  });

  factory RecentJobModel.fromJson(Map<String, dynamic> json) {
    return RecentJobModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      company: json['company'],
      location: json['location'],
      salary: json['salary'],
      createdAt: json['createdAt'],
    );
  }
}
