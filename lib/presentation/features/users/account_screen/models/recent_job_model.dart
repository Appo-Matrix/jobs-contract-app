class RecentJobModel {
  final String id;
  final String postedBy;
  final String title;
  final String description;
  final String jobType;
  final String jobDuration;
  final String jobCategory;
  final List<RecentJobSkill> skillsRequired;
  final String attachment;
  final String experience;
  final String salary;
  final bool deletedByAdmin;
  final bool deletedByClient;
  final String jobStatus;
  final RecentJobLocation jobLocation;
  final String createdAt;
  final String updatedAt;

  RecentJobModel({
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
    required this.jobLocation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecentJobModel.fromJson(Map<String, dynamic> json) {
    return RecentJobModel(
      id: json['_id'] ?? '',
      postedBy: json['postedBy'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      jobType: json['jobType'] ?? '',
      jobDuration: json['jobDuration'] ?? '',
      jobCategory: json['jobCategory'] ?? '',
      skillsRequired: (json['skillsRequired'] as List<dynamic>? ?? [])
          .map((s) => RecentJobSkill.fromJson(s))
          .toList(),
      attachment: json['attachment'] ?? '',
      experience: json['experience'] ?? '',
      salary: json['salary'] ?? '',
      deletedByAdmin: json['deletedByAdmin'] ?? false,
      deletedByClient: json['deletedByClient'] ?? false,
      jobStatus: json['jobStatus'] ?? '',
      jobLocation: RecentJobLocation.fromJson(
          json['jobLocation'] ?? {'type': 'Point', 'coordinates': []}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'postedBy': postedBy,
      'title': title,
      'description': description,
      'jobType': jobType,
      'jobDuration': jobDuration,
      'jobCategory': jobCategory,
      'skillsRequired': skillsRequired.map((s) => s.toJson()).toList(),
      'attachment': attachment,
      'experience': experience,
      'salary': salary,
      'deletedByAdmin': deletedByAdmin,
      'deletedByClient': deletedByClient,
      'jobStatus': jobStatus,
      'jobLocation': jobLocation.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class RecentJobSkill {
  final String id;
  final String name;

  RecentJobSkill({required this.id, required this.name});

  factory RecentJobSkill.fromJson(Map<String, dynamic> json) {
    return RecentJobSkill(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name};
}

class RecentJobLocation {
  final String type;
  final List<double> coordinates;

  RecentJobLocation({required this.type, required this.coordinates});

  factory RecentJobLocation.fromJson(Map<String, dynamic> json) {
    return RecentJobLocation(
      type: json['type'] ?? 'Point',
      coordinates: (json['coordinates'] as List<dynamic>? ?? [])
          .map((c) => (c as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates,
  };

  /// Returns a human-readable location string
  String toLocationString() {
    if (coordinates.length >= 2) {
      return 'Lat: ${coordinates[1].toStringAsFixed(2)}, Lng: ${coordinates[0].toStringAsFixed(2)}';
    }
    return 'Location not available';
  }
}

class RecentJobResponse {
  final String status;
  final String message;
  final List<RecentJobModel> data;

  RecentJobResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RecentJobResponse.fromJson(Map<String, dynamic> json) {
    return RecentJobResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((j) => RecentJobModel.fromJson(j))
          .toList(),
    );
  }
}