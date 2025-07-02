class ReportedJobModel {
  final String id;
  final JobDetails jobId;
  final UserDetails userId;

  ReportedJobModel({
    required this.id,
    required this.jobId,
    required this.userId,
  });

  factory ReportedJobModel.fromJson(Map<String, dynamic> json) {
    return ReportedJobModel(
      id: json['_id'],
      jobId: JobDetails.fromJson(json['jobId']),
      userId: UserDetails.fromJson(json['userId']),
    );
  }
}

class JobDetails {
  final String id;
  final String title;

  JobDetails({required this.id, required this.title});

  factory JobDetails.fromJson(Map<String, dynamic> json) {
    return JobDetails(
      id: json['_id'],
      title: json['title'],
    );
  }
}

class UserDetails {
  final String id;
  final String name;
  final String email;

  UserDetails({required this.id, required this.name, required this.email});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
