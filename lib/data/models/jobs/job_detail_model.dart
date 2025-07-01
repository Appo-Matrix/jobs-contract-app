class JobDetailModel {
  final String id;
  final String jobTitle;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int? salary;
  final String? location;
  final String? date;

  JobDetailModel({
    required this.id,
    required this.jobTitle,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.salary,
    this.location,
    this.date,
  });

  factory JobDetailModel.fromJson(Map<String, dynamic> json) {
    return JobDetailModel(
      id: json['_id'],
      jobTitle: json['jobTitle'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      salary: json['salary'],
      location: json['location'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'description': description,
      'salary': salary,
      'location': location,
      'date': date,
    };
  }
}
