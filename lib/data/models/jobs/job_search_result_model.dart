class JobSearchResultModel {
  final String id;

  JobSearchResultModel({required this.id});

  factory JobSearchResultModel.fromJson(Map<String, dynamic> json) {
    return JobSearchResultModel(
      id: json['_id'],
    );
  }
}
