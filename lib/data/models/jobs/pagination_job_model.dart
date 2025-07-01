import 'package:job_contracts/data/models/jobs/pagination_info.dart';

import 'job_list_item_model.dart';

class PaginatedJobsModel {
  final List<JobListItemModel> jobs;
  final PaginationInfo pagination;

  PaginatedJobsModel({
    required this.jobs,
    required this.pagination,
  });

  factory PaginatedJobsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedJobsModel(
      jobs: List<JobListItemModel>.from(json['jobs'].map((x) => JobListItemModel.fromJson(x))),
      pagination: PaginationInfo.fromJson(json['pagination']),
    );
  }
}
