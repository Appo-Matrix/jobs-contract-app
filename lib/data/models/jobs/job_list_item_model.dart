// pagination_job_model.dart
class PaginationModel {
  final int totalJobs;
  final int totalPages;
  final int currentPage;
  final int limit;

  PaginationModel({
    required this.totalJobs,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    // Helper function to safely convert any type to int
    int _toInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return PaginationModel(
      totalJobs: _toInt(json['totalJobs']),
      totalPages: _toInt(json['totalPages']),
      currentPage: _toInt(json['currentPage']),
      limit: _toInt(json['limit']),
    );
  }
}

// job_skill_model.dart
class JobSkill {
  final String name;
  final String id;

  JobSkill({
    required this.name,
    required this.id,
  });

  factory JobSkill.fromJson(Map<String, dynamic> json) {
    return JobSkill(
      name: json['name'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

// job_location_model.dart
class JobLocation {
  final String type;
  final List<double> coordinates; // Changed from List<int> to List<double>

  JobLocation({
    required this.type,
    required this.coordinates,
  });

  factory JobLocation.fromJson(Map<String, dynamic> json) {
    return JobLocation(
      type: json['type'] ?? 'Point',
      // Safely convert all coordinates to double
      coordinates: json['coordinates'] != null
          ? List<double>.from(
        (json['coordinates'] as List).map(
              (coord) => (coord as num).toDouble(),
        ),
      )
          : [0.0, 0.0],
    );
  }
}

// job_list_item_model.dart
class JobListItemModel {
  final String id;
  final String title;
  final String description;
  final String jobType;
  final String jobDuration;
  final String jobCategory;
  final String experience;
  final String salary;
  final String jobStatus;
  final List<JobSkill> skillsRequired;
  final JobLocation jobLocation;
  final String attachment;
  final String createdAt;
  final String updatedAt;

  JobListItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.jobType,
    required this.jobDuration,
    required this.jobCategory,
    required this.experience,
    required this.salary,
    required this.jobStatus,
    required this.skillsRequired,
    required this.jobLocation,
    required this.attachment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobListItemModel.fromJson(Map<String, dynamic> json) {
    return JobListItemModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      jobType: json['jobType'] ?? '',
      jobDuration: json['jobDuration'] ?? '',
      jobCategory: json['jobCategory'] ?? '',
      experience: json['experience'] ?? '',
      salary: json['salary'] ?? '',
      jobStatus: json['jobStatus'] ?? 'open',
      skillsRequired: json['skillsRequired'] != null
          ? List<JobSkill>.from(
        (json['skillsRequired'] as List).map(
              (skill) => JobSkill.fromJson(skill),
        ),
      )
          : [],
      jobLocation: json['jobLocation'] != null
          ? JobLocation.fromJson(json['jobLocation'] as Map<String, dynamic>)
          : JobLocation(type: 'Point', coordinates: [0.0, 0.0]),
      attachment: json['attachment'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

// paginated_jobs_model.dart
class PaginatedJobsModel {
  final List<JobListItemModel> jobs;
  final PaginationModel pagination;

  PaginatedJobsModel({
    required this.jobs,
    required this.pagination,
  });

  factory PaginatedJobsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedJobsModel(
      jobs: json['jobs'] != null
          ? List<JobListItemModel>.from(
        (json['jobs'] as List).map(
              (job) => JobListItemModel.fromJson(job as Map<String, dynamic>),
        ),
      )
          : [],
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : PaginationModel(
        totalJobs: 0,
        totalPages: 0,
        currentPage: 1,
        limit: 10,
      ),
    );
  }
}

// api_response_model.dart
class JobApiResponse {
  final String status;
  final String message;
  final PaginatedJobsModel data;

  JobApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory JobApiResponse.fromJson(Map<String, dynamic> json) {
    return JobApiResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? PaginatedJobsModel.fromJson(json['data'] as Map<String, dynamic>)
          : PaginatedJobsModel(
        jobs: [],
        pagination: PaginationModel(
          totalJobs: 0,
          totalPages: 0,
          currentPage: 1,
          limit: 10,
        ),
      ),
    );
  }
}



// // pagination_job_model.dart
// class PaginationModel {
//   final int totalJobs;
//   final int totalPages;
//   final String currentPage;
//   final int limit;
//
//   PaginationModel({
//     required this.totalJobs,
//     required this.totalPages,
//     required this.currentPage,
//     required this.limit,
//   });
//
//   factory PaginationModel.fromJson(Map<String, dynamic> json) {
//     return PaginationModel(
//       totalJobs: json['totalJobs'] ?? 0,
//       totalPages: json['totalPages'] ?? 0,
//       currentPage: json['currentPage']?.toString() ?? '1',
//       limit: json['limit'] ?? 10,
//     );
//   }
// }
//
// // job_skill_model.dart
// class JobSkill {
//   final String name;
//   final String id;
//
//   JobSkill({
//     required this.name,
//     required this.id,
//   });
//
//   factory JobSkill.fromJson(Map<String, dynamic> json) {
//     return JobSkill(
//       name: json['name'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }
// }
//
// // job_location_model.dart
// class JobLocation {
//   final String type;
//   final List<int> coordinates;
//
//   JobLocation({
//     required this.type,
//     required this.coordinates,
//   });
//
//   factory JobLocation.fromJson(Map<String, dynamic> json) {
//     return JobLocation(
//       type: json['type'] ?? 'Point',
//       coordinates: List<int>.from(json['coordinates'] ?? [0.0, 0.0]),
//     );
//   }
// }
//
// // job_list_item_model.dart
// class JobListItemModel {
//   final String id;
//   final String title;
//   final String description;
//   final String jobType;
//   final String jobDuration;
//   final String jobCategory;
//   final String experience;
//   final String salary;
//   final String jobStatus;
//   final List<JobSkill> skillsRequired;
//   final JobLocation jobLocation;
//   final String attachment;
//   final String createdAt;
//   final String updatedAt;
//
//   JobListItemModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.jobType,
//     required this.jobDuration,
//     required this.jobCategory,
//     required this.experience,
//     required this.salary,
//     required this.jobStatus,
//     required this.skillsRequired,
//     required this.jobLocation,
//     required this.attachment,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory JobListItemModel.fromJson(Map<String, dynamic> json) {
//     return JobListItemModel(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       jobType: json['jobType'] ?? '',
//       jobDuration: json['jobDuration'] ?? '',
//       jobCategory: json['jobCategory'] ?? '',
//       experience: json['experience'] ?? '',
//       salary: json['salary'] ?? '',
//       jobStatus: json['jobStatus'] ?? 'open',
//       skillsRequired: json['skillsRequired'] != null
//           ? List<JobSkill>.from(
//         (json['skillsRequired'] as List).map(
//               (skill) => JobSkill.fromJson(skill),
//         ),
//       )
//           : [],
//       jobLocation: JobLocation.fromJson(json['jobLocation'] ?? {}),
//       attachment: json['attachment'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }
// }
//
// // paginated_jobs_model.dart
// class PaginatedJobsModel {
//   final List<JobListItemModel> jobs;
//   final PaginationModel pagination;
//
//   PaginatedJobsModel({
//     required this.jobs,
//     required this.pagination,
//   });
//
//   factory PaginatedJobsModel.fromJson(Map<String, dynamic> json) {
//     return PaginatedJobsModel(
//       jobs: json['jobs'] != null
//           ? List<JobListItemModel>.from(
//         (json['jobs'] as List).map(
//               (job) => JobListItemModel.fromJson(job),
//         ),
//       )
//           : [],
//       pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
//     );
//   }
// }
//
// // api_response_model.dart
// class JobApiResponse {
//   final String status;
//   final String message;
//   final PaginatedJobsModel data;
//
//   JobApiResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory JobApiResponse.fromJson(Map<String, dynamic> json) {
//     return JobApiResponse(
//       status: json['status'] ?? '',
//       message: json['message'] ?? '',
//       data: PaginatedJobsModel.fromJson(json['data'] ?? {}),
//     );
//   }
// }

