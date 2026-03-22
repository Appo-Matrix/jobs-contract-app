// class JobApplicationResponse {
//   final bool success;
//   final int count;
//   final List<dynamic> data; // You can replace dynamic with a concrete model later
//
//   JobApplicationResponse({
//     required this.success,
//     required this.count,
//     required this.data,
//   });
//
//   factory JobApplicationResponse.fromJson(Map<String, dynamic> json) {
//     return JobApplicationResponse(
//       success: json['success'],
//       count: json['count'],
//       data: json['data'], // optionally parse data into List<JobApplicationModel>
//     );
//   }
// }


// job_application_response.dart
// ─────────────────────────────────────────────────────────────────────────────
// Response model for GET /applications/my and GET /applications/job/:id
// ─────────────────────────────────────────────────────────────────────────────

class JobApplicationResponse {
  final bool success;
  final int count;
  final List<MyJobApplication> data; // ✅ typed — NOT List<dynamic>

  JobApplicationResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory JobApplicationResponse.fromJson(Map<String, dynamic> json) {
    return JobApplicationResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      // ✅ Safe cast — each item in data[] must be Map<String, dynamic>
      data: (json['data'] as List? ?? [])
          .whereType<Map>()  // filter out any non-map items safely
          .map((e) => MyJobApplication.fromJson(
          Map<String, dynamic>.from(e)))  // ✅ force correct type
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single application item inside data[]
// ─────────────────────────────────────────────────────────────────────────────

class MyJobApplication {
  final String id;
  final ApplicationJob jobId;
  final String userId;
  final String coverLetter;
  final num estimatedServiceCost;
  final String estimatedCompletionTime;
  final String createdAt;
  final String updatedAt;

  MyJobApplication({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.coverLetter,
    required this.estimatedServiceCost,
    required this.estimatedCompletionTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyJobApplication.fromJson(Map<String, dynamic> json) {
    return MyJobApplication(
      id: json['_id']?.toString() ?? '',
      // ✅ Safe cast jobId — could be Map or String (if not populated)
      jobId: json['jobId'] is Map
          ? ApplicationJob.fromJson(
          Map<String, dynamic>.from(json['jobId'] as Map))
          : ApplicationJob.empty(),
      userId: json['userId']?.toString() ?? '',
      coverLetter: json['coverLetter']?.toString() ?? '',
      estimatedServiceCost: json['estimatedServiceCost'] ?? 0,
      estimatedCompletionTime:
      json['estimatedCompletionTime']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Nested job inside the application
// ─────────────────────────────────────────────────────────────────────────────

class ApplicationJob {
  final String id;
  final String postedBy;
  final String title;
  final String description;
  final String jobType;
  final String jobDuration;
  final String jobCategory;
  final List<ApplicationJobSkill> skillsRequired;
  final String attachment;
  final String experience;
  final String salary;
  final bool deletedByAdmin;
  final bool deletedByClient;
  final String jobStatus;
  final ApplicationJobLocation? jobLocation;
  final String createdAt;
  final String updatedAt;

  ApplicationJob({
    required this.id,
    required this.postedBy,
    required this.title,
    required this.description,
    required this.jobType,
    required this.jobDuration,
    required this.jobCategory,
    required this.skillsRequired,
    required this.attachment,
    required this.experience,
    required this.salary,
    required this.deletedByAdmin,
    required this.deletedByClient,
    required this.jobStatus,
    this.jobLocation,
    required this.createdAt,
    required this.updatedAt,
  });

  // ✅ Empty factory for when jobId is not populated (just a string ID)
  factory ApplicationJob.empty() {
    return ApplicationJob(
      id: '', postedBy: '', title: 'Job not found',
      description: '', jobType: '', jobDuration: '',
      jobCategory: '', skillsRequired: [], attachment: '',
      experience: '', salary: '', deletedByAdmin: false,
      deletedByClient: false, jobStatus: '', jobLocation: null,
      createdAt: '', updatedAt: '',
    );
  }

  factory ApplicationJob.fromJson(Map<String, dynamic> json) {
    return ApplicationJob(
      id: json['_id']?.toString() ?? '',
      postedBy: json['postedBy']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      jobType: json['jobType']?.toString() ?? '',
      jobDuration: json['jobDuration']?.toString() ?? '',
      jobCategory: json['jobCategory']?.toString() ?? '',
      // ✅ Safe cast skillsRequired items
      skillsRequired: (json['skillsRequired'] as List? ?? [])
          .whereType<Map>()
          .map((e) => ApplicationJobSkill.fromJson(
          Map<String, dynamic>.from(e)))
          .toList(),
      attachment: json['attachment']?.toString() ?? '',
      experience: json['experience']?.toString() ?? '',
      salary: json['salary']?.toString() ?? '',
      deletedByAdmin: json['deletedByAdmin'] ?? false,
      deletedByClient: json['deletedByClient'] ?? false,
      jobStatus: json['jobStatus']?.toString() ?? '',
      // ✅ Safe cast jobLocation
      jobLocation: json['jobLocation'] is Map
          ? ApplicationJobLocation.fromJson(
          Map<String, dynamic>.from(json['jobLocation'] as Map))
          : null,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Skill inside skillsRequired[]
// ─────────────────────────────────────────────────────────────────────────────

class ApplicationJobSkill {
  final String id;
  final String name;

  ApplicationJobSkill({required this.id, required this.name});

  factory ApplicationJobSkill.fromJson(Map<String, dynamic> json) {
    return ApplicationJobSkill(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// jobLocation with GeoJSON coordinates [lng, lat]
// ─────────────────────────────────────────────────────────────────────────────

class ApplicationJobLocation {
  final String type;
  final List<double> coordinates;

  ApplicationJobLocation({required this.type, required this.coordinates});

  factory ApplicationJobLocation.fromJson(Map<String, dynamic> json) {
    return ApplicationJobLocation(
      type: json['type']?.toString() ?? 'Point',
      // ✅ Safe cast coordinates — each element could be int or double
      coordinates: (json['coordinates'] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  String get displayString {
    if (coordinates.length >= 2) {
      return 'Lat: ${coordinates[1].toStringAsFixed(2)}, '
          'Lng: ${coordinates[0].toStringAsFixed(2)}';
    }
    return 'Location not available';
  }
}