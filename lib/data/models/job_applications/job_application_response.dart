class JobApplicationResponse {
  final bool success;
  final int count;
  final List<dynamic> data; // You can replace dynamic with a concrete model later

  JobApplicationResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory JobApplicationResponse.fromJson(Map<String, dynamic> json) {
    return JobApplicationResponse(
      success: json['success'],
      count: json['count'],
      data: json['data'], // optionally parse data into List<JobApplicationModel>
    );
  }
}
