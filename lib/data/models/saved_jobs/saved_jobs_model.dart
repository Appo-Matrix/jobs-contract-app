class SavedJobModel {
  final String id;
  final String userId;
  final JobDetail job;

  SavedJobModel({
    required this.id,
    required this.userId,
    required this.job,
  });

  factory SavedJobModel.fromJson(Map<String, dynamic> json) {
    return SavedJobModel(
      id: json['_id'],
      userId: json['userId'],
      job: JobDetail.fromJson(json['jobId']),
    );
  }
}

class JobDetail {
  final String id;
  final String title;
  final String company;
  final String location;
  final String postedAt;

  JobDetail({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.postedAt,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
      id: json['_id'],
      title: json['title'],
      company: json['company'],
      location: json['location'],
      postedAt: json['postedAt'],
    );
  }
}
