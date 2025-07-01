class JobMetricsModel {
  final int totalJobs;
  final int totalOffers;
  final int totalAcceptedJobs;
  final double revenueEarned;
  final String cancelRate;

  JobMetricsModel({
    required this.totalJobs,
    required this.totalOffers,
    required this.totalAcceptedJobs,
    required this.revenueEarned,
    required this.cancelRate,
  });

  factory JobMetricsModel.fromJson(Map<String, dynamic> json) {
    return JobMetricsModel(
      totalJobs: json['totalJobs'],
      totalOffers: json['totalOffers'],
      totalAcceptedJobs: json['totalAcceptedJobs'],
      revenueEarned: (json['revenueEarned'] as num).toDouble(),
      cancelRate: json['cancelRate'],
    );
  }
}
