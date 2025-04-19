class JobPosting {
  final String jobTitle;
  final String description;
  final String salary;
  final String category;
  final String jobType;
  final String duration;
  final String employerName;
  final String location;
  final String postedTime;
  final bool isVerified;
  final String? employerImage;

  JobPosting({
    required this.jobTitle,
    required this.description,
    required this.salary,
    required this.category,
    required this.jobType,
    required this.duration,
    required this.employerName,
    required this.location,
    required this.postedTime,
    required this.isVerified,
    this.employerImage,
  });
}
