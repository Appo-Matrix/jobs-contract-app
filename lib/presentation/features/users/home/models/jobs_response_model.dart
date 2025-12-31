// lib/models/jobs_response_model.dart



import 'job_model.dart';

class JobsResponseModel {
  final List<AllJobModel> jobs;
  final int totalCount;
  final int currentPage;
  final int totalPages;

  JobsResponseModel({
    required this.jobs,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
  });

  factory JobsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final jobsList = (data['jobs'] as List?)?.map((e) => AllJobModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
    final pagination = data['pagination'] as Map<String, dynamic>? ?? {};

    return JobsResponseModel(
      jobs: jobsList,
      totalCount: (pagination['totalJobs'] as num?)?.toInt() ?? 0,
      currentPage: int.tryParse(pagination['currentPage'].toString()) ?? 1,
      totalPages: (pagination['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
