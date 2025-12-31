class AllJobModel {
  final String id;
  final String title;
  final String location;
  final String workType;
  final String salary;
  final String category;
  final String duration;
  final List<String> skills;
  final String experience;
  final String postedAgo;
  final String? description;
  final String? postedBy;
  final String? jobStatus;
  final DateTime? createdAt;

  AllJobModel({
    required this.id,
    required this.title,
    required this.location,
    required this.workType,
    required this.salary,
    required this.category,
    required this.duration,
    required this.skills,
    required this.experience,
    required this.postedAgo,
    this.description,
    this.postedBy,
    this.jobStatus,
    this.createdAt,
  });

  factory AllJobModel.fromJson(Map<String, dynamic> json) {
    // Extract skills from skillsRequired array
    List<String> extractedSkills = [];
    if (json['skillsRequired'] is List) {
      extractedSkills = (json['skillsRequired'] as List)
          .map((skill) => skill['name'] as String? ?? '')
          .where((name) => name.isNotEmpty)
          .toList();
    }

    // Extract location from jobLocation
    String extractedLocation = 'Remote';
    if (json['jobLocation'] is Map) {
      final location = json['jobLocation'] as Map<String, dynamic>;
      if (location['coordinates'] is List && location['coordinates'].length >= 2) {
        extractedLocation = 'Location: ${location['coordinates'][0]}, ${location['coordinates'][1]}';
      }
    }

    // Calculate postedAgo from createdAt
    String postedAgo = 'Recently';
    if (json['createdAt'] != null) {
      try {
        final createdDate = DateTime.parse(json['createdAt'] as String);
        final now = DateTime.now();
        final difference = now.difference(createdDate);

        if (difference.inDays > 0) {
          postedAgo = '${difference.inDays} days ago';
        } else if (difference.inHours > 0) {
          postedAgo = '${difference.inHours} hours ago';
        } else if (difference.inMinutes > 0) {
          postedAgo = '${difference.inMinutes} minutes ago';
        } else {
          postedAgo = 'Just now';
        }
      } catch (e) {
        postedAgo = 'Recently';
      }
    }

    return AllJobModel(
      id: json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      location: extractedLocation,
      workType: json['jobType'] as String? ?? 'Unknown',
      salary: json['salary'] as String? ?? 'Negotiable',
      category: json['jobCategory'] as String? ?? 'General',
      duration: json['jobDuration'] as String? ?? 'TBD',
      skills: extractedSkills,
      experience: json['experience'] as String? ?? 'Not specified',
      postedAgo: postedAgo,
      description: json['description'] as String?,
      postedBy: json['postedBy'] as String?,
      jobStatus: json['jobStatus'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'workType': workType,
      'salary': salary,
      'category': category,
      'duration': duration,
      'skills': skills,
      'experience': experience,
      'postedAgo': postedAgo,
      'description': description,
      'postedBy': postedBy,
      'jobStatus': jobStatus,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}