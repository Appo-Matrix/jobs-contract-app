class PaginationInfo {
  final int totalJobs;
  final int totalPages;
  final int currentPage;
  final int limit;

  PaginationInfo({
    required this.totalJobs,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      totalJobs: json['totalJobs'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      limit: json['limit'],
    );
  }
}
